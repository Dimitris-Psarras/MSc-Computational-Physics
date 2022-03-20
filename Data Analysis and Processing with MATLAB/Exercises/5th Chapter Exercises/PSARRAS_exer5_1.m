%% Psarras Dimitrios
% Chapter 5: Exercise 1

clear; clc; close all;

%rng('default');

M = 1000;
n = 20;
a = 0.05;

r_1= 0;
r_2 = 0.5;

x_mu = 0;
y_mu = 0;

sigma_x = 1;
sigma_y = 1;
sigma_xy_1 = r_1*sigma_x*sigma_y;
sigma_xy_2 = r_2*sigma_x*sigma_y;

mu=[x_mu y_mu];
sigma_1=[sigma_x^2 sigma_xy_1; sigma_xy_1 sigma_y^2];
sigma_2=[sigma_x^2 sigma_xy_2; sigma_xy_2 sigma_y^2];

rhoo_1 = zeros(M,1);
rhoo_2 = zeros(M,1);

x_1 = zeros(n,M);
y_1 = zeros(n,M);
x_2 = zeros(n,M);
y_2 = zeros(n,M);

%% A.

disp('A.');

for i=1:M
    xy_1=mvnrnd(mu,sigma_1,n);
    xy_2=mvnrnd(mu,sigma_2,n);
    
    [R_1,P_1,RL_1,RU_1] = corrcoef(xy_1);
    [R_2,P_2,RL_2,RU_2] = corrcoef(xy_2);
    
    rhoo_1(i,:) = R_1(1,2);
    rhoo_2(i,:) = R_2(1,2);
    
    x_1(:,1)=xy_1(:,1);
    y_1(:,1)=xy_1(:,2);
    
    x_2(:,1)=xy_2(:,1);
    y_2(:,1)=xy_2(:,2);
end

z_1 = 0.5*log((1+rhoo_1)./(1-rhoo_1));
z_2 = 0.5*log((1+rhoo_2)./(1-rhoo_2));

z_c = norminv(1-a/2);
sigma_z = sqrt(1/(n-3));

z_lower_1 = z_1-sigma_z*z_c;
z_upper_1 = z_1+sigma_z*z_c;
z_lower_2 = z_2-sigma_z*z_c;
z_upper_2 = z_2+sigma_z*z_c;

count_1 = length(find(z_lower_1<r_1 & z_upper_1>r_1));

count_2 = length(find(z_lower_2<r_2 & z_upper_2>r_2));

z_ratio_1 = 100*count_1/M;
z_ratio_2 = 100*count_2/M;

fprintf('ñ = %d: Confidence Interval (CI) includes the value of ñ at %.2f%%\n', r_1,...
    z_ratio_1);
fprintf('ñ = %d: Confidence Interval (CI) includes the value of ñ at %.2f%%\n', r_2,...
    z_ratio_2);

figure();
histfit(z_1);
title("z Distribution for M = "+ M +", n = "+n+" and ñ = "...
    + r_1);
xlabel('z');
ylabel('Counts');
figure();
hold on
histogram(z_lower_1);
histogram(z_upper_1);
legend('Lower Limit','Upper Limit');
title("Confidence Inteval for M = "+ M +", n = "+n+" and ñ = "...
    + r_1);
xlabel('z');
ylabel('Counts');
hold off

figure();
histfit(z_2);
title("z Distribution for M = "+ M +", n = "+n+" and ñ = "...
    + r_2);
xlabel('z');
ylabel('Counts');
figure();
hold on
histogram(z_lower_2);
histogram(z_upper_2);
legend('Lower Limit','Upper Limit');
title("Confidence Inteval for M = "+ M +", n = "+n+" and ñ = "...
    + r_2);
xlabel('z');
ylabel('Counts');
hold off

%% B.

disp('B.');

t_1 = rhoo_1.*sqrt((n-2)./(1-(rhoo_1.^2)));
t_2 = rhoo_2.*sqrt((n-2)./(1-(rhoo_2.^2)));

t_c = tinv(1-a/2,n-2);

tt_1 = length(find(abs(t_1)<t_c));
tt_2 = length(find(abs(t_2)<t_c));

p_1 = 1-tt_1/M;
p_2 = 1-tt_2/M;

fprintf('ñ = %d: Null correlation hypothesis has p_value = %.4f\n', r_1,...
    p_1);
fprintf('ñ = %d: null correlation hypothesis has p_value = %.4f\n', r_2,...
    p_2);

%% C.

disp('C.');

n=200;
x_1 = zeros(n,M);
y_1 = zeros(n,M);
x_2 = zeros(n,M);
y_2 = zeros(n,M);

for i=1:M
    xy_1=mvnrnd(mu,sigma_1,n);
    xy_2=mvnrnd(mu,sigma_2,n);
    
    [R_1,P_1,RL_1,RU_1] = corrcoef(xy_1);
    [R_2,P_2,RL_2,RU_2] = corrcoef(xy_2);
    
    rhoo_1(i,:) = R_1(1,2);
    rhoo_2(i,:) = R_2(1,2);
    
    x_1(:,1)=xy_1(:,1);
    y_1(:,1)=xy_1(:,2);
    
    x_2(:,1)=xy_2(:,1);
    y_2(:,1)=xy_2(:,2);
end

