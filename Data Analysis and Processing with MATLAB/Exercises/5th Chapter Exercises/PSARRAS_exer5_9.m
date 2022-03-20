%% Psarras Dimitrios
% Chapter 5: Exercise 9

clear; clc; close all;

physical = importdata('hospital.txt','\t',1);
data = physical.data;
colheaders = physical.colheaders;
n = length(data);
mass = data(:,1);
data(:,1) = [];
k = size(data,2);

%% Linear Method for all variables

fprintf('Linear regression applied to all variables\n\n');
fprintf('Table of variables and their b coefficients\n');

alpha = 0.05;
x_data = [ones(n,1), data];
[b,bint] = regress(mass, x_data,alpha);
y_reg = x_data * b;
s_e2 = sum((mass-y_reg).^2)/(n-k-1);
R2 = 1 - (sum((mass-y_reg).^2))/(sum((mass-mean(mass)).^2));
adj_R2 = 1 - ((n-1)/(n-k-1))*(sum((mass-y_reg).^2))/(sum((mass-mean(mass)).^2));

fprintf('Variables\tb coefficients\t\t95%% Confidence Interval\n');
fprintf('Constant\t%.3f\t\t\t[%.3f %.3f]\n', b(1), bint(1,1), bint(1,2))

for i=1:k
    fprintf('%8s\t', colheaders{i+1})
    fprintf('%.3f\t\t\t\t',b(i+1));
    fprintf('[%.3f %.3f]\n', bint(i+1,1), bint(i+1,2));
end

fprintf('\nVariance of errors: s_e^2 = %.5f\n', s_e2);
fprintf('R^2 = %.5f\n', R2);
fprintf('adjR^2 = %.5f\n', adj_R2);

%% Stepwise
fprintf('\nStepwise Method applied from Matlab.\n\n');
fprintf('Table of variables and their b coefficients\n');

[b,se,pval,finalmodel,stats,nextstep,history] = stepwisefit(data,mass);
b_stepwise = [stats.intercept ; history.B(:,end)];
se_stepwise = se(history.B(:,end)>0);
k_stepwise = sum(finalmodel);
t_critical = tinv(1-alpha/2,n-k_stepwise-1);
ci_stepwise(:,1) = b(history.B(:,end)>0) - t_critical*se_stepwise;
ci_stepwise(:,2) = b(history.B(:,end)>0) + t_critical*se_stepwise;

y_reg_stepwise = x_data() * b_stepwise;
s_e2_stepwise = sum((mass-y_reg_stepwise).^2)/(n-k_stepwise-1);
R2_stepwise = 1 - (sum((mass-y_reg_stepwise).^2))/(sum((mass-mean(mass)).^2));
adj_R2_stepwise = 1 - ((n-1)/(n-k_stepwise-1))*(sum((mass-y_reg_stepwise).^2))/(sum((mass-mean(mass)).^2));

fprintf('Variables\tb coefficients\t\t95%% Confidence Interval\n');
fprintf('Constant\t%.3f\n', b_stepwise(1))

counter = 0;
for i=find(history.in(end,:))
    counter=counter+1;
    fprintf('%8s\t', colheaders{i+1})
    fprintf('%.3f\t\t\t\t',b_stepwise(i+1));
    fprintf('[%.3f %.3f]\n', ci_stepwise(counter,1), ci_stepwise(counter,2));
end

fprintf('\nVariance of errors: s_e^2 = %.5f\n', s_e2_stepwise);
fprintf('R^2 = %.5f\n', R2_stepwise);
fprintf('adjR^2 = %.5f\n', adj_R2_stepwise);

%% Check for multicollinearity


for i=1:k
    fprintf('\nRegression Model for Variable: %s', colheaders{i+1})
    k_mc = k-1;
    y_data_mc = data(:,i);
    x_data_mc = data;
    x_data_mc(:,i) = [];
    x_data_mc = [ones(n,1), x_data_mc];
    [b_mc,bint] = regress(y_data_mc, x_data_mc,alpha);
    y_reg_mc = x_data_mc * b_mc;
    s_e2_mc = sum((y_data_mc-y_reg_mc).^2)/(n-k_mc-1);
    R2_mc = 1 - (sum((y_data_mc-y_reg_mc).^2))/(sum((y_data_mc-mean(y_data_mc)).^2));
    adj_R2_mc = 1 - ((n-1)/(n-k_mc-1))*(sum((y_data_mc-y_reg_mc).^2))/(sum((y_data_mc-mean(y_data_mc)).^2));
    
    fprintf('\nR^2 = %.5f\n', R2_mc);
    fprintf('adjR^2 = %.5f\n', adj_R2_mc);
end