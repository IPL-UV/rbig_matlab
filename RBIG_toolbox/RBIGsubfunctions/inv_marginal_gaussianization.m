function [x2] = inv_marginal_gaussianization(x_gauss,T,precision) 

x_lin = normcdf(x_gauss);
[x2] = inv_marginal_uniformization(x_lin,T,precision);