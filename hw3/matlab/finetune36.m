num_epoch = 5;
classes = 36;
layers = [32*32, 800, 10];
learning_rate = 0.01;

load('../data/nist36_train.mat', 'train_data', 'train_labels')
load('../data/nist36_test.mat', 'test_data', 'test_labels')
load('../data/nist36_valid.mat', 'valid_data', 'valid_labels')
load('../data/nist26_model_60iters.mat', 'W', 'b')

W_pretrain = W;
b_pretrain = b;
[W_nums, b_nums] = InitializeNetwork(layers);

W{2} = zeros(36, 800);
W{2}(1:26, :) = W_pretrain{2};
W{2}(27:36, :) = W_nums{2};

b{2} = zeros(36, 1);
b{2}(1:26) = b_pretrain{2};
b{2}(27:36) = b_nums{2};

W_init = W;
b_init = b;

tc = zeros(num_epoch, 1);
tl = zeros(num_epoch, 1);
vc = zeros(num_epoch, 1);
vl = zeros(num_epoch, 1);

for j = 1:num_epoch
    [W, b] = Train(W, b, train_data, train_labels, learning_rate);

    [train_acc, train_loss] = ComputeAccuracyAndLoss(W, b, train_data, train_labels);
    [valid_acc, valid_loss] = ComputeAccuracyAndLoss(W, b, valid_data, valid_labels);

    tc(j) = train_acc;
    tl(j) = train_loss;
    vc(j) = valid_acc;
    vl(j) = valid_loss;

    fprintf('Epoch %d - accuracy: %.5f, %.5f \t loss: %.5f, %.5f \n', j, train_acc, valid_acc, train_loss, valid_loss)
end

save('nist36_model.mat', 'W', 'b')
