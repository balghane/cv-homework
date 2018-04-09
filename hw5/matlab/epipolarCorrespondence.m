function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

% Q4.1:
%           Implement a method to compute (x2,y2) given (x1,y1)
%           Use F to only scan along the epipolar line
%           Experiment with different window sizes or weighting schemes
%           Save F, pts1, and pts2 used to generate view to q4_1.mat
%
%           Explain your methods and optimization in your writeup

n_pts = size(x1, 1);
x2 = zeros(n_pts, 1);
y2 = zeros(n_pts, 1);
[sy,sx]= size(im2);

for i = 1:n_pts
  v(1) = x1(i);
  v(2) = y1(i);
  v(3) = 1;

  % code adapted from displayEpipolarF.m
  l = F * v';
  s = sqrt(l(1)^2+l(2)^2);
  l = l/s;
  if l(1) ~= 0
    y_all = 1:sy;
    x_all = round(-(l(2) * y_all + l(3))/l(1));
    %ye = sy;
    %ys = 1;
    %xe = -(l(2) * ye + l(3))/l(1);
    %xs = -(l(2) * ys + l(3))/l(1);
  else
    x_all = 1:sx;
    y_all = round(-(l(1) * x_all + l(3))/l(2));
    %xe = sx;
    %xs = 1;
    %ye = -(l(1) * xe + l(3))/l(2);
    %ys = -(l(1) * xs + l(3))/l(2);
  end
  % code adapted from displayEpipolarF.m

  candidate_points = [x_all' y_all'];
  [x2(i), y2(i)] = find_match(x1(i), y1(i), im1, im2, candidate_points);
  
end

end

