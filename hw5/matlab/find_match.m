function [x, y] = find_match(x_in, y_in, im1, im2, candidate_points)
%UNTITLED Summary of this function goes here
%   x_in: double
%   y_in: double
%   im1: L x W x 3
%   im2: L x W x 3
%   candiate_points: n x 2

im1_gray = rgb2gray(im1);
im2_gray = rgb2gray(im2);
x_in = round(x_in);
y_in = round(y_in);

n_pts = size(candidate_points, 1);
wind_1d = 5; % window size in each direction

im1_gp = padarray(im1_gray,wind_1d,'replicate');
im2_gp = padarray(im2_gray,wind_1d,'replicate');

window_1 = im1_gp(y_in : y_in + 2*wind_1d,...
                  x_in : x_in + 2*wind_1d...
                  );
window_1d = double(window_1(:));
                    
best_dist = inf;
best_point = [0 0];

for i = 1:n_pts
    x_comp = candidate_points(i, 1);
    y_comp = candidate_points(i, 2);
    try
        window_2 = im2_gp(y_comp : y_comp + 2*wind_1d,...
                          x_comp : x_comp + 2*wind_1d...
                          );
        window_2d = double(window_2(:));
        dist = pdist([window_1d' ; window_2d']);
        if dist < best_dist
            best_dist = dist;
            best_point = [x_comp y_comp];
        end
    catch
    end
end

x = best_point(1);
y = best_point(2);

end

