function mask = SubtractDominantMotion(image1, image2)

% input - image1 and image2 form the input image pair
% output - mask is a binary image of the same size

Rin = imref2d(size(image1));
M = LucasKanadeAffine(image1, image2);
M
warp_form = affine2d(M');
image2_warped = imwarp(image2, warp_form, 'Linear', 'OutputView', Rin);

im_diff1 = rescale(abs(image2_warped - image1));
threshold = 0.2;
im_diff2 = im_diff1 > threshold;
P=20;
im_diff3 = bwareaopen(im_diff2,P);

% imshow(rescale(image1))
% figure, imshow(rescale(image2_warped))
% figure, imshow(im_diff3)

mask = im_diff3;