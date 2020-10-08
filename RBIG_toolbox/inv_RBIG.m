%
% Function that computes the inverse transformation (Trans)
% obtained by RBIG over the data (dat).
%
% USE:
% [dat2] = inv_RBIG(datT,Trans)
%

function [dat2] = inv_RBIG(datT,Trans)

precision = Trans(1).precision;
DIM = size(datT,1);
dat2  =datT;

for n = length(Trans):-1:1
    
        V = Trans(n).V;
        dat2 = V*dat2;  
    
    for dim = 1:DIM
            [dat2(dim,:)]= inv_marginal_gaussianization(dat2(dim,:),Trans(n).TT(dim).T,precision);
    end          
end
