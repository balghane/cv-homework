load('../data/sylvbases.mat')
load('../data/sylvseq.mat')

[~, ~, nf] = size(frames);

rect_b = [102 62 156 108]';
rects_b = zeros(nf, 4);
rects_b(1, :) = rect_b';

rect_ic = [102 62 156 108]';
rects_ic = zeros(nf, 4);
rects_ic(1, :) = rect_ic';

scale_size = 2;
every_x = 1;

for i=1:every_x:nf-1
%for i=1:every_x:5
    f1 = double(frames(:, :, i));
    f2 = double(frames(:, :, i+every_x));
    
    [u_ic, v_ic] = LucasKanadeInverseCompositional(f1, f2, rects_ic(i, :));
    rect_ic = [-u_ic+rect_ic(1) ; -v_ic+rect_ic(2) ; -u_ic+rect_ic(3) ; -v_ic+rect_ic(4)];
    rect_ic = round(rect_ic);
    rects_ic(i+every_x, :) = rect_ic';
    
    [u_b, v_b] = LucasKanadeBasis(f1, f2, rects_b(i, :), bases);
    rect_b = [u_b+rect_b(1) ; v_b+rect_b(2) ; u_b+rect_b(3) ; v_b+rect_b(4)];
    rect_b = round(rect_b);
    rects_b(i+every_x, :) = rect_b';
    i
    if mod(i, 20) == 1
        % rect
        % imshow(imresize(f2(rect(2):rect(4), rect(1):rect(3)), scale_size, 'nearest'));
        imshow(imresize(rescale(f2), scale_size, 'nearest'));
        rect_s_ic = rect_ic * scale_size;
        rect_s_b = rect_b * scale_size;
        rectangle('Position',[rect_s_b(1) rect_s_b(2) rect_s_b(3)-rect_s_b(1) rect_s_b(4)-rect_s_b(2)],'EdgeColor','y');
        rectangle('Position',[rect_s_ic(1) rect_s_ic(2) rect_s_ic(3)-rect_s_ic(1) rect_s_ic(4)-rect_s_ic(2)],'EdgeColor','g');
        waitforbuttonpress
    end
end
