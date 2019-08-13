function Y = normalize(X, dim)
% Normalize the vectors to be summing to one
%   By default dim = 1 (columns) dim指的是列
% alter Mo Chen's by Jiayu Lv
if nargin == 1
    % Determine which dimension sum will use
    dim = find(size(X)~=1,1);
    if isempty(dim), dim = 1; end
end
Y = X./sum(X,dim); %返回一个0-1之间的长度为1000（本数据中）的矩阵