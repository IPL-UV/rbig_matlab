function [x_gauss T] = marginal_gaussianization(x,porc,precision) 

[x_unif T] = marginal_uniformization(x,porc,precision);
x_gauss = norminv(x_unif);