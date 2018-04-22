function [u,v] = LucasKanade(It, It1, rect)

% input - image at time t, image at t+1, rectangle (top left, bot right coordinates)
% output - movement vector, [u, v] in the x- and y-directions.

% compute image gradient
[I_x,I_y] = imgradientxy(It);

% compute Hessian
H = 0;
[h, w] = size(It);
for i = rect(2):rect(4)
    for j = rect(1):rect(3)
        temp = [I_x(2, 1)  I_y(2, 1)] * jacobian(i, j);
        H = H + temp' * temp;
    end
end

p = [1 0 0 ; 0 1 0 ; 0 0 1]';
p_form = affine2d(p);
Rin = imref2d(size(It));
epsilon = 1.0;
delta_p = ones(1, 6);
It1_warp = imwarp(It1, p_form, 'OutputView', Rin);

while(norm(delta_p) > epsilon)
    norm(delta_p)
    err_im = It - It1_warp;
    temp = zeros(6, 1);
    for i = rect(2):rect(4)
        for j = rect(1):rect(3)
            temp = temp + (double(err_im(i, j)) * [I_x(2, 1)  I_y(2, 1)] * jacobian(i, j))';
        end
    end
    
    delta_p = H \ temp;
    delta_p_33 = [delta_p(1) delta_p(2) delta_p(3) ; delta_p(4) delta_p(5) delta_p(6) ; 0 0 1]';
    delta_p_form = affine2d(delta_p_33);
    
    It1_warp = imwarp(It1, invert(delta_p_form), 'OutputView', Rin);
end

u = 0;
v = 0;

% figure, imshow(It(rect(2):rect(4), rect(1):rect(3)))
% figure, imshow(It1(rect(2):rect(4), rect(1):rect(3)))
% figure, imshow(It1_warp(rect(2):rect(4), rect(1):rect(3)))
% figure, imshow(err_im)

% figure, imshow(It)
% figure, imshow(It1)
% figure, imshow(It1_warp)