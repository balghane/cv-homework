function [ F ] = sevenpoint( pts1, pts2, M )
% sevenpoint:
%   pts1 - 7x2 matrix of (x,y) coordinates
%   pts2 - 7x2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.2:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save recovered F (either 1 or 3 in cell), M, pts1, pts2 to q2_2.mat

%     Write recovered F and display the output of displayEpipolarF in your writeup

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

% get null spaces
f12 = null(A);
f1 = reshape(f12(:, 1), 3, 3)';
f2 = reshape(f12(:, 2), 3, 3)';

% solve for alpha to get F
syms alpha_f;
F = alpha_f*f1 + (1-alpha_f)*f2;
detF = det(F);
alpha_f = double(vpa(solve(detF, alpha_f)));

F = {};
n_sols = 1;

for i = 1:3
    if abs(imag(alpha_f(i))) < 0.001
        F_norm = alpha_f(i)*f1 + (1-alpha_f(i))*f2;
        F{n_sols} = (trans'*F_norm*trans)';
        n_sols = n_sols + 1;
    end
end

end

