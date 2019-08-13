function [label, mu,datatmp,count,sse,matix] = kmeansplus(X,m,weidu)
% Perform kmeans clustering.
% Input:
%   X: d x n data matrix
%   m: initialization parameter
% Output:
%   label: 1 x n sample labels
%   mu: d x k center of clusters
%   energy: optimization target value
% alter Mo Chen's by Jiayu Lv
label = init(X, m);
n = numel(label); 
idx = 1:n;
last = zeros(1,n);
while any(label ~= last)
    [~,~,last(:)] = unique(label);                   % remove empty clusters
    mu = X*normalize(sparse(idx,last,1),1);         % compute cluster centers 
%     mu=kseeds(X,m);
    [row,line]=size(mu);
    for a=1:line
        contain(a,:)=(sum((X-mu(:,a)).^2,1));
    end
    [~,label]=min(contain,[],1);
%     [~,label] = min(dot(mu,mu,1)'/2-mu'*X,[],1);  % assign sample labels

end
% energy = dot(X(:),X(:),1)+2*sum(val);
datatmp=[X',label'];
[~,count]=size(unique(label));
sse=0;
for ni=1:count
    matix=datatmp(find(datatmp(:,weidu+1)==1),1:weidu);
    tmp=mu(:,ni)';
    [row,~]=size(matix);
    tmp=repmat(tmp,[row,1]);
    tmp=(matix-tmp).^2;
    tmp=sqrt(sum(tmp,2));
    tmp=sum(tmp);
    sse=sse+tmp;
end
sse=sse/m;

function label = init(X, m)
[d,n] = size(X);                           %返回数组的行和列 d为行 n为列
if numel(m) == 1                           % random initialization
%     mu = X(:,randperm(n,m));
    mu=kseeds(X,m);
%     [~,label] = min(dot(mu,mu,1)'/2-mu'*X,[],1); %每一列最小值的行向量
    [row,line]=size(mu);
    for i=1:line
        container(i,:)=(sum((X-mu(:,i)).^2,1));
    end
    [~,label]=min(container,[],1);
    save label.mat;
    %上面这个计算方法结算后是1/2 的与中心点间的距离的平方减去改点和原点间距离的平方
elseif all(size(m) == [1,n])               % init with labels
    label = m;
elseif size(m,1) == d                      % init with seeds (centers)
    [~,label] = min(dot(m,m,1)'/2-m'*X,[],1); %返回最小值索引
end
end
end
