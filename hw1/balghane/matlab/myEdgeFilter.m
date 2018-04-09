function [Im, Io, Ix, Iy] = myEdgeFilter(img, sigma)
hsize=2*ceil(3*sigma)+1;
h = fspecial('gaussian',hsize,sigma);
sobel_x = fspecial('sobel');

img_f = myImageFilter(img, h);
Ix = myImageFilter(img_f, sobel_x); % gradients in x = horizontal lines
Ix(Ix==0) = 0.00001;
Iy = myImageFilter(img_f, sobel_x'); % gradients in y = vertical lines

Im = sqrt(Ix.*Ix + Iy.*Iy);
Io = round(atan(Iy ./ Ix) / (pi / 2) * 2);
Io(Io == 0) = 0;
Io(Io == 1) = 1;
Io(Io == 2) = 2;
Io(Io == -1) = 3;
Io(Io == -2) = 2;

img_t = padarray(Im,[1 1],'replicate');

[a, b] = size(Im);

for i = 1:a
    for j = 1:b
        if Io(i,j) == 0 % gradient along x, look at x neighbors
            if max([img_t(i,j+1), img_t(i+2,j+1)]) > img_t(i+1,j+1)
                Im(i,j) = 0;
            end
            %Im(i,j) = max([img_t(i,j+1), img_t(i+1,j+1), img_t(i+2,j+1)]);
        elseif Io(i,j) == 1
            if max([img_t(i,j), img_t(i+2,j+2)]) > img_t(i+1,j+1)
                Im(i,j) = 0;
            end
        elseif Io(i,j) == 3
            if max([img_t(i+2,j), img_t(i,j+2)]) > img_t(i+1,j+1)
                Im(i,j) = 0;
            end
        elseif Io(i,j) == 2
            if max([img_t(i+1,j), img_t(i+1,j+2)]) > img_t(i+1,j+1)
                Im(i,j) = 0;
            end
        end
    end
end

Io = Io * pi / 4; % convert back to radians

%imshow(Ix)
%figure, imshow(Iy)
%figure, imshow(Im)
%figure, imshow(img_t)
%figure, imshow(Io)

end
    
                
        
        
