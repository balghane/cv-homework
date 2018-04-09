function [locs, desc] = briefLite(im)
% input
% im - gray image with values between 0 and 1
%
% output
% locs - an m x 3 vector, where the first two columns are the image coordinates of keypoints and the third column 
% 		 is the pyramid level of the keypoints
% desc - an m x n bits matrix of stacked BRIEF descriptors. 
%		 m is the number of valid descriptors in the image and will vary
% 		 n is the number of bits for the BRIEF descriptor

%%%
% patchWidth = 9;
% nbits = 256;
load('testPattern.mat')
% [compareA, compareB] = makeTestPattern(patchWidth, nbits);
locs = detectHarrisFeatures(im);
locs = round(locs.Location);
[locs, desc] = computeBrief(im, locs, compareA, compareB);
end