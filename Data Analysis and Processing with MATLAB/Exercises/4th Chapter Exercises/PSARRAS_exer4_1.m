%% Psarras Dimitrios
% Chapter 4: Exercise 1

clear; clc;

%% A

% height h1 and h2 in cm
h1=100;
h2=[60 54 58 60 56];
%figure();
%histfit(h2);
% coefficient expected
e_exp=0.76;
a=0.05;
ea=sqrt(h2/h1);
mean_sima=mean(ea);

s=sqrt((1/(length(ea)-1))*sum((ea-mean_sima).^2));
s_h=s/sqrt(length(ea));

t=tinv(1-(a/2),length(ea)-1);

random_uncertainty=t*s;
standard_uncertainty=random_uncertainty/sqrt(length(ea));

disp('A.');
fprintf(['The standard deviation is : %4f\nThe standard deviation of mean is : %4f',...
    '\nThe critical value of student distribution t is: %4f\nThe random uncertainty value is : %4f',...
    '\nThe standard uncertainty value is : %4f\n\nThe random uncertainty on each measurement',...
    ' on an importatnce level a=%2f is : %4f +- %4f\nRegarding the uncertainty of the mean value of',...
    ' e on the same level of importance : %4f +- %4f\n\n'],s,s_h,t,random_uncertainty,standard_uncertainty,...
    a,mean_sima,random_uncertainty,mean_sima,standard_uncertainty);

%% B

M=1000;
n=5;
a=0.05;
h1=100;
mu=58;
sigma=2;

%expected
exp_e=sqrt(mu/h1);
exp_sigma=sigma;
exp_h2=58;
exp_sigma_e=(1/2)*sqrt(1/(h1*exp_h2))*exp_sigma;

%simulation
r = normrnd(mu,sigma,n,M);

mean_simb=mean(r);
figure();
hold on;
xline(exp_h2,'-r');
histogram(mean_simb);
legend("Expected\newline\mu_{h_2} = " + num2str(exp_h2));
title("Mean value \mu for h_2 (M = " + M + " samples)");
xlabel('Mean value, \mu_{h_2}, [cm]');
ylabel('Counts');
grid on;

std_simb=std(r);
figure();
hold on;
xline(exp_sigma,'-r');
histogram(std_simb);
legend("Expected\newline\sigma_{h_2} = " + num2str(exp_sigma));
title("Stansard deviation \sigma for h_2 (M = " + M + " samples)");
xlabel('Stansard deviation \sigma_{h_2}, [cm]');
ylabel('Counts');
grid on;

eb=sqrt(r./h1);
mean_eb=mean(eb);
figure();
hold on;
xline(exp_e,'-r');
histogram(mean_eb);
legend("Expected\newline\mu_{e} = " + num2str(exp_e));
title("Mean value \mu for coefficient e (M = " + M + " samples)");
xlabel('Mean value, \mu_{e}, [cm]');
ylabel('Counts');
grid on;

std_e_b=std(eb);
figure();
hold on;
xline(exp_sigma_e,'-r');
histogram(std_e_b);
legend("Expected\newline\sigma_{e} = " + num2str(exp_sigma_e));
title("Stansard deviation \sigma for e (M = " + M + " samples)");
xlabel('Stansard deviation \sigma_{e}, [cm]');
ylabel('Counts');
grid on;

%% C
h1_c=[80 100 90 120 95];
h2_c=[48 60 50 75 56];

uncertainty_h1=std(h1_c);
uncertainty_h2=std(h2_c);

e=sqrt(h2_c./h1_c);

mean_e_c=mean(e);
sigma_e_c=std(e);

disp('C.');
fprintf(['Regarding the measurements of h1 and h2 the value of the coefficient e is : %4f +- %4f\n',...
    'Hence the ball is fully inflated, since for these conditions the coefficient e has a value',...
    ' of 0.76.\n'],mean_e_c,sigma_e_c);