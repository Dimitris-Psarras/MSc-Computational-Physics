%% Psarras Dimitrios
% Chapter 5: Exercise 2

clear; clc;

%% A.

disp('A.');

clear; clc; close all;

%rng('default');
w = waitbar(0, 'Starting');
L = 1000;
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

rhoo_1 = zeros(L+1,M);
rhoo_2 = zeros(L+1,M);

for i=1:M
    xy_1=mvnrnd(mu,sigma_1,n);
    xy_2=mvnrnd(mu,sigma_2,n);
    
    [R_1,P_1,RL_1,RU_1] = corrcoef(xy_1);
    [R_2,P_2,RL_2,RU_2] = corrcoef(xy_2);
    
    rhoo_1(1,i) = R_1(1,2);
    rhoo_2(1,i) = R_2(1,2);
    
    for j=1:L
        random_sim_1 =[xy_1(:,1) xy_1(randperm(n),2)];
        %xy_1_r = xy_1(randperm(n),2);
        
        [R_1_r,P_1_r,RL_1_r,RU_1_r] = corrcoef(random_sim_1);
        %[R_1_r,P_1_r,RL_1_r,RU_1_r] = corrcoef(xy_1(:,1),xy_1_r);
        
        rhoo_1(j+1,i) = R_1_r(1,2);
        
        random_sim_2 =[xy_2(:,1) xy_2(randperm(n),2)];
        %xy_2_r = xy_2(randperm(n),2);
        
        [R_2_r,P_2_r,RL_2_r,RU_2_r] = corrcoef(random_sim_2);
        %[R_2_r,P_2_r,RL_2_r,RU_2_r] = corrcoef(xy_2(:,1),xy_2_r);
        
        rhoo_2(j+1,i) = R_2_r(1,2);
    end
    waitbar(i/M, w, sprintf('Progress: %d %%', floor(i/M*100)));
end
close(w)

t_1 = rhoo_1.*sqrt((n-2)./(1-(rhoo_1.^2)));
t_2 = rhoo_2.*sqrt((n-2)./(1-(rhoo_2.^2)));

st_1 = sort(t_1(2:L+1,:));
st_2 = sort(t_2(2:L+1,:));

t_l = round(a*L/2);
t_u = round((1-a/2)*L);

t_l_1 = st_1(t_l,:);
t_u_1 = st_1(t_u,:);

t_l_2 = st_2(t_l,:);
t_u_2 = st_2(t_u,:);

tt_1 = length(find(t_1(1,:)-t_l_1<0 | t_1(1,:)-t_u_1>0));
tt_2 = length(find(t_2(1,:)-t_l_2<0 | t_2(1,:)-t_u_2>0));

p1 = tt_1/M;
p2 = tt_2/M;

fprintf(['(X,Y), M = %d, L = %d, n = %d, ñ = %f: p = %.4f.\n'], M, L, n, r_1, p1);
fprintf(['(X,Y), M = %d, L = %d, n = %d, ñ = %f: p = %.4f.\n'], M, L, n, r_2, p2);

%% B.

clear;

w = waitbar(0, 'Starting');
L = 1000;
M = 1000;
n = 20;
a = 0.05;

r_1= 0;
r_2 = 0.5^2;

x_mu = 0;
y_mu = 0;

sigma_x = 1;
sigma_y = 1;
sigma_xy_1 = r_1*sigma_x*sigma_y;
sigma_xy_2 = r_2*sigma_x*sigma_y;

mu=[x_mu y_mu];
sigma_1=[sigma_x^2 sigma_xy_1; sigma_xy_1 sigma_y^2];
sigma_2=[sigma_x^2 sigma_xy_2; sigma_xy_2 sigma_y^2];

rhoo_1 = zeros(L+1,M);
rhoo_2 = zeros(L+1,M);

for i=1:M
    xy_1=mvnrnd(mu,sigma_1,n).^2;
    xy_2=mvnrnd(mu,sigma_2,n).^2;
    
    [R_1,P_1,RL_1,RU_1] = corrcoef(xy_1);
    [R_2,P_2,RL_2,RU_2] = corrcoef(xy_2);
    
    rhoo_1(1,i) = R_1(1,2);
    rhoo_2(1,i) = R_2(1,2);
    
    for j=1:L
        random_sim_1 =[xy_1(:,1) xy_1(randperm(n),2)];
        %xy_1_r = xy_1(randperm(n),2);
        
        [R_1_r,P_1_r,RL_1_r,RU_1_r] = corrcoef(random_sim_1);
        %[R_1_r,P_1_r,RL_1_r,RU_1_r] = corrcoef(xy_1(:,1),xy_1_r);
        
        rhoo_1(j+1,i) = R_1_r(1,2);
        
        random_sim_2 =[xy_2(:,1) xy_2(randperm(n),2)];
        %xy_2_r = xy_2(randperm(n),2);
        
        [R_2_r,P_2_r,RL_2_r,RU_2_r] = corrcoef(random_sim_2);
        %[R_2_r,P_2_r,RL_2_r,RU_2_r] = corrcoef(xy_2(:,1),xy_2_r);
        
        rhoo_2(j+1,i) = R_2_r(1,2);
    end
    waitbar(i/M, w, sprintf('Progress: %d %%', floor(i/M*100)));
end
close(w)

t_1 = rhoo_1.*sqrt((n-2)./(1-(rhoo_1.^2)));
t_2 = rhoo_2.*sqrt((n-2)./(1-(rhoo_2.^2)));

st_1 = sort(t_1(2:L+1,:));
st_2 = sort(t_2(2:L+1,:));

t_l = round(a*L/2);
t_u = round((1-a/2)*L);

t_l_1 = st_1(t_l,:);
t_u_1 = st_1(t_u,:);

t_l_2 = st_2(t_l,:);
t_u_2 = st_2(t_u,:);

tt_1 = length(find(t_1(1,:)-t_l_1<0 | t_1(1,:)-t_u_1>0));
tt_2 = length(find(t_2(1,:)-t_l_2<0 | t_2(1,:)-t_u_2>0));

p1 = tt_1/M;
p2 = tt_2/M;

fprintf(['(X^2,Y^2), M = %d, L = %d, n = %d, ñ = %f: p = %.4f.\n'], M, L, n, r_1, p1);
fprintf(['(X^2,Y^2), M = %d, L = %d, n = %d, ñ = %f: p = %.4f.\n'], M, L, n, r_2, p2);