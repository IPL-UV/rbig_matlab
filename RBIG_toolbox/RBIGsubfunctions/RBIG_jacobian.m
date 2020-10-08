%
% Jacobian of the Transform 'Trans' in the x_ori point (original domain). 
% RBIG JACOBIAN
%
%      der(T(x0)) 
% J =  ------- 
%      der(x)
%
% (A^n G^n)' = A^n (g( (A^(n-1) G^(n-1)) )^n .* (A^(n-1) G^(n-1))')
%
% OUTPUTS:
% - J: Jacobian.
% - datT: x_ori transformed.

function [J datT] = RBIG_jacobian(x_ori,Trans)

DIM = size(Trans(1).V,1);
Ns = size(x_ori,2);
J = zeros(Ns,DIM,DIM);

x_parc = 1;
x0 = x_ori;
xx = zeros(DIM,Ns);
xx(x_parc,:) = ones;
for n=1:length(Trans)
    for dim=1:DIM
        [x_lin] = marginal_uniformizationB(x0(dim,:),Trans(n).TT(dim).T,1000);
        Tx0(dim,:) = norminv(x_lin);
        g(dim,:,n) = interp1(Trans(n).TT(dim).T.R_ant,Trans(n).TT(dim).T.p_ant,x0(dim,:)).*(1./normpdf(Tx0(dim,:)));

    end
    xx = (Trans(n).V')*(g(:,:,n).*xx);
    x0 = Trans(n).V'*Tx0;
end
J(:,:,x_parc) = xx';


if DIM>1
    for x_parc = 2:DIM
        xx = zeros(DIM,Ns);
        xx(x_parc,:) = ones;
        for n=1:length(Trans)
            xx = (Trans(n).V')*(g(:,:,n).*xx);
        end
        J(:,:,x_parc) = xx';
    end
end

datT = x0;

