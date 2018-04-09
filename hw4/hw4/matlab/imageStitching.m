function [panoImg] = imageStitching(img1, img2, H2to1)
%
% input
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation
%
% output
% Blends img1 and warped img2 and outputs the panorama image

%%%
new_size = size(img1) - [round(H2to1(2, 3)) round(H2to1(1, 3))];

temp_img = warpH(img2, inv(H2to1), new_size);
% imshow(temp_img);
panoImg = imfuse(temp_img,img1, 'blend');
% imshow(temp_img);

end