function [W, b] = InitializeNetwork(layers)
% InitializeNetwork([INPUT, HIDDEN, OUTPUT]) initializes the weights and biases
% for a fully connected neural network with input data size INPUT, output data
% size OUTPUT, and HIDDEN number of hidden units.
% It should return the cell arrays 'W' and 'b' which contain the randomly
% initialized weights and biases for this neural network.

num_layers = length(layers);

W = cell(1, num_layers-1);
b = cell(1, num_layers-1);

for i = 1:num_layers - 1
    W{i} = rand(layers(i+1), layers(i)) * 2 - 1;
    b{i} = rand(layers(i+1), 1) * 2 - 1;
end

end
