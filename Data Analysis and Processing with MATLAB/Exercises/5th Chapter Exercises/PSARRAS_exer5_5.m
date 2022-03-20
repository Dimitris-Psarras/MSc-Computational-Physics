%% Psarras Dimitrios
% Chapter 5: Exercise 5

clear; clc; close all;

data = importdata('lightair.dat');

air = data(:,1);
light = data(:,2);

dim = size(data);
n = dim(1);
a = 0.05;
N = 100;
n = 100;
M = 1000;

t_c = tinv(1-a/2,n-2);
b_0 = zeros(M,1);
b_1 = zeros(M,1);

for i=1:M
    data_b = data(unidrnd(N,n,1),:);
    air_b = data_b(:,1);
    light_b = data_b(:,2);
    
    mean_a_b = mean(air_b);
    mean_l_b = mean(light_b);
    S_xy = sum((air_b-mean_a_b).*(light_b-mean_l_b));
    S_xx = sum((air_b-mean_a_b).^2);
    S_yy = sum((light_b-mean_l_b).^2);
    b_1(i,1) = S_xy/S_xx;
    b_0(i,1) = mean_l_b - b_1(i,1)*mean_a_b;
end

st_0 = sort(b_0);
st_1 = sort(b_1);

b_l = round(a*M/2);
b_u = round((1-a/2)*M);

b_l_0 = st_0(b_l,:);
b_u_0 = st_0(b_u,:);

b_l_1 = st_1(b_l,:);
b_u_1 = st_1(b_u,:);

figure();
hold on;
histfit(b_0);
xline(b_l_0,'r',{'95% Confidence Interval','Lower Limit'});
xline(b_u_0,'r',{'95% Confidence Interval','Upper Limit'});
title('Histogram of b_{0} values');
xlabel('b_{0}');
ylabel('PDF');

figure();
hold on;
histfit(b_1);
xline(b_l_1,'r',{'95% Confidence Interval','Lower Limit'});
xline(b_u_1,'r',{'95% Confidence Interval','Upper Limit'});
title('Histogram of b_{1} values');
xlabel('b_{1}');
ylabel('PDF');

fprintf('<strong>Bootstrap:\n</strong>');

fprintf('%.0f%% Confidence Interval for constant b0: [%.4f, %.4f]\n',(1-a)*100,b_l_0, b_u_0);
fprintf('%.0f%% Confidence Interval for constant b1: [%.4f, %.4f]\n',(1-a)*100,b_l_1, b_u_1);


%% 5.4 repeat

fprintf('\n<strong>Repeat of 5.4 Parametric Results:\n</strong>');

mean_a = mean(air);
mean_l = mean(light);
S_xy = sum((air-mean_a).*(light-mean_l));
S_xx = sum((air-mean_a).^2);
S_yy = sum((light-mean_l).^2);
b_1 = S_xy/S_xx;
b_0 = mean_l - b_1*mean_a;

s_xy = S_xy/(n-1);
s_x = S_xx/(n-1);
s_y = S_yy/(n-1);

s_e = ((n-1)/(n-2))*(s_y-b_1^2*s_x);
s_b_1 = sqrt(s_e/S_xx);
s_b_0 = sqrt(s_e)*sqrt((1/n)+(mean_a^2/S_xx));

b_1_lower = b_1-t_c*s_b_1;
b_1_upper = b_1+t_c*s_b_1;
b_0_lower = b_0-t_c*s_b_0;
b_0_upper = b_0+t_c*s_b_0;


fprintf('Least Square Method y = b1*x + b0:\n');
fprintf('y = %.4f*x + %.4f\n\n', b_1, b_0);
fprintf('Variance of e:\ns_e\xB2 = %.4f\n\n', s_e);
fprintf('%.0f%% Confidence Interval for constant b0: [%.4f, %.4f]\n',(1-a)*100,b_0_lower, b_0_upper);
fprintf('%.0f%% Confidence Interval for constant b1: [%.4f, %.4f]\n',(1-a)*100,b_1_lower, b_1_upper);
