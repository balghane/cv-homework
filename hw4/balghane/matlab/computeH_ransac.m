function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.

%Q2.2.3

%%%

locs1_orig = locs1;
locs2_orig = locs2;

mx1 = mean(locs1(1, :));
my1 = mean(locs1(2, :));
mx2 = mean(locs2(1, :));
my2 = mean(locs2(2, :));

Tr1 = [1 0 -mx1 ; 0 1 -my1 ; 0 0 1];
Tr2 = [1 0 -mx2 ; 0 1 -my2 ; 0 0 1];

locs1(1, :) = locs1(1, :) - mx1;
locs1(2, :) = locs1(2, :) - my1;
locs2(1, :) = locs2(1, :) - mx2;
locs2(2, :) = locs2(2, :) - my2;

m1 = 1 / sqrt(2 * max(locs1(1, :) .* locs1(1, :) + locs1(2, :) .* locs1(2, :)));
m2 = 1 / sqrt(2 * max(locs2(1, :) .* locs2(1, :) + locs2(2, :) .* locs2(2, :)));

S1 = [m1, 0, 0; 0, m1, 0; 0, 0, 1];
S2 = [m2, 0, 0; 0, m2, 0; 0, 0, 1];

T1 = S1 * Tr1;
T2 = S2 * Tr2;

locs1 = locs1 * m1;
locs2 = locs2 * m2;

n_matches = size(locs1, 2);
iterations = 10000;
one_pad = ones(1, n_matches);
locs1_padded = [locs1_orig ; one_pad];
locs2_padded = [locs2_orig ; one_pad];
epsilon = 0.001;

best_H = zeros(3, 3);
best_n_inliers = 0;
best_inliers = zeros(n_matches, 1);

for i = 1:iterations
    inds = randperm(n_matches,4);
    n_inliers = 0;
    inliers = zeros(n_matches, 1);
    
    % inds
    locs1_input = locs1(:, inds);
    locs2_input = locs2(:, inds);
    H = computeH(locs1_input, locs2_input);
    
    % after the homography, don't denormalize
    % so error can be normalized
    % makes selecting epsilon more stable
    H_denorm = H * T1;
    locs1_tr = H_denorm * locs1_padded;
    for j = 1:n_matches
        locs1_tr(:, j) = locs1_tr(:, j) / locs1_tr(3, j);
    end
    
    err = locs1_tr - T2 * locs2_padded;
    
    for j = 1:n_matches
        err_j = mean(abs(err(:, j)));
        if err_j < epsilon
            n_inliers = n_inliers + 1;
            inliers(j) = 1;
        end
    end
    
    if n_inliers > best_n_inliers
        best_H = T2 \ H_denorm;
        best_n_inliers = n_inliers;
        best_inliers = inliers;
    end
end

bestH2to1 = best_H;
inliers = best_inliers;

end

