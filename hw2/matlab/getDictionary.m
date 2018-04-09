function [dictionary] = getDictionary(imgPaths, alpha, K, method)
% Generate the filter bank and the dictionary of visual words
% Inputs:
%   imgPaths:        array of strings that repesent paths to the images
%   alpha:          num of points
%   K:              K means parameters
%   method:         string 'random' or 'harris'
% Outputs:
%   dictionary:         a length(imgPaths) * K matrix where each column
%                       represents a single visual word

    [~, num_imgs] = size(imgPaths);
    pixelResponses = zeros(alpha*num_imgs, 60);
    filterBank = createFilterBank();
    for i = 1:num_imgs
        i
        img = imread(strcat('../data/', imgPaths{i}));
        filterResponses = extractFilterResponses(img, filterBank);
        if isequal(size(size(img)), [1 2])
            % already gray
            if method == 'harris'
                points = getHarrisPoints(img, alpha, 0.05);
            else
                points = getRandomPoints(img, alpha);
            end
        else
            % change to gray
            if method == 'harris'
                points = getHarrisPoints(rgb2gray(img), alpha, 0.05);
            else
                points = getRandomPoints(rgb2gray(img), alpha);
            end
        end
        I = points(:, 1)';
        J = points(:, 2)';
        
        % this code snippet borrowed from a stack overflow answer
        sz = size(filterResponses);
        subs = [repmat(I, [1, sz(3)]);
            repmat(J, [1, sz(3)]);
            repelem([1:sz(3)], length(I))];
        result = filterResponses(sub2ind(sz, subs(1,:), subs(2,:), subs(3,:)));
        
        result = reshape(result, [alpha, 60]);
        pixelResponses((i-1)*alpha+1:i*alpha, :) = result;
    end
    
    [~, dictionary] = kmeans(pixelResponses, K, 'EmptyAction', 'drop');
end
