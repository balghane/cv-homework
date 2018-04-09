function [accuracy, loss, confusion] = ComputeAccuracyLossConfusion(W, b, data, labels)
% [accuracy, loss] = ComputeAccuracyAndLoss(W, b, X, Y) computes the networks
% classification accuracy and cross entropy loss with respect to the data samples
% and ground truth labels provided in 'data' and labels'. The function should return
% the overall accuracy and the average cross-entropy loss.

outputs = Classify(W, b, data);

classes = size(outputs, 2);

confusion = zeros(classes);

num_samples = size(data, 1);
num_correct = 0;
total_loss = 0;

for i = 1:num_samples
    predicted_label = zeros(1, size(outputs,2));
    [~, predicted_label_ind] = max(outputs(i, :));
    predicted_label(predicted_label_ind) = 1;
    correct_label = labels(i, :);
    [~, correct_label_ind] = max(correct_label);
    if isequal(predicted_label,correct_label)
        num_correct = num_correct + 1;
    end
    total_loss = total_loss - correct_label * log(outputs(i, :)).';
    confusion(predicted_label_ind, correct_label_ind) = confusion(predicted_label_ind, correct_label_ind) + 1;
end

accuracy = num_correct / num_samples;
loss = total_loss / num_samples;
confusion = rescale(confusion);

end
