% get images
cv_cover = imread('../data/cv_cover.jpg');
cv_desk = imread('../data/cv_desk.png');
hp_cover = imread('../data/hp_cover.jpg');

% make em gray
cv_desk_g = rgb2gray(cv_desk);
cv_cover_g = cv_cover;
hp_cover_g = rgb2gray(hp_cover);
I1 = cv_desk_g;
I2 = cv_cover_g;

points1 = detectHarrisFeatures(I1);
points2 = detectHarrisFeatures(I2);
[features1,valid_points1] = extractFeatures(I1,points1);
[features2,valid_points2] = extractFeatures(I2,points2);
indexPairs = matchFeatures(features1,features2, 'MatchThreshold', 80);
matchedPoints1 = valid_points1(indexPairs(:,1),:);
matchedPoints2 = valid_points2(indexPairs(:,2),:);
figure;showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2);

pts1 = round(matchedPoints1.Location)';
pts2 = round(matchedPoints2.Location)';

% compute homographya
[H, inliers] = computeH_ransac( pts1, pts2);
H = double(H);
mean(inliers)

% warp HP cover
out_size = size(cv_desk_g);
hp_cover_warped = warpH(hp_cover_g, inv(H), out_size);
cv_cover_warped = warpH(cv_cover_g, inv(H), out_size);
figure;imshow(cv_cover_warped)
figure;imshow(cv_desk_g)