z_1 = 0.5*log((1+rhoo_1)./(1-rhoo_1));
z_2 = 0.5*log((1+rhoo_2)./(1-rhoo_2));

z_c = norminv(1-a/2);
sigma_z = sqrt(1/(n-3));

z_lower_1 = z_1-sigma_z*z_c;
z_upper_1 = z_1+sigma_z*z_c;
z_lower_2 = z_2-sigma_z*z_c;
z_upper_2 = z_2+sigma_z*z_c;

count_1 = length(find(z_lower_1<r_1 & z_upper_1>r_1));

count_2 = length(find(z_lower_2<r_2 & z_upper_2>r_2));

z_ratio_1 = 100*count_1/M;
z_ratio_2 = 100*count_2/M;

fprintf('ñ = %d: Confidence Interval (CI) includes the value of ñ at %.2f%%\n', r_1,...
    z_ratio_1);
fprintf('ñ = %d: Confidence Interval (CI) includes the value of ñ at %.2f%%\n', r_2,...
    z_ratio_2);

figure();
hold on
histogram(z_lower_1);
histogram(z_upper_1);
legend('Lower Limit','Upper Limit');
title("Confidence Inteval for M = "+ M +", n = "+n+" and ñ = "...
    + r_1);
xlabel('z');
ylabel('Counts');
hold off

figure();
hold on
histogram(z_lower_2);
histogram(z_upper_2);
legend('Lower Limit','Upper Limit');
title("Confidence Inteval for M = "+ M +", n = "+n+" and ñ = "...
    + r_2);
xlabel('z');
ylabel('Counts');
hold off

t_1 = rhoo_1.*sqrt((n-2)./(1-(rhoo_1.^2)));
t_2 = rhoo_2.*sqrt((n-2)./(1-(rhoo_2.^2)));

t_c = tinv(1-a/2,n-2);

tt_1 = length(find(abs(t_1)<t_c));
tt_2 = length(find(abs(t_2)<t_c));

p_1 = 1-tt_1/M;
p_2 = 1-tt_2/M;

fprintf('ñ = %d: Null correlation hypothesis has p_value = %.4f\n', r_1,...
    p_1);
fprintf('ñ = %d: null correlation hypothesis has p_value = %.4f\n', r_2,...
    p_2);


%% D.

disp('D.');

n=200;

r_1 = r_1^2;
r_2 = r_2^2;

x_1 = zeros(n,M);
y_1 = zeros(n,M);
x_2 = zeros(n,M);
y_2 = zeros(n,M);

for i=1:M
    xy_1=mvnrnd(mu,sigma_1,n).^2;
    xy_2=mvnrnd(mu,sigma_2,n).^2;
    
    [R_1,P_1,RL_1,RU_1] = corrcoef(xy_1);
    [R_2,P_2,RL_2,RU_2] = corrcoef(xy_2);
    
    rhoo_1(i,:) = R_1(1,2);
    rhoo_2(i,:) = R_2(1,2);
    
    x_1(:,1)=xy_1(:,1);
    y_1(:,1)=xy_1(:,2);
    
    x_2(:,1)=xy_2(:,1);
    y_2(:,1)=xy_2(:,2);
end

z_1 = 0.5*log((1+rhoo_1)./(1-rhoo_1));
z_2 = 0.5*log((1+rhoo_2)./(1-rhoo_2));

z_c = norminv(1-a/2);
sigma_z = sqrt(1/(n-3));

z_lower_1 = z_1-sigma_z*z_c;
z_upper_1 = z_1+sigma_z*z_c;
z_lower_2 = z_2-sigma_z*z_c;
z_upper_2 = z_2+sigma_z*z_c;

count_1 = length(find(z_lower_1<r_1 & z_upper_1>r_1));

count_2 = length(find(z_lower_2<r_2 & z_upper_2>r_2));

z_ratio_1 = 100*count_1/M;
z_ratio_2 = 100*count_2/M;

fprintf('ñ = %d: Confidence Interval (CI) includes the value of ñ at %.2f%%\n', r_1,...
    z_ratio_1);
fprintf('ñ = %d: Confidence Interval (CI) includes the value of ñ at %.2f%%\n', r_2,...
    z_ratio_2);

figure();
hold on
histogram(z_lower_1);
histogram(z_upper_1);
legend('Lower Limit','Upper Limit');
title("Confidence Inteval for M = "+ M +", n = "+n+" and ñ = "...
    + r_1);
xlabel('z');
ylabel('Counts');
hold off

figure();
hold on
histogram(z_lower_2);
histogram(z_upper_2);
legend('Lower Limit','Upper Limit');
title("Confidence Inteval for M = "+ M +", n = "+n+" and ñ = "...
    + r_2);
xlabel('z');
ylabel('Counts');
hold off

t_1 = rhoo_1.*sqrt((n-2)./(1-(rhoo_1.^2)));
t_2 = rhoo_2.*sqrt((n-2)./(1-(rhoo_2.^2)));

t_c = tinv(1-a/2,n-2);

tt_1 = length(find(abs(t_1)<t_c));
tt_2 = length(find(abs(t_2)<t_c));

p_1 = 1-tt_1/M;
p_2 = 1-tt_2/M;

fprintf('ñ = %d: Null correlation hypothesis has p_value = %.4f\n', r_1,...
    p_1);
fprintf('ñ = %d: null correlation hypothesis has p_value = %.4f\n', r_2,...
    p_2);