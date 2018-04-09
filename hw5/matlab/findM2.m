% Q3.3:
%       1. Load point correspondences
%       2. Obtain the correct M2
%       3. Save the correct M2, C2, p1, p2, R and P to q3_3.mat

load('../data/some_corresp.mat')
load('../data/intrinsics.mat')
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');

M = max(max(size(im1)),max(size(im2)));
F = eightpoint( pts1, pts2, M );
E = essentialMatrix(F, K1, K2);
M1 = zeros(3, 4); M1(1:3, 1:3) = eye(3);
[M2s] = camera2(E);
C1 = K1*M1;

for i = 1:4
    M2 = squeeze(M2s(:, :, i));
    C2 = K2*M2;
    [P, tot_err] = triangulate( C1, pts1, C2, pts2 );
    P_z = P(:, 3);
    if min(P_z) > 0
        break
    end
end

p1 = pts1;
p2 = pts2;

save('q3_3.mat', 'M2', 'C2', 'p1', 'p2', 'P');
save('for_4_2.mat', 'im1', 'im2', 'F', 'C1', 'C2', 'M1', 'M2');
