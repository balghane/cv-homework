function [h] = getImageFeatures(wordMap, dictionarySize)
% Convert an wordMap to its feature vector. In this case, it is a histogram
% of the visual words
% Input:
%   wordMap:            an H * W matrix with integer values between 1 and K
%   dictionarySize:     the total number of words in the dictionary, K
% Outputs:
%   h:                  the feature vector for this image

    num_map_els = numel(wordMap);
    acc = accumarray(reshape(wordMap, [num_map_els, 1]), 1);
    if size(acc,1) == 1
        h = acc;
    else
        h = zeros(dictionarySize, 1);
        h(1:size(acc,1)) = acc;
    end
    
    h = h / num_map_els;
end
