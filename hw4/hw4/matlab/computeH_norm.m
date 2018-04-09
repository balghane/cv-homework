function [H2to1] = computeH_norm(p1, p2)
% inputs:
% p1 and p2 should be 2 x N matrices of corresponding (x, y)' coordinates between two images
%
% outputs:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation

%%%

p1(1, :) = p1(1, :) / mean(p1(1, :));
p1(2, :) = p1(2, :) / mean(p1(2, :));
p2(1, :) = p2(1, :) / mean(p2(1, :));
p2(2, :) = p2(2, :) / mean(p2(2, :));

m1 = sqrt(2 * max(p1(1, :) .* p1(1, :) + p1(2, :) .* p1(2, :)));
m2 = sqrt(2 * max(p2(1, :) .* p2(1, :) + p2(2, :) .* p2(2, :)));

p1 = p1 / m1;
p2 = p2 / m2;

p1
p2

[H2to1] = computeH(p1, p2);

end