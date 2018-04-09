function [rhos, thetas] = myHoughLines(H, nLines)
[a, b] = size(H);
nms_size = 4;
H_temp = padarray(H,[nms_size nms_size],'replicate');

%figure, imshow(rescale(H), [0 0.5], 'InitialMagnification', 200)

%H(H<0.3) = 0;

for i = 0:(nms_size*2)
    for j = 0:(nms_size*2)
        H(H_temp(1+i:a+i,1+j:b+j) > H) = 0;
    end
end

%figure, imshow(rescale(H), [0 0.5], 'InitialMagnification', 200)

H_flat = reshape(H, a*b, 1);

[~,I] = maxk(H_flat, nLines);

[rhos, thetas] = ind2sub([a, b], I);

%plot(rhos, thetas, 'x','markers',12)
%hold on

%peaks_hough = houghpeaks(H, nLines);

%plot(peaks_hough(:, 1), peaks_hough(:, 2), 'o','markers',12)

%figure, imshow(rescale(H), [0 0.5], 'InitialMagnification', 200)

end