function [x_lin] = marginal_uniformizationB(x,T,precision)

if nargin < 3, precision = 1000; end

x_lin = interp1(T.R,T.C,x); 

