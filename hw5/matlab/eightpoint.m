function [ F ] = eightpoint( pts1, pts2, M )
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save F, M, pts1, pts2 to q2_1.mat

%     Write F and display the output of displayEpipolarF in your writeup

% make homogenous
num_pts = size(pts1, 1);
pts1 = [pts1 ones(num_pts, 1)];
pts2 = [pts2 ones(num_pts, 1)];

% normalize
trans = [1/M 0 0 ; 0 1/M 0 ; 0 0 1];
pts1 = pts1 * trans;
pts2 = pts2 * trans;

% set up A
A = zeros(num_pts, 9);
for i = 1:num_pts
    x1 =  pts1(i, 1);
    y1 =  pts1(i, 2);
    x2 =  pts2(i, 1);
    y2 =  pts2(i, 2);
    A(i, :) = [x1*x2 x1*y2 x1 y1*x2 y1*y2 y1 x2 y2 1];
end

% get F
[~,~,V] = svd(A);
F_norm = (reshape(V(:,9), 3, 3)).';

% make it rank 2
[u_prime,d_prime,v_prime] = svd(F_norm);
d_prime(3, 3) = 0;
F_norm_prime = u_prime * d_prime * v_prime.';

% denorm and output
F_prime = trans'*F_norm_prime*trans;
F = F_prime';

end

