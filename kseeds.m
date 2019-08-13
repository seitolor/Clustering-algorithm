function mu = kseeds(X, k)
% Perform kmeans++ seeding
% Input:
%   X: d x n data matrix
%   k: number of seeds
% Output:
%   label: 1 x n sample labels
%   mu: d x k seeds
%   energy: kmeans target value
% alter Mo Chen's by Jiayu Lv
n = size(X,2);
D = inf(1,n);
mu = X(:,ceil(n*rand));
for i = 2:k
    D = min(D,sum((X-mu(:,i-1)).^2,1));
    mu(:,i) = X(:,randp(D));
end
function i = randp(p)
% Sample a integer in [1:k] with given probability p
% p=normalize(p);
% save p.mat;
% i = find(rand<cumsum(p),1);
avg = mean(p);
lag = mode(p);
if(avg<lag)
    rankbase=lag;
else
    rankbase=avg;
end
i=find(p>rankbase,1);
