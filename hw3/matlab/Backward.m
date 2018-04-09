function [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a)
% [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a) computes the gradient
% updates to the deep network parameters and returns them in cell arrays
% 'grad_W' and 'grad_b'. This function takes as input:
%   - 'W' and 'b' the network parameters
%   - 'X' and 'Y' the single input data sample and ground truth output vector,
%     of sizes Nx1 and Cx1 respectively
%   - 'act_h' and 'act_a' the network layer pre and post activations when forward
%     forward propogating the input smaple 'X'

num_layers = length(W);
out = act_h{num_layers};
grad_W = cell(1, num_layers);
grad_b = cell(1, num_layers);
dLda = cell(1, num_layers);

err = out - Y;

for ind = 1:num_layers
    i = num_layers - ind + 1;
    if i == num_layers
        dLda{i} = err;
        grad_W{i} = dLda{i} * act_h{i-1}.';
        grad_b{i} = dLda{i};
    elseif i == 1
        num_units = length(act_h{i});
        dLda{i} = zeros(num_units, 1);
        for j = 1:num_units
            dLda{i}(j) = act_h{i}(j) * (1 - act_h{i}(j)) *  ( dLda{i+1}.' * W{i+1}(:, j));
        end
        grad_W{i} = dLda{i} * X;
        grad_b{i} = dLda{i};
    else
        num_units = length(act_h{i});
        dLda{i} = zeros(num_units, 1);
        for j = 1:num_units
            dLda{i}(j) = act_h{i}(j) * (1 - act_h{i}(j)) *  ( dLda{i+1}.' *W{i+1}(:, j));
        end
        grad_W{i} = dLda{i} * act_h{i-1}.';
        grad_b{i} = dLda{i};
    end
end

end
