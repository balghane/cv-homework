% get images
cv_cover = imread('../data/cv_cover.jpg');
cv_desk = imread('../data/cv_desk.png');
hp_cover = imread('../data/hp_cover_big.jpg');

% make em gray
cv_cover_g = cv_cover;
cv_desk_g = rgb2gray(cv_desk);
hp_cover_g = rgb2gray(hp_cover);

% compute descriptor
[locs_cover, desc_cover] = briefLite(cv_cover_g);
[locs_desk, desc_desk] = briefLite(cv_desk_g);

% get matches
ratio = 0.85;
matches = briefMatch(desc_cover, desc_desk, ratio);

% get coordinates corresponding to matches
coords_cover = locs_cover(matches(:,1),:)';
coords_desk = locs_desk(matches(:,2),:)';

test = 2;

if test == 1
    plotMatches(cv_cover_g, cv_desk_g, matches, locs_cover, locs_desk);
else
    % compute homography
    [H, inliers] = computeH_ransac(coords_cover, coords_desk);
    H = double(H);
    % mean(inliers)

    % create composite image
    composite_img = compositeH(H, cv_desk_g, hp_cover_g);
    figure;imshow(composite_img);
end



