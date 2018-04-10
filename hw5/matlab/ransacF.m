function [ F, inliers ] = ransacF( pts1, pts2, M )
% ransacF:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q5.1:
%     Implement RANSAC
%     Generate a matrix F from some '../data/some_corresp_noisy.mat'
%          - using eightpoint
%          - using ransac

%     In your writeup, describe your algorithm, how you determined which
%     points are inliers, and any other optimizations you made

n_pts = size(pts1, 1);
pts1_padded = [pts1 ones(n_pts, 1)];
pts2_padded = [pts2 ones(n_pts, 1)];

best_F = zeros(3, 3);
best_n_inliers = 0;
best_inliers = zeros(n_pts, 1);
n_its = 20000;
epsilon = 0.005;

for i = 1:n_its
    inds = randperm(n_pts,100);
    cur_pts1 = pts1(inds, :);
    cur_pts2 = pts2(inds, :);
    F = eightpoint( cur_pts1, cur_pts2, M );
    
    n_inliers = 0;
    inliers = zeros(n_pts, 1);
    
    for j = 1:n_pts
        err = pts2_padded(j, :) * F' * pts1_padded(j, :)';
        if abs(err) < epsilon
            n_inliers = n_inliers + 1;
            inliers(j) = 1;
        end
    end
    
    if n_inliers > best_n_inliers
        best_F = F;
        best_n_inliers = n_inliers;
        best_inliers = inliers;
        
        %disp('errs')
        %for k = 1:12
        %    ind = inds(k);
        %    pts2_padded(ind, :) * F' * pts1_padded(ind, :)'
        %end
    end
    
end

best_n_inliers / n_pts
inliers = best_inliers;
F = best_F

end

