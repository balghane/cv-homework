clear;

datadir     = '../data';    %the directory containing the images
resultsdir  = '../results'; %the directory for dumping results

%parameters
sigma     = 2;
threshold = 0.03;
rhoRes    = 2;
thetaRes  = pi/90;
nLines    = 50;
%end of parameters

imglist = dir(sprintf('%s/*.jpg', datadir));

for i = 1:1
    
    %read in images%
    [path, imgname, dummy] = fileparts(imglist(i).name);
    img = imread(sprintf('%s/%s', datadir, imglist(i).name));
    
    if (ndims(img) == 3)
        img = rgb2gray(img);
    end
    
    img = double(img) / 255;
    %img = img(176:200,151:175);
    %imshow(img)
    
    %try convlution
    A = [1 2 1 ; 2 4 2 ; 1 2 1] * (1/16);
    %A = [0 0 0 ; 0 1 0 ; 0 0 0];
    
    tic
    for z = 1:100
        img2 = myImageFilter(img, A);
    end
    toc
    tic
    for z = 1:100
        img3 = imfilter(img, A, 'replicate');
    end
    toc
    %size(img3)
    %imshow(img2)
    %figure, imshow(img3)
    %figure, imshow(abs(img2 - img3))
    mean2(abs(img2 - img3))
    %img2(5:9,5:9)
    %img3(5:9,5:9)
end