function [locs, desc] = computeBrief(im, locs, compareX, compareY)
% Compute the BRIEF descriptor for detected keypoints.
% im is 1 channel image, 
% locs are locations
% compareX and compareY are idx in patchWidth^2
% Return:
% locs: m x 2 vector which contains the coordinates of the keypoints
% desc: m x nbits vector which contains the BRIEF descriptor for each
%   keypoint.

%%%
patchWidth = 9;
pwed = (patchWidth - 1) / 2; % patch width each direction

% desc = zeros(size(locs, 1), size(compareX, 1));
% indices_to_include = ones(size(locs, 1), size(compareX, 1));

locs_out = [];
desc_out = [];

for i=1:size(locs, 1)
    try
        patch = im(locs(i, 2) - pwed:locs(i, 2) + pwed, locs(i, 1) - pwed:locs(i, 1) + pwed);
        flat_patch = reshape(patch, patchWidth*patchWidth, 1);
        out = flat_patch(compareX) > flat_patch(compareY);
        locs_out = [locs_out ; locs(i, :)];
        desc_out = [desc_out ; out'];
        % desc(i, :) = out';
    catch
        % indices_to_include(i, :) = 0;
    end
end

% locs = locs(indices_to_include(:, 1:2)==1);
% desc = desc(indices_to_include==1);

% locs = reshape(locs, size(locs, 1) / 2, 2);
% desc = reshape(desc, size(desc, 1) / 256, 256);

locs = locs_out;
desc = desc_out;

end