%
% USE: H_rbig = RBIG_KLD(X,Y,PARAMS) 
%
% Computes de Kullback-Leibler divergence (KLD) between two multidimensional 
% probability distributions (pX and pY) using RBIG. In this case we only have data that
% came from these distributions ('X' and 'Y'). Note that the KLD is not symmetric.
% In this case KLD(X,Y) = \int_R pX(R) log pY(R)/pX(R) dR
% 
%
% INPUT: 
% - X = data matrix (#dimX x #samples)
% - Y = data matrix (#dimY x #samples)
%    while #dimX can be different of #dimY the #samples must be the same in X and Y 
% - PARAMS (optional): struct with the parameters for the RBIG function
% (see RBIG_2018.m)
%
% OUTPUT:
% - KLD_rbig = KLD between X and Y in bits
%

function [KLD_rbig MV_g m_g] = RBIG_KLD(X,Y,PARAMS) 

if ~exist('PARAMS','var'), PARAMS = []; end
if ~isfield(PARAMS,'N_lay'), PARAMS.N_lay = 100000; end
if ~isfield(PARAMS,'porc'), PARAMS.porc = 10; end

MV_g = [];
while(isempty(MV_g))
    try
        [datYT_obs,TransY_obs,PARAMSY_obs] = RBIG_2018(Y,PARAMS);
        [datXT_obs] = apply_RBIG_2018(X,TransY_obs);
        
        [datT_obs,Trans_obs,PARAMS_obs] = RBIG_2018(datXT_obs,PARAMS);
        MV_g = sum(cat(1,PARAMS_obs.MIs));
    catch
        PARAMS.porc = 1.5*PARAMS.porc
    end
end

marg_neg = [];
for ind_dim = 1:size(datXT_obs,1)
    marg_neg(ind_dim) = univ_negentropy_log2(datXT_obs(ind_dim,:),0,1);
end
m_g = sum(marg_neg);

KLD_rbig = MV_g + m_g;



function neg = univ_negentropy_log2(x,m,s)

% UNIV_NEGENTROPY computes the KL divergence of a univariate random
% variable 'x' to a Gaussian of mean 'm' and deviation 's'.
%
% The standard negentropy would imply using m=mean(x), s=std(x)
% Other interesting case is using m=0; s=1;
%
% USE: neg = univ_negentropy(x,m,s);
%
%    x = 1*n vector with n samples of the random variable.
%    m = mean of the Gaussian to campare to.
%    s = std of the Gaussian to compare to.
% 

Raux = linspace(min(x),max(x),round(sqrt(size(x,2)))+1);
Rx = diff(Raux)/2+Raux(1:end-1);

hx = ksdensity(x,Rx);
px = hx./(sum(hx)*(Rx(3)-Rx(2)));
pg = normpdf(Rx,0,1);

ii = find((px~=0)&(pg~=0));
vRx = Rx(3)-Rx(2);
neg = vRx*sum(px(ii).*log2(px(ii)./pg(ii)));             

if neg<0,neg=0;end


