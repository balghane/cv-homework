function [matches] = briefMatch(desc1, desc2, ratio)
%function [matches] = briefMatch(desc1, desc2, ratio)
% Performs the descriptor matching
% inputs  : desc1 , desc2 - m1 x n and m2 x n matrix. m1 and m2 are the number of keypoints in image 1 and 2.
%						    n is the number of bits in the brief
% outputs : matches - p x 2 matrix. where the first column are indices
%									into desc1 and the second column are indices into desc2

%%%

nbits = size(desc1, 2);
matches = [];

for i = 1:size(desc1, 1)
    for j = 1:size(desc2, 1)
        matching = mean(desc1(i, :) == desc2(j, :));
        if matching > ratio
            matches = [matches ; i j];
            % sum(desc1(i, :) == desc2(j, :))
        end
    end
end

end