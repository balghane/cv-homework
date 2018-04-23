function [u,v] = LucasKanadeInverseCompositional(It, It1, rect)

% input - image at time t, image at t+1, rectangle (top left, bot right coordinates)
% output - movement vector, [u, v] in the x- and y-directions.

Rin = imref2d(size(It));
%x_shift = mod(rect(1), 1);
%y_shift = mod(rect(2), 1);
%initial_shift = [1 0 x_shift ; 0 1 y_shift ; 0 0 1]';
%initial_shift_tform = affine2d(initial_shift);
%It_init = imwarp(It, initial_shift_tform, 'OutputView', Rin);
% rect = floor(rect);

% compute image gradient
[I_x,I_y] = imgradientxy(It);

% evaluate jacobian
jacobian = eye(2);

% compute Hessian
H = 0;
for i = rect(2):rect(4)
    for j = rect(1):rect(3)
        temp = [I_x(i, j)  I_y(i, j)] * jacobian;
        H = H + temp' * temp;
    end
end
H_inv = inv(H);

epsilon = 0.005;
new_warp = zeros(2, 1);
delta_warp = ones(2, 1);
It1_warp = It1;

while(norm(delta_warp) > epsilon)
    err_im = It - It1_warp;
    temp = zeros(2, 1);
    for i = rect(2):rect(4)
        for j = rect(1):rect(3)
            temp = temp + (double(err_im(i, j)) * [I_x(i, j)  I_y(i, j)] * jacobian)';
        end
    end
    
    delta_warp = H_inv * temp;
    new_warp = new_warp - delta_warp;
    new_warp_33 = [1 0 new_warp(1) ; 0 1 new_warp(2) ; 0 0 1]';
    warp_form = affine2d(new_warp_33);
    
    It1_warp = imwarp(It1, warp_form, 'Linear', 'OutputView', Rin);
end

u = new_warp(1);
v = new_warp(2);

% scale_size = 4;

% figure, imshow(imresize(It(rect(2):rect(4), rect(1):rect(3)), scale_size, 'nearest'));
% figure, imshow(imresize(It1(rect(2):rect(4), rect(1):rect(3)), scale_size, 'nearest'));
% figure, imshow(imresize(It1_warp(rect(2):rect(4), rect(1):rect(3)), scale_size, 'nearest'));
% figure, imshow(err_im)

% figure, imshow(It)
% figure, imshow(It1)
% figure, imshow(It1_warp)