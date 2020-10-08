%
% USE: H_rbig = RBIG_entropy(dat,PARAMS)
%
% Computes de multidimensional diferential entropy of 'dat' using RBIG
%
% INPUT: 
% - dat: data matrix (#dim x #samples)
% - PARAMS (optional): struct with the parameters for the RBIG function
% (see RBIG_2018.m)
%
% OUTPUT:
% - H_rbig = multidimenal entropy of 'dat' in bits
%

function H_rbig = RBIG_entropy(dat,PARAMS)

if ~exist('PARAMS','var'), PARAMS = []; end
if ~isfield(PARAMS,'N_lay'), PARAMS.N_lay = 100000; end

[datT_obs,Trans_obs,PARAMS_obs]   = RBIG_2018(dat,PARAMS);
TC = sum(cat(1,PARAMS_obs.MIs));

%             figure,plot(cumsum(cat(1,PARAMS_obs.MIs)))
%             figure,plot(datT_obs(1,:),datT_obs(2,:),'.')

h = [];
for n=1:size(dat,1)
    Raux = linspace(min(dat(n,:)),max(dat(n,:)),sqrt(size(dat,2))+1);
    R = diff(Raux)/2+Raux(1:end-1);
    p = histcounts(dat(n,:),Raux);
    delta = R(3)-R(2);
    
    % mle estimator with miller-maddow correction
    c = 0.5 * (sum(p>0)-1)/sum(p);  % miller maddow correction
    p = p/sum(p);               % empirical estimate of the distribution
    idx = p~=0;
    H = -sum(p(idx).*log2(p(idx))) + c;     % plug-in estimator of the entropy with correction
    h(n) = H +log2(delta);
end

% H = \Sum_i h(dat_i) - TC(dat);
% where TC is total correlation
H_rbig = sum(h) - TC;

