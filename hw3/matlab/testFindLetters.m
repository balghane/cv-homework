% Your code here.
im1 = imread('../images/01_list.jpg');
im2 = imread('../images/02_letters.jpg');
im3 = imread('../images/03_haiku.jpg');
im4 = imread('../images/04_deep.jpg');

[lines, bw] = findLetters(im1, 0);
