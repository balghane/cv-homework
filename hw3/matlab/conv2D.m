function layer = conv2D(filterSize,inN,outN,padSize,strideSize)
% filterSize: size of filter (scalar, assumed square)
% inN: number of channels for the input
% outN: number of filters for the output
% padSize: padding size (scalar, assume same for x and y)
% strideSize: stride size (scalar, assume same for x and y)

stddev = 0.025;
layer = convolution2dLayer([filterSize,filterSize],outN,'Padding',padSize,'Stride',strideSize);
layer.Weights = stddev * rand([filterSize,filterSize,inN,outN]) * 2 - stddev;
layer.Bias = stddev * rand([1,1,outN]) * 2 - stddev;
