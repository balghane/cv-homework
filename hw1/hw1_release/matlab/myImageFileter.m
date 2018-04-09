function [img1] = myImageFilter(img0, h)

[a, b] = size(h);
[c, d] = size(img0);
img1 = zeros([c, d]);
img_t = padarray(img0,[(a-1)/2 (b-1)/2],'replicate');

for k = 1:a*b
    [i, j] = ind2sub([a, b], k);
    %i = round((k+1)/c, 0);
    %j = mod(k-1,d)+1;    
    img1 = img1 + h(i,j) * img_t(i:i+c-1,j:j+d-1);
end

end
