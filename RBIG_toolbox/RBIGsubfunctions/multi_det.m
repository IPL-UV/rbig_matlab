
% compute Ns determinants at the same time
%
% M is a (n,dim,dim) matrix where Ns is the number of matrices
% which we want to obtain the determinant

function DD = multi_det(MM)

[Ns dim dim] = size(MM);

for k=1:dim
    for i=k+1:dim
        
            MM(:,:,i) = MM(:,:,i) - MM(:,:,k).*repmat(MM(:,k,i)./MM(:,k,k),1,dim);
        
    end
end

QQ = zeros(dim,Ns);
for ii=1:dim
    QQ(ii,:) = MM(:,ii,ii);
end

DD = prod(QQ,1);




