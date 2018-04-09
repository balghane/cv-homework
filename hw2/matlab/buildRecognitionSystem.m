% buildRecognitionSystem.m
% This script loads the visual word dictionary (in dictionaryRandom.mat or dictionaryHarris.mat) and processes
% the training images so as to build the recognition system. The result is
% stored in visionRandom.mat and visionHarris.mat.
filter_bank = createFilterBank();
load('dictionaryRandom.mat')
load('../data/traintest.mat')
l = length(train_imagenames);
trainFeatures = zeros(l, size(dictionary, 1));
for i=1:l
    load(strcat('../data/', strrep(train_imagenames{i},'.jpg','_Random.mat')));
    trainFeatures(i, :) = getImageFeatures(wordMap, size(dictionary, 1));
    fprintf("%d\n", i);
end
trainLabels = train_labels';
save('visionRandom.mat', 'dictionary', 'filter_bank', 'trainFeatures', 'trainLabels');