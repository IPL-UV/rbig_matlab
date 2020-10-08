%
% USE: H_rbig = RBIG_MSMI(X,Y,PARAMS) 
%
% Computes de mutual information between two multidimensional datasets ('X' and 'Y') using RBIG
%
% INPUT: 
% - X = data matrix (#dimX x #samples)
% - Y = data matrix (#dimY x #samples)
%    while #dimX can be different of #dimY the #samples must be the same in X and Y 
% - PARAMS (optional): struct with the parameters for the RBIG function
% (see RBIG_2018.m)
%
% OUTPUT:
% - MI_rbig = mutual information between X and Y in bits
%

function MI_rbig = RBIG_MSMI(X,Y,PARAMS) 

if ~exist('PARAMS','var'), PARAMS = []; end
if ~isfield(PARAMS,'N_lay'), PARAMS.N_lay = 100000; end

[datXT_obs,TransX_obs,PARAMSX_obs] = RBIG_2018(X,PARAMS);
[datYT_obs,TransY_obs,PARAMSY_obs] = RBIG_2018(Y,PARAMS);

[datT_obs,Trans_obs,PARAMS_obs] = RBIG_2018([datXT_obs; datYT_obs],PARAMS);

MI_rbig = sum(cat(1,PARAMS_obs.MIs));