function [x2] = inv_marginal_uniformization(x_lin,T,precision)

if nargin == 2, precision = 1000; end

x2 = interp1(T.C,T.R,x_lin); 
