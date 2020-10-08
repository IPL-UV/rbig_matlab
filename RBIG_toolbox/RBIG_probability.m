%
% This function obtains the probability of the data x0 in the distribution
% generated by some data that have been transformed with the function IG.m
% and have been obtained tha transform Trans.
% 
%
% USE: [P_dat P_datT detJ J] = RBIG_probability(x0,Trans,ns_prom)
%
% INPUTS:
% - x0 = point in which the pdf is evaluated
% - Trans = Transformation obtained by applying the function IG.m to some
% data (note that 'Trans' have all the information about the PDF of the
% data)
% - ns_prom = Since the estimation of the jacobian coul be noisy, 'ns_prom' is the
% number of samples to make an average of the probability estimation. By
% default ns_prom = 0;
%
% OUTPUTS:
% - P_dat: Probability of the x0 points
% - P_datT: Probability of the x0 points in the transformed (Gaussian)
% domain.
% - detJ: Determinant of the Jacobian of the X0 points;
% - J: Jacobian of the X0 points;
%

function [P_dat P_datT detJ J] =RBIG_probability(x0,Trans,ns_prom)

if ~exist('ns_prom'),ns_prom=0;end

rr = [repmat(std(x0')'/20,1,ns_prom).*randn(size(x0,1),ns_prom) zeros(size(x0,1),1)];
Nsamples = size(x0,2);
DIM = size(x0,1);
Nd = 2000;

for rep = 1:ns_prom+1

    mmod = mod(Nsamples,Nd);
    fflor = floor(Nsamples/Nd);

    J = zeros(Nsamples,DIM,DIM);
    x0_aux = x0+repmat(rr(:,rep),1,size(x0,2));
    dat_testT = zeros(size(x0_aux));

    for nn=1:Nd:fflor*Nd
        [J(nn:nn+Nd-1,:,:) dat_testT(:,nn:nn+Nd-1)] = RBIG_jacobian(x0_aux(:,nn:nn+Nd-1),Trans);
    end
    if mmod>0
        [J(fflor*Nd+1:end,:,:) dat_testT(:,fflor*Nd+1:end)] = RBIG_jacobian(x0_aux(:,fflor*Nd+1:end),Trans);
    end
    
    detJ = multi_det(J);

    P_datT(rep,:) = prod((1/sqrt(2*pi))*exp(-0.5.*(dat_testT.^2)));

    P_dat(rep,:) = P_datT(rep,:).*abs(detJ);
    P_dat(rep,find(isnan(P_dat(rep,:)))) = zeros;

end

P_dat = mean(P_dat,1);
P_datT = mean(P_datT,1);
detJ = mean(detJ,1);


