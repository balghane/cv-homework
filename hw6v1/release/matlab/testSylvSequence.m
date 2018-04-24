load('../data/sylvbases.mat')
load('../data/sylvseq.mat')


[~, ~, nf] = size(frames);
rect = [102 62 156 108]';
rects = zeros(nf, 4);
rects(1, :) = rect';
scale_size = 2;
every_x = 1;

for i=1:every_x:nf-1
%for i=1:every_x:5
    f1 = double(frames(:, :, i));
    f2 = double(frames(:, :, i+every_x));
    [u,v] = LucasKanadeBasis(f1, f2, rects(i, :), bases);
    rect = [u+rect(1) ; v+rect(2) ; u+rect(3) ; v+rect(4)];
    rect = round(rect);
    rects(i+every_x, :) = rect';
    i
    if mod(i, 100) == 5
        % rect
        % imshow(imresize(f2(rect(2):rect(4), rect(1):rect(3)), scale_size, 'nearest'));
        imshow(imresize(rescale(f2), scale_size, 'nearest'));
        rect_s = rect * scale_size;
        rectangle('Position',[rect_s(1) rect_s(2) rect_s(3)-rect_s(1) rect_s(4)-rect_s(2)],'EdgeColor','y');
        waitforbuttonpress
    end
end
