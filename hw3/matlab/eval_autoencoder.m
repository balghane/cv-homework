% TODO: load test dataset
load('../data/nist36_test.mat', 'test_data', 'test_labels')

% TODO: reshape and adjust the dimensions to be in the order of [height,width,1,sample_index]
test_data = permute(test_data, [2 1]);
test_data = reshape(test_data, [32 32 1 size(test_data, 2)]);

% TODO: run predict()
test_recon = predict(net, test_data);

rows = 5;
cols = 2;

cur_col = 1;

indices = [5, 249, 499, 749, 998];

for i = 1:rows
    for j = 1:cols
        subplot(rows, 2*cols, 2*j+(i-1)*4-1)
        imshow(test_data(:, :, :, indices(i)+j-1));
        subplot(rows, 2*cols, 2*j+(i-1)*4)
        imshow(test_recon(:, :, :, indices(i)+j-1));
    end
end