function [ P, err ] = triangulate( C1, p1, C2, p2 )
% triangulate:
%       C1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       C2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

%       P - Nx3 matrix of 3D coordinates
%       err - scalar of the reprojection error

% Q4.2:
%       Implement a triangulation algorithm to compute the 3d locations
%

n_pts = size(p1, 1);
A = zeros(4, 4);
P = zeros(n_pts, 3);

C11 = C1(1, :);
C12 = C1(2, :);
C13 = C1(3, :);
C21 = C2(1, :);
C22 = C2(2, :);
C23 = C2(3, :);

tot_err = 0;

for i = 1:n_pts
    x1 = p1(i, 1);
    y1 = p1(i, 2);
    x2 = p2(i, 1);
    y2 = p2(i, 2);
    
    A(1, :) = x1*C13 - C11;
    A(2, :) = y1*C13 - C12;
    A(3, :) = x2*C23 - C21;
    A(4, :) = y2*C23 - C22;
    
    [~,~,V] = svd(A);
    pt = V(:,end).';
    pt = pt/pt(4);
    P(i, :) = pt(1:3);
    
    p1_proj_back = C1*pt';
    p1_proj_back = p1_proj_back / p1_proj_back(3);
    p2_proj_back = C2*pt';
    p2_proj_back = p2_proj_back / p2_proj_back(3);
    
    err1 = norm(p1_proj_back - [p1(i, :) 1]');
    err2 = norm(p2_proj_back - [p2(i, :) 1]');
    tot_err = tot_err + err1.^2 + err2.^2;
end

err = tot_err;

end
