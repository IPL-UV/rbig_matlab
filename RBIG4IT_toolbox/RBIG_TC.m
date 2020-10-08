%
% USE: H_rbig = RBIG_TC(dat,PARAMS)
%
% Computes de total correlation of 'dat' using RBIG
%
% INPUT: 
% - dat: data matrix (#dim x #samples)
% - PARAMS (optional): struct with the parameters for the RBIG function
% (see RBIG_2018.m)
%
% OUTPUT:
% - TC_rbig = total correlation of 'dat' in bits
%

function TC_rbig = RBIG_TC(dat,PARAMS) 

if ~exist('PARAMS','var'), PARAMS = []; end
if ~isfield(PARAMS,'N_lay'), PARAMS.N_lay = 100000; end
[datT_obs,Trans_obs,PARAMS_obs] = RBIG_2018(dat,PARAMS);

TC_rbig = sum(cat(1,PARAMS_obs.MIs));