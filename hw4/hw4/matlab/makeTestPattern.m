function [compareA, compareB] = makeTestPattern(patchWidth, nbits)  
% input
% patchWidth - the width of the image patch (usually 9)
% nbits - the number of tests n in the BRIEF descriptor
% output
% compareA and compareB - linear indices into the patchWidth x patchWidth image patch and are each nbits x 1 vectors. 
%
% Run this routine for the given parameters patchWidth = 9 and n = 256 and save the results in testPattern.mat.

%%%
sigma = patchWidth / 6;
compareA_x = normrnd(0, sigma, nbits, 1);
compareA_y = normrnd(0, sigma, nbits, 1);
compareB_x = normrnd(0, sigma, nbits, 1);
compareB_y = normrnd(0, sigma, nbits, 1);

mid_val = ((patchWidth*patchWidth - 1) / 2) + 1;
compareA = mid_val + compareA_x + patchWidth * compareA_y;
compareB = mid_val + compareB_x + patchWidth * compareB_y;

% uniform method
% compareA = randi([1 patchWidth*patchWidth],nbits, 1);
% compareB = randi([1 patchWidth*patchWidth],nbits, 1);

end