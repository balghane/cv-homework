load('../data/carseq.mat')

[~, ~, nf] = size(frames);

rect = [60 117 146 152]';
rects = zeros(nf, 4);
rects(1, :) = rect';
scale_size = 4;

for i=1:nf-1
    f1 = frames(:, :, i);
    f2 = frames(:, :, i+1);
    [u,v] = LucasKanadeInverseCompositional(f1, f2, rect);
    rect = [v+rect(1) ; u+rect(2) ; v+rect(3) ; u+rect(4)];
    rect = round(rect);
    rects(i+1, :) = rect';
    if mod(i, 5) == 0
        i
        rect
        imshow(imresize(f2(rect(2):rect(4), rect(1):rect(3)), scale_size, 'nearest'));
        waitforbuttonpress
    end
end

