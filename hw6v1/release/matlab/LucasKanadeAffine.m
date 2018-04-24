function [M] = LucasKanadeAffine(It, It1)

% input - image at time t, image at t+1, rectangle (top left, bot right
% coordinates), bases 
% output - movement vector, [u,v] in the x- and y-directions.s

[r, c] = size(It);

% make template
template = It;
template_vec = template(:);

% compute image gradient
[I_x_temp,I_y_temp] = imgradientxy(template);
I_x_temp = I_x_temp(:);
I_y_temp = I_y_temp(:);

[r_coords, c_coords] = meshgrid(1:r, 1:c);
r_coords = r_coords(:);
c_coords = c_coords(:);

% compute steepest descent
s_d = [I_x_temp           I_y_temp           ...
       I_x_temp.*r_coords I_y_temp.*r_coords ...
       I_x_temp.*c_coords I_y_temp.*c_coords];

% evaluate Hessian
H = s_d' * s_d;
H_inv = inv(H);
    
epsilon = .005;
vars = zeros(6, 1);
% vars(3:2+bnf) = ones(bnf, 1);
delta_vars = ones(6, 1);
warp_33 = [1+vars(1) vars(2) vars(3) ; vars(4) 1+vars(5) vars(6) ; 0 0 1]';
warp_form = affine2d(warp_33);
Rin = imref2d(size(It));

while(norm(delta_vars) > epsilon)
    It1_warp = imwarp(It1, warp_form, 'Linear', 'OutputView', Rin);
    It1_warp_vec = It1_warp(:);
    
    % compute error image
    err_im = template_vec - It1_warp_vec;
    % err_im_temp = template - It1_warp( rect(2):rect(4), rect(1):rect(3));
    % err_im_temp = err_im_temp(:);
    
    temp_var = s_d' * err_im;
    
    delta_vars = - (H_inv * temp_var);
    delta_vars_inv = invert_warp_vars(delta_vars);
    vars = compose(vars, delta_vars_inv);
    warp_33 = [1+vars(1) vars(2) vars(3) ; vars(4) 1+vars(5) vars(6) ; 0 0 1]';
    warp_form = affine2d(warp_33);
    norm(delta_vars)
    % disp('Press a key !')  % Press a key here.You can see the message 'Paused: Press any key' in        % the lower left corner of MATLAB window.
    % pause;
end

M = warp_33';

% scale_size = 4;

% figure, imshow(imresize(It(rect(2):rect(4), rect(1):rect(3)), scale_size, 'nearest'));
% figure, imshow(imresize(It1(rect(2):rect(4), rect(1):rect(3)), scale_size, 'nearest'));
% figure, imshow(imresize(It1_warp(rect(2):rect(4), rect(1):rect(3)), scale_size, 'nearest'));
% figure, imshow(err_im)

figure, imshow(rescale(It))
% figure, imshow(It1)
figure, imshow(rescale(It1_warp))