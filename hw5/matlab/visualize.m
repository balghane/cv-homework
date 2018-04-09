% Q4.2:
% Integrating everything together.
% Loads necessary files from ../data/ and visualizes 3D reconstruction
% using scatter3

load('for_4_2.mat')
load('../data/templeCoords.mat');

[ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 );
[ P, err ] = triangulate( C1, [x1 y1], C2, [x2 y2] );
scatter3(P(:, 1), P(:, 2), P(:, 3));

save('q4_2.mat','F','M1','M2','C1','C2');