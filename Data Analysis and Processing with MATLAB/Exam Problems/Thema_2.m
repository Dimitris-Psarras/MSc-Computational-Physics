%% Psarras Dimitrios
% AEM = 4407
% Thema 2

clear; clc; close all;

physical = importdata('physical.txt','\t',1);
K = physical.data;
colheaders = physical.colheaders;
n = length(K);
mass = K(:,1);
K(:,1) = [];
k = size(K,2);

b = 3;

n = Polynomial_Stepwise(K,mass,b);

fprintf('Oi epexigimatikes metablhtes poy epilegontai einai:\n');
for i = 1:length(n)
    fprintf('%d.  %s\n',i,colheaders{n(i)});
end