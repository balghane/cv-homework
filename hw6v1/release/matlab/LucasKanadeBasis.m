function [u,v] = LucasKanadeBasis(It, It1, rect, bases)

% input - image at time t, image at t+1, rectangle (top left, bot right
% coordinates), bases 
% output - movement vector, [u,v] in the x- and y-directions.s

% vectorize base
[bh, bw, bnf] = size(bases);
bases_vec = reshape(bases, bh*bw, bnf);

% get gradients of bases
base_grads_x = zeros(bh * bw, bnf);
base_grads_y = zeros(bh * bw, bnf);
for i = 1:bnf
    [tempo_x,tempo_y] = imgradientxy(bases(:, :, i));
    base_grads_x(:, i) = tempo_x(:);
    base_grads_y(:, i) = tempo_y(:);
end

% make template
template = It( rect(2):rect(4), rect(1):rect(3));
template_vec = template(:);

% compute image gradient
[I_x_temp,I_y_temp] = imgradientxy(template);
I_x_temp = I_x_temp(:);
I_y_temp = I_y_temp(:);

epsilon = .005;
vars = zeros(2+bnf, 1);
% vars(3:2+bnf) = ones(bnf, 1);
delta_vars = ones(2+bnf, 1);
lambdas = vars(3:2+bnf);
warp_33 = [1 0 vars(1) ; 0 1 vars(2) ; 0 0 1]';
warp_form = affine2d(warp_33);
Rin = imref2d(size(It));

while(norm(delta_vars(1:2)) > epsilon)
    It1_warp = imwarp(It1, warp_form, 'Linear', 'OutputView', Rin);
    It1_warp_wind = It1_warp(rect(2):rect(4), rect(1):rect(3));
    It1_warp_vec = It1_warp_wind(:);
    
    % compute error image
    err_im = template_vec + bases_vec * lambdas - It1_warp_vec;
    % err_im_temp = template - It1_warp( rect(2):rect(4), rect(1):rect(3));
    % err_im_temp = err_im_temp(:);
    
    % compute steepest descent
    s_d = [I_x_temp+base_grads_x*lambdas  I_y_temp+base_grads_y*lambdas  bases_vec];
    
    % evaluate Hessian
    H = s_d' * s_d;
    
    temp_var = s_d' * err_im;
    
    delta_vars = - (H \ temp_var);
    vars(1:2) = vars(1:2) - delta_vars(1:2);
    vars(3:2+bnf) = vars(3:2+bnf) - 0.5 * delta_vars(3:2+bnf);
    lambdas = vars(3:2+bnf);
    warp_33 = [1 0 vars(1) ; 0 1 vars(2) ; 0 0 1]';
    warp_form = affine2d(warp_33);
    % disp('Press a key !')  % Press a key here.You can see the message 'Paused: Press any key' in        % the lower left corner of MATLAB window.
    % pause;
end

u = vars(1);
v = vars(2);
lambdas

% scale_size = 4;

% figure, imshow(imresize(It(rect(2):rect(4), rect(1):rect(3)), scale_size, 'nearest'));
% figure, imshow(imresize(It1(rect(2):rect(4), rect(1):rect(3)), scale_size, 'nearest'));
% figure, imshow(imresize(It1_warp(rect(2):rect(4), rect(1):rect(3)), scale_size, 'nearest'));
% figure, imshow(err_im)

% figure, imshow(It)
% figure, imshow(It1)
% figure, imshow(It1_warp)