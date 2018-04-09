function layers = define_autoencoder()

layers = [
    imageInputLayer([32,32,1])
    % intermediate layers go between here ...
    conv2D(4,1,4,1,2)
    conv2D(4,4,8,1,2)
    conv2D(8,8,64,0,1)
    transpConv2D(8,64,8,0,1)
    transpConv2D(4,8,4,1,2)
    transpConv2D(4,4,1,1,2)
    % ... and here
    regressionLayer
];

