load('../data/aerialseq.mat')

[~, ~, nf] = size(frames);

scale_size = 2;
every_x = 1;

for i=1:every_x:nf-1
% for i=10:11
    f1 = double(frames(:, :, i));
    f2 = double(frames(:, :, i+every_x));
    
    mask = SubtractDominantMotion(f1, f2);
    
    i
    if mod(i, 30) == 1
        % imshow(rescale(f1));
        % figure, imshow(rescale(f2));
        imshow(imfuse(f2, mask));
        waitforbuttonpress
        % rect
        % imshow(imresize(f2(rect(2):rect(4), rect(1):rect(3)), scale_size, 'nearest'));
        % imshow(imresize(rescale(f2), scale_size, 'nearest'));
        % rect_s = rect * scale_size;
        % rectangle('Position',[rect_s(1) rect_s(2) rect_s(3)-rect_s(1) rect_s(4)-rect_s(2)],'EdgeColor','y');
        % waitforbuttonpress
    end
end

