function [x_gauss] = marginal_gaussianizationB(x,T,precision) 

[x_unif] = marginal_uniformizationB(x,T,precision);
x_gauss = norminv(x_unif);