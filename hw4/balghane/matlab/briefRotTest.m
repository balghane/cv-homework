im1 = rgb2gray(imread('../data/model_chickenbroth.jpg'));

% patchWidth = 9;
% nbits = 256;
% [compareA, compareB] = makeTestPattern(patchWidth, nbits);
load('testPattern.mat')
ratio = 0.8;

locs1 = detectHarrisFeatures(im1);
% locs1 = locs1.Location;
locs1 = round(locs1.Location);
[locs1, desc1] = computeBrief(im1, locs1, compareA, compareB);

length(locs1)

for i = 0:5
    im2 = imrotate(im1, i * 10);
    locs2 = detectHarrisFeatures(im2);
    % locs2 = locs2.Location;
    locs2 = round(locs2.Location);
    [locs2, desc2] = computeBrief(im2, locs2, compareA, compareB);

    matches = briefMatch(desc1, desc2, ratio);
    disp(i * 10)
    %mean2(im1 == im2)
    % length(locs1)
    % length(locs2)
    plotMatches(im1, im2, matches, locs1, locs2);
    length(matches)
    waitforbuttonpress
end