function [dWdp] = jacobian(x,y)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
dWdp = [x 0 y 0 1 0 ; 0 x 0 y 0 1];
end

