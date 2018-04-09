function [points] = getRandomPoints(I, alpha)
% Generates random points in the image
% Input:
%   I:                      grayscale image
%   alpha:                  random points
% Output:
%   points:                    point locations
%
    [h, w] = size(I);
    points = zeros(alpha, 2);
    points(:, 1) = randi([1 h],alpha,1);
    points(:, 2) = randi([1 w],alpha,1);

end

