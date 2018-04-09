function [points] = getHarrisPoints(I, alpha, k)
% Finds the corner points in an image using the Harris Corner detection algorithm
% Input:
%   I:                      grayscale image
%   alpha:                  number of points
%   k:                      Harris parameter
% Output:
%   points:                    point locations
%
    % -----fill in your implementation here --------
    [h, w] = size(I);
    
    [Gx,Gy] = imgradientxy(I);
    
    sums = ones(3);
    
    S_x2 = conv2(Gx .* Gx, sums, 'same');
    S_y2 = conv2(Gy .* Gy, sums, 'same');
    S_xy = conv2(Gx .* Gy, sums, 'same');

    det = S_x2 .* S_y2 - S_xy .* S_xy;
    tra = S_x2 + S_y2;
    R = det - k * tra .* tra;
    
    R = rescale(R);
    
    nms_size = 2;
    R_temp = padarray(R,[nms_size nms_size],'replicate');
    for i = 0:(nms_size*2)
        for j = 0:(nms_size*2)
            R(R_temp(1+i:h+i,1+j:w+j) > R) = 0;
        end
    end
    
    R_flat = reshape(R, h*w, 1);
    [~, ind] = maxk(R_flat, alpha);
    [I,J] = ind2sub([h, w],ind);
    
    points = [I J];
    % ------------------------------------------

end
