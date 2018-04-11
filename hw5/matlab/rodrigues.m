function R = rodrigues(r)
% rodrigues:

% Input:
%   r - 3x1 vector
% Output:
%   R - 3x3 rotation matrix

theta = norm(r);

if abs(theta) < 0.0001
    R = eye(3);
    return
end

u = r / theta;
ux = [0 -u(3) u(2) ; u(3) 0 -u(1) ; -u(2) u(1) 0];

c1 = eye(3)*cos(theta);
c2 = (1-cos(theta))*(u'*u);
c3 = ux*sin(theta);

R = c1 + c2 + c3;
R = R';

end
