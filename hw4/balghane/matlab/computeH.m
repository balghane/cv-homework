function [H2to1] = computeH(p1, p2)
% inputs:
% p1 and p2 should be 2 x N matrices of corresponding (x, y)' coordinates between two images
%
% outputs:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation

%%%

num_matches = size(p1, 2);
A = zeros(num_matches*2, 9);
for i = 1:num_matches
    p1i = p1(:, i);
    p2i = p2(:, i);
    A(2*i-1, :) = [p1i(1) p1i(2) 1 0 0 0 -p1i(1)*p2i(1) -p1i(2)*p2i(1) -p2i(1)];
    A(2*i  , :) = [0 0 0 p1i(1) p1i(2) 1 -p1i(1)*p2i(2) -p1i(2)*p2i(2) -p2i(2)];
end
% A
[~,~,V] = svd(A);

% V
% V(:, 9)
% U
H2to1 = (reshape(V(:,9), 3, 3)).';
end