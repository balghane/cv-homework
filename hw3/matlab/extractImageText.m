function [text] = extractImageText(fname)
% [text] = extractImageText(fname) loads the image specified by the path 'fname'
% and returns the next contained in the image as a string.

load('nist36_model.mat', 'W', 'b')

im = imread(fname);

plotting = 0;
[lines, bw] = findLetters(im, plotting);
text = '';

for i = 1:length(lines)
    for j = 1:size(lines{i}, 1)
        box = lines{i}(j, :);
        if j ~= 1 && lines{i}(j, 1) - lines{i}(j-1, 1) > 120
            text = [text ' '];
        end
        tmp = imresize(bw(box(2):box(2)+box(4), box(1):box(1)+box(3)), [32 32]);
        net_input = reshape(tmp, [1 1024]);
        output = Classify(W, b, net_input);
        [~, predicted_label_ind] = max(output(:));
        ch = num2char(predicted_label_ind);
        text = [text ch];
        %output
        %predicted_label_ind
        %ch
        %imshow(tmp)
        %waitforbuttonpress
    end
    text = [text newline];
end

end
