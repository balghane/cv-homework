function r = invRodrigues(R)
% invRodrigues
% Input:
%   R: 3x3 rotation matrix
% Output:
%   r: 3x1 vector

A = (R - R') / 2;
rho = [A(3,2) ; A(1,3) ; A(2,1)];
s = norm(rho);
c = (R(1,1) + R(2,2) + R(3,3) - 1)/2;
u = rho / s;
theta = atan2(s, c);
r = (-u*theta)';

end