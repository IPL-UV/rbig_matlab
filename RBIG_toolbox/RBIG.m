% RBIG: Rotation Based Iterative Gaussianization
%
% RBIG takes any set of d-dimensional data and learns the transform
% to turn them into a multivariate gaussian data set.
% It is based on iteratively alternating this processing units: 
%  (1) Marginal Gaussianization.
%  (2) Orthogonal transforms (rotations).
%
% For the general formulation, see the paper: 
%    Iterative Gaussianization: from ICA to Random Rotations
%    IEEE Trans. Neur. Nets. 2010
%    by Laparra, Camps and Malo
%
% In this implementation, marginal Gaussianization is done through 
% simple histogram equalization. In this way, no apriori parametrical 
% model for the marginals is assumed. The number of bins in the 
% 1D-histograms are chosen according to the square root of the number of
% samples.
% Equalization transforms for marginal Gaussianization are obtained by 
% interpolating the cumulative histograms at certain resolution (number 
% of samples in the support of the cumulative histograms). The support 
% of these functions may be chosen to coincide with the interval covered 
% by the samples, or extended by a certain percentage in order to generalize
% the model to new samples (which may lie outside the interval covered by 
% the training samples).
%
% The user can choose different families of orthogonal transforms:
%      'ICA' = Orthogonal ICA
%      'PCA' = PCA
%      'RND' = Random Rotations
%
% USE:  [datT,Trans] = RBIG(data,N_it,transform,porc,resolution)
%
% INPUT:
%
% - data = d*n data matrix ( d = #dimensions , n = #samples )
% - N_it = number of iterations
%           (see examples in the paper for an intuition of the appropriate 
%            number of iterations depending on the dimensionality)
% - porc = percentage of extension of the marginal PDF support 
%           (default 0.1)
% - resolution = number of points of the stored marginal PDFs (default 1000).
%          The univariate Gaussianization functions have to be stored for each
%          each dimension and each iteration. These are encoded as a look-up
%          table with "resolution" points.
%          When the number of dimensions or the number of iterations is high, 
%          one should reduce this number in order to reduce the storage
%          requirements.
% - transformation = rotation applied: 'RND','PCA','ICA' (default 'RND')
%
% OUTPUT:
%
% - datT = d*n matrix with Gaussianized data (zero mean and identity covariance
%          if the number of iterations was big enough to achieve
%          convergence).
% - Trans = 'Struct' array that contains the all the information about the transform. 
%          It stores the univariate Gaussianization functions and the rotation matrices 
%          for every iteration, k, in the fields:
%
%               Trans(k).TT(j).T   : data of the univariate transform of
%                                    dimension "j" at iteration "k"
%
%                                    Trans(k).TT(j).T.R_ant = support of
%                                    the considered marginal PDF at the 
%                                    considered iteration 
%
%                                    Trans(k).TT(j).T.p_ant = 
%                                    the considered marginal PDF at the 
%                                    considered iteration
%
%                                    Trans(k).TT(j).T.R = support of
%                                    the considered marginal CDF at the 
%                                    considered iteration 
%
%                                    Trans(k).TT(j).T.C = 
%                                    the considered marginal CDF at the 
%                                    considered iteration
%
%               Trans(k).V         : rotation matrix at iteration "k"
%
% EXAMPLE
%
% dat = randn(5)*rand(5,1000);
% Nit = 50;
% porc = 1;
% precision = 1000;
% transformation = 'PCA';
%
% [datT,Trans] = RBIG(dat,Nit,transformation,porc,precision);
%
%
% In order to use ICA as rotation is necessary to download the fastICA algorithm
% http://www.cis.hut.fi/projects/ica/fastica/code/FastICA_2.5.zip
%


function [datT,Trans] = RBIG(dat,Nit,transformation,porc,precision)

if ~exist('precision'), precision = 1000; end
Trans(1).precision = precision;

if ~exist('porc'), porc = .1; end
Trans(1).porc = porc;

if ~exist('transformation'), transformation = 'RND'; end

DIM = size(dat,1);
Nsamples = size(dat,2);

for n = 1:Nit

    % MARGINAL GAUSSIANIZATION STEP
    for dim = 1:DIM
        [dat(dim,:) T]= marginal_gaussianization(dat(dim,:),porc,precision);
        Trans(n).TT(dim).T = T;
    end


    % ROTATION STEP
    if transformation == 'RND'
        V = rand(DIM);
        
        V = V * inv(sqrtm(V'*V)); % orthogonalization
        V = V / (abs(det(V))^(1/size(V,1))); % normalization

        Trans(n).V = V;
        dat = V'*dat;

    elseif transformation == 'PCA'
        C = dat*dat'/size(dat,2);
        [V D] = eig(C);
        V = V / (abs(det(V))^(1/size(V,1)));
        Trans(n).V = V;
        dat = V'*dat;

    elseif transformation == 'ICA'
        try % fastica not allways converges
            [A, V] = fastica (dat,'whiteSig',dat,'whiteMat',eye(DIM),'dewhiteMat',eye(DIM),'stabilization','on','verbose', 'off', 'displayMode', 'off');
            V=V';
            V = V * inv(sqrtm(V'*V));
            V = V / (abs(det(V))^(1/size(V,1)));
            Trans(n).V = V;
            dat = V'*dat;
        catch
            break
        end
    end
end
datT = dat;
