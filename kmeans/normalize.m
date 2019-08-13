function Y = normalize(X, dim)
% Normalize the vectors to be summing to one
%   By default dim = 1 (columns) dimָ������
% alter Mo Chen's by Jiayu Lv
if nargin == 1
    % Determine which dimension sum will use
    dim = find(size(X)~=1,1);
    if isempty(dim), dim = 1; end
end
Y = X./sum(X,dim); %����һ��0-1֮��ĳ���Ϊ1000���������У��ľ���