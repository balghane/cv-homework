% TODO: load training dataset
load('../data/nist36_train.mat', 'train_data')
%load('../data/nist36_test.mat', 'test_data', 'test_labels')
%load('../data/nist36_valid.mat', 'valid_data', 'valid_labels')

% TODO: reshape and adjust the dimensions to be in the order of [height,width,1,sample_index]
train_data = permute(train_data, [2 1]);
train_data = reshape(train_data, [32 32 1 size(train_data, 2)]);

layers = define_autoencoder();

options = trainingOptions('sgdm',...
                          'InitialLearnRate',1.5e-3,...
                          'MaxEpochs',3,...
                          'MiniBatchSize',20,...
                          'Shuffle','every-epoch',...
                          'Plot','training-progress',...
                          'VerboseFrequency',20);

% TODO: run trainNetwork()
net = trainNetwork(train_data, train_data, layers, options);

                      