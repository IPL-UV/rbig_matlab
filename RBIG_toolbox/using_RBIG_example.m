
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Example of using RBIG toolbox
%%% (synthesis and pdf estimation example)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all

Ns = 10000;

x = abs(2*randn(1,Ns));
y = sin(x) + 0.25*randn(1,Ns);
dat = [x;y];

figure
plot(dat(1,:),dat(2,:),'.')
axis square,title('original data')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Obtaining the RBIG transformation of the data 
% using PCA rotation and 500 iterations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[datT Trans] = RBIG(dat,50,'PCA');

figure
plot(datT(1,:),datT(2,:),'.')
axis equal,axis square,axis([-4 4 -4 4]),title('transformed data')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generating random Gaussian data 
% mean = 0, covariance matrix = I 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

datR = randn(size(dat,1),size(dat,2));
figure
plot(datR(1,:),datR(2,:),'.')
axis equal,axis square,axis([-4 4 -4 4]),title('random Gaussian data')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inverting the random data
% (Obtaining the synthesized data)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

datRI = inv_RBIG(datR,Trans);
figure
plot(datRI(1,:),datRI(2,:),'.'),axis equal,axis square,title('inverted (synthesized) data')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Estimating the PDF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Points in which we want to estimate the pdf
x0 = linspace(min(dat(1,:)),max(dat(1,:)),51);
y0 = linspace(min(dat(2,:)),max(dat(2,:)),51);
[XX YY] = meshgrid(x0,y0);
pdf_domain = [XX(:)';YY(:)'];

% Estimating the pdf with IG 
% Note that 'Trans' have been estimated in the previous step
[P_dat P_datT detJ J] = RBIG_probability(pdf_domain,Trans,20);

% Estimating the pdf with a 2D-Histogram
[H R] = hist3(dat',[51 51]);
pH = H/(sum(H(:))*(R{1}(3)-R{1}(2))*(R{2}(3)-R{2}(2)));

figure,imagesc(reshape(P_dat,51,51)),title('Estimated pdf with RBIG')
figure,imagesc(pH'),title('Estimated pdf with 2D-histogram')


