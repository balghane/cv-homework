function [lines, bw] = findLetters(im, plotting)
% [lines, BW] = findLetters(im) processes the input RGB image and returns a cell
% array 'lines' of located characters in the image, as well as a binary
% representation of the input image. The cell array 'lines' should contain one
% matrix entry for each line of text that appears in the image. Each matrix entry
% should have size Lx4, where L represents the number of letters in that line.
% Each row of the matrix should contain 4 numbers [x1, y1, x2, y2] representing
% the top-left and bottom-right position of each box. The boxes in one line should
% be sorted by x1 value.

im_gray = rgb2gray(im);
im_bw = imbinarize(im_gray, 'adaptive', 'ForegroundPolarity','dark');
im_wb = rescale(imcomplement(im_bw));
im_cc = bwconncomp(im_wb);
im_bb = regionprops(im_cc,'BoundingBox', 'ConvexArea');

if plotting
    imshow(im_bw);
    hold on
    h = gca;
    h.Visible = 'On';
end

num_lines = 0;
line_positions = [];
box_heights = [];
tmp_lines = {};

for i = 1:length(im_bb)
    if im_bb(i).ConvexArea > 1000
        if plotting
            rectangle('Position',im_bb(i).BoundingBox, 'EdgeColor','r');
        end
        box = round(im_bb(i).BoundingBox);
        placed = 0;
        for j = 1:num_lines
            if abs(box(2) - line_positions(j)) < box_heights
                tmp_lines{j} = [tmp_lines{j} ; box];
                line_positions(j) = mean(tmp_lines{j}(:, 2));
                box_heights(j) = mean(tmp_lines{j}(:, 4));
                placed = 1;
            end
        end
        if ~placed
            tmp_lines{num_lines + 1} = box;
            num_lines = num_lines + 1;
            line_positions = [line_positions box(2)];
            box_heights = [box_heights box(4)];
        end
    end
end

bw = im_bw;

[~, ind] = mink(line_positions, num_lines);

for i = 1:num_lines
    lines{i} = tmp_lines{ind(i)};
end

end
