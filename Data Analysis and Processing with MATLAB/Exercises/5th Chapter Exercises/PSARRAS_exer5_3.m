%% Psarras Dimitrios
% Chapter 5: Exercise 3

clear; clc; close all;

L = 1000;

data_r = importdata('rainThes59_97.dat');
data_t = importdata('tempThes59_97.dat');
[years,months] = size(data_r);

a = 0.05;
t_c = tinv(1-a/2,years-2);
rho = zeros(L:1);
t_l = round(a*L/2);
t_u = round((1-a/2)*L);

for i=1:months
    fprintf('\n<strong>Month: %d\n</strong>',i);
    fprintf("%s",repmat("-",7));
    [R,P,RL,RU] = corrcoef(data_r(:,i),data_t(:,i));
    
    t_sample = R(1,2)*sqrt((years-2)/(1-(R(1,2)^2)));
    pr = tcdf(abs(t_sample),years-2);
    p = 2*(1-pr);
    
    for j=1:L
        random_sim =[data_r(:,i) data_t(randperm(years),i)];
        
        [R_r,P_r,RL_r,RU_r] = corrcoef(random_sim);
        
        rho(j) = R_r(1,2);
    end
    
    t = rho.*sqrt((years-2)./(1-(rho.^2)));
    st = sort(t);
    t_l_s = st(t_l);
    t_u_s = st(t_u);
    
    
    if abs(t_sample) < t_c
        fprintf("\nThe parametric hypothesis H0 is accepted.\np value is p = %.4f\n|t_sample| = %.4f < t_n,1-a/2 = %.4f\n",p,abs(t_sample),t_c);
    else
        fprintf("\nThe parametric hypothesis H0 is rejected.\np value is p = %.4f\n|t_sample| = %.4f > t_n,1-a/2 = %.4f\n",p,abs(t_sample),t_c);
    end
    if t_l_s < t_sample && t_sample < t_u_s
        fprintf("\nThe non-parametric hypothesis H0 is accepted.\n|t_sample| = %.4f in range of [%.4f, %.4f]\n",abs(t_sample),t_l_s,t_u_s);
    else
        fprintf("\nThe non-parametric hypothesis H0 is rejected.\n|t_sample| = %.4f in range of [%.4f, %.4f]\n",abs(t_sample),t_l_s,t_u_s);
    end
    fprintf("%s",repmat("-",7));
end
fprintf("\n");