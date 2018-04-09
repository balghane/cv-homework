% get images
img1 = imread('../data/pnc1.png');
img2 = imread('../data/pnc0.png');

% make em gray
img1_g = rgb2gray(img1);
img2_g = rgb2gray(img2);

% compute descriptor
[locs1, desc1] = briefLite(img1_g);
[locs2, desc2] = briefLite(img2_g);

% get matches
ratio = 0.85;
matches = briefMatch(desc1, desc2, ratio);

% get coordinates corresponding to matches
coords1 = locs1(matches(:,1),:)';
coords2 = locs2(matches(:,2),:)';

test = 2;

if test == 1
    plotMatches(img1_g, img2_g, matches, locs1, locs2);
else
    % compute homography
    [H, inliers] = computeH_ransac(coords1, coords2);
    H = double(H);
    H / H(3, 3)
    % mean(inliers)

    % do the thing
    stitched = imageStitching(img1_g, img2_g, H);
    figure;imshow(stitched)
end