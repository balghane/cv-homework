% evaluateRecognitionSystem.m
% This script evaluates nearest neighbour recognition system on test images
% load traintest.mat and classify each of the test_imagenames files.
% Report both accuracy and confusion matrix
load('../data/traintest.mat');
load('visionHarris.mat')

C = zeros(8);

l = length(test_imagenames);
correct = 0;
for i=1:l
    load(strcat('../data/', strrep(test_imagenames{i},'.jpg','_Harris.mat')));
    img_features = getImageFeatures(wordMap, size(dictionary, 1));
    dists = getImageDistance(img_features, trainFeatures, 'chi2');
    [D,I] = min(dists);
    label = trainLabels(I);
    real_label = test_labels(i);
    % fprintf('Label: %d, True Label: %d\n', label, real_label);
    C(label, real_label) = C(label, real_label) + 1;
    if label == real_label
        correct = correct + 1;
    end
end

fprintf('Accuracy was %.2f%%', correct / l * 100);
C