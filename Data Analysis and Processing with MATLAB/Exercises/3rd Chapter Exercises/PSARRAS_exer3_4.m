%% Psarras Dimitrios
% Chapter 3: Exercise 4

clear; clc;

data=[41 46 47 47 48 50 50 50 50 50 50 50 48 50 50 50 50 50 50 50 52 52 53 ...
    55 50 50 50 50 52 52 53 53 53 53 53 57 52 52 53 53 53 53 53 53 54 54 55 68];

sd=5;
s_mean=52;

fprintf('a.\n');
[h1,p1,ci1,stats1] = vartest(data,sd^2);
fprintf('At the 95 percentage significance level the confidence interval for the variance is [%.4f,%.4f]: \n',ci1(1),ci1(2));
fprintf('At the 95 percentage significance level the confidence interval for the standrad deviation is [%.4f,%.4f]: \n',sqrt(ci1(1)),sqrt(ci1(2)));

fprintf('\nb.\n');
if h1==0
    fprintf('Hypothesis that the data comes from a normal distribution with variance 5 keV is: True\n');
elseif h1==1
    fprintf('Hypothesis that the data comes from a normal distribution with variance 5 keV is: False\n');
end
fprintf('The p-value for the hypothesis is: p=%4f\n',p1);

fprintf('\nc.\n');
[h2,p2,ci2,stats2] = ttest(data,s_mean);
fprintf('At the 95 percentage significance level the confidence interval for the mean value is [%.4f,%.4f]: \n',ci2(1),ci2(2));

fprintf('\nd.\n');
if h2==0
    fprintf('Hypothesis that the data comes from a normal distribution with mean value equal to 52 keV is: True\n');
elseif h2==1
    fprintf('Hypothesis that the data comes from a normal distribution with mean value equal to 52 keV is: False\n');
end
fprintf('The p-value for the hypothesis is: p=%4f\n',p2);

fprintf('\ne.\n');

[h3,p3,stats] = chi2gof(data);
if h3==0
    fprintf('Hypothesis that the data comes from a normal distribution  at the 5 percentage significance level, is: True\n');
elseif h3==1
    fprintf('Alternative hypothesis that the data does not come from a normal distribution  at the 5 percentage significance level, is: True\n');
end
fprintf('The p-value for the hypothesis is: p=%4f\n',p3);