load('for_4_2.mat');
[width, length, channels] = size(im1);

% this can't possibly be the best way to do this
x1 = repmat(1:width, [1 length])';
y1 = reshape(repmat(1:width, [length 1]), [length*width 1]);

[ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 );
[ P, err ] = triangulate( C1, [x1 y1], C2, [x2 y2] );
pcshow(P);