function im3 = generatePanorama(im1, im2)

% make em gray
img1_g = rgb2gray(im1);
img2_g = rgb2gray(im2);

% compute descriptor
[locs1, desc1] = briefLite(img1_g);
[locs2, desc2] = briefLite(img2_g);

% get matches
ratio = 0.9;
matches = briefMatch(desc1, desc2, ratio);

% get coordinates corresponding to matches
coords1 = locs1(matches(:,1),:)';
coords2 = locs2(matches(:,2),:)';
% compute homography
[H, inliers] = computeH_ransac(coords1, coords2);
H = double(H);
H / H(3, 3)
% mean(inliers)

% do the thing
im3 = imageStitching(img1_g, img2_g, H);
% figure;imshow(stitched)

end