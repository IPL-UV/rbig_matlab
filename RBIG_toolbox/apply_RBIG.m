%
% This function apply to the data 'dat' ther transformaction 'Trans' obtained with
% the RBIG.m function. 
% datT is the transformed data.
%
% USE:
%
% [datT] = apply_RBIG(dat,Trans);
%

function [datT] = apply_RBIG(dat,Trans)

DIM = size(dat,1);
Ns = size(dat,2);
precision = Trans(1).precision;

% It is computationally faster to compute the transformation in groups of 500000

Nd = 500000;
mmod = mod(Ns,Nd);
fflor = floor(Ns/Nd);

datT = zeros(size(dat));


for nn=1:Nd:fflor*Nd
    dat0 = dat(:,nn:nn+Nd-1);
    for n = 1:length(Trans)
        % n
        for dim = 1:DIM
            [dat0(dim,:)]= marginal_gaussianizationB(dat0(dim,:),Trans(n).TT(dim).T,precision);
        end

        V = Trans(n).V;
        dat0 = V'*dat0;
    end
    datT(:,nn:nn+Nd-1) = dat0;
end

if mmod>0
        dat0 = dat(:,fflor*Nd+1:end);
    for n = 1:length(Trans)
        % n
        for dim = 1:DIM
            [dat0(dim,:)]= marginal_gaussianizationB(dat0(dim,:),Trans(n).TT(dim).T,precision);
        end

        V = Trans(n).V;
        dat0 = V'*dat0;
    end
    datT(:,fflor*Nd+1:end) = dat0;
end

