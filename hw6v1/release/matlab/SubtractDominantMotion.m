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

%r2 = 6;
%SE2 = strel('diamond',r2);
%im_diff3 = imdilate(im_diff2,SE2);

%r1 = 8;
%SE1 = strel('diamond',r1);
%im_diff4 = imerode(im_diff3,SE1);

P=15;
im_diff3 = bwareaopen(im_diff2,P);

r2 = 6;
SE2 = strel('diamond',r2);
im_diff4 = imdilate(im_diff3,SE2);

r1 = 8;
SE1 = strel('diamond',r1);
im_diff5 = imerode(im_diff4,SE1);

r3 = 2;
SE3 = strel('diamond',r3);
im_diff6 = imdilate(im_diff5,SE3);

% imshow(rescale(image1))
% figure, imshow(rescale(image2_warped))
% figure, imshow(im_diff1)
% figure, imshow(im_diff2)
% figure, imshow(im_diff3)
% figure, imshow(im_diff4)

mask = im_diff6;