%% Psarras Dimitrios
% Chapter 3: Exercise 5

clear; clc;

data = importdata('eruption.dat.txt');

w_sd=10;
d_sd=1;
w_mean=75;
d_mean=2.5;

%% Column 1: Waiting Time (min) (year:1989)
fprintf('<strong>Waiting time (1989):\n</strong>');
fprintf('<strong>a.\n</strong>');
[h11,p11,ci11,stats11] = vartest(data(:,1),w_sd^2);
fprintf(['At the 95 percentage significance level the confidence interval for the standrad deviation is [%.4f,%.4f]: \n'],sqrt(ci11(1)),sqrt(ci11(2)));

if h11==0
    fprintf('Hypothesis that the data comes from a normal distribution with standrad deviation 10 min is: True\n'); 
elseif h11==1
    fprintf('Hypothesis that the data comes from a normal distribution with standrad deviation 10 min is: False\n');
end
fprintf('The p-value for the hypothesis is: p=%4f\n',p11);

fprintf('<strong>b.\n</strong>');
[h21,p21,ci21,stats21] = ttest(data(:,1),w_mean);
fprintf(['At the 95 percentage significance level the confidence interval for the mean value is [%.4f,%.4f]: \n'],ci21(1),ci21(2));
if h21==0
    fprintf('Hypothesis that the data comes from a normal distribution with mean value equal to 75 min is: True\n');
elseif h21==1
    fprintf('Hypothesis that the data comes from a normal distribution with mean value equal to 75 min is: False\n');
end
fprintf('The p-value for the hypothesis is: p=%4f\n',p21);

fprintf('<strong>c.\n</strong>');
[h31,p31,stats31] = chi2gof(data(:,1));
if h31==0
    fprintf('Hypothesis that the data comes from a normal distribution  at the 5 percentage significance level, is: True\n');
elseif h31==1
    fprintf('Alternative hypothesis that the data does not come from a normal distribution  at the 5 percentage significance level, is: True\n');
end
fprintf('The p-value for the hypothesis is: p=%4f\n',p31);
%% Column 2: Duration Time (min) (year:1989)

fprintf('\n<strong>Duration time (1989):\n</strong>');
fprintf('<strong>a.\n</strong>');
[h12,p12,ci12,stats12] = vartest(data(:,2),d_sd^2);
fprintf(['At the 95 percentage significance level the confidence interval for the standrad deviation is [%.4f,%.4f]: \n'],sqrt(ci12(1)),sqrt(ci12(2)));

if h11==0
    fprintf('Hypothesis that the data comes from a normal distribution with standrad deviation 1 min is: True\n'); 
elseif h11==1
    fprintf('Hypothesis that the data comes from a normal distribution with standrad deviation 1 min is: False\n');
end
fprintf('The p-value for the hypothesis is: p=%4f\n',p12);

fprintf('<strong>b.\n</strong>');
[h22,p22,ci22,stats22] = ttest(data(:,2),d_mean);
fprintf(['At the 95 percentage significance level the confidence interval for the mean value is [%.4f,%.4f]: \n'],ci22(1),ci22(2));
if h21==0
    fprintf('Hypothesis that the data comes from a normal distribution with mean value equal to 2.5 min is: True\n');
elseif h21==1
    fprintf('Hypothesis that the data comes from a normal distribution with mean value equal to 2.5 min is: False\n');
end
fprintf('The p-value for the hypothesis is: p=%4f\n',p22);

fprintf('<strong>c.\n</strong>');
[h32,p32,stats32] = chi2gof(data(:,2));
if h31==0
    fprintf('Hypothesis that the data comes from a normal distribution  at the 5 percentage significance level, is: True\n');
elseif h31==1
    fprintf('Alternative hypothesis that the data does not come from a normal distribution  at the 5 percentage significance level, is: True\n');
end
fprintf('The p-value for the hypothesis is: p=%4f\n',p32);

%% Column 3: Waiting Time (min) (year:2006)
fprintf('\n<strong>Waiting time (2006):\n</strong>');
fprintf('<strong>a.\n</strong>');
[h13,p13,ci13,stats13] = vartest(data(:,3),w_sd^2);
fprintf(['At the 95 percentage significance level the confidence interval for the standrad deviation is [%.4f,%.4f]: \n'],sqrt(ci13(1)),sqrt(ci13(2)));

if h11==0
    fprintf('Hypothesis that the data comes from a normal distribution with standrad deviation 10 min is: True\n'); 
elseif h11==1
    fprintf('Hypothesis that the data comes from a normal distribution with standrad deviation 10 min is: False\n');
end
fprintf('The p-value for the hypothesis is: p=%4f\n',p13);

fprintf('<strong>b.\n</strong>');
[h23,p23,ci23,stats23] = ttest(data(:,3),w_mean);
fprintf(['At the 95 percentage significance level the confidence interval for the mean value is [%.4f,%.4f]: \n'],ci23(1),ci23(2));
if h21==0
    fprintf('Hypothesis that the data comes from a normal distribution with mean value equal to 75 min is: True\n');
elseif h21==1
    fprintf('Hypothesis that the data comes from a normal distribution with mean value equal to 75 min is: False\n');
end
fprintf('The p-value for the hypothesis is: p=%4f\n',p23);

fprintf('<strong>c.\n</strong>');
[h33,p33,stats33] = chi2gof(data(:,3));
if h31==0
    fprintf('Hypothesis that the data comes from a normal distribution  at the 5 percentage significance level, is: True\n');
elseif h31==1
    fprintf('Alternative hypothesis that the data does not come from a normal distribution  at the 5 percentage significance level, is: True\n');
end
fprintf('The p-value for the hypothesis is: p=%4f\n',p33);

%% Wikipedia Check
fprintf('\n<strong>Wikipedia Check for eruption waiting time:\n</strong>');

wl_check=61;
wu_check=91;
wl_data=data(data(:,2)<2.5,1);
wu_data=data(data(:,2)>2.5,1);

fprintf('\n<strong>Duartion Time lower than 2.5:\n</strong>');
[h1,p1,ci1,stats1] = vartest(wl_data,w_sd^2);
fprintf(['At the 95 percentage significance level the confidence interval for the standrad deviation is [%.4f,%.4f]: \n'],sqrt(ci1(1)),sqrt(ci1(2)));

if h1==0
    fprintf('Hypothesis that the data comes from a normal distribution with standrad deviation 10 min is: True\n'); 
elseif h1==1
    fprintf('Hypothesis that the data comes from a normal distribution with standrad deviation 10 min is: False\n');
end
fprintf('The p-value for the hypothesis is: p=%4f\n',p1);

fprintf('\n');

[h2,p2,ci2,stats2] = ttest(wl_data,wl_check);
fprintf(['At the 95 percentage significance level the confidence interval for the mean value is [%.4f,%.4f]: \n'],ci2(1),ci2(2));
if h2==0
    fprintf('Hypothesis that the data comes from a normal distribution with mean value equal to 65 min is: True\n');
elseif h2==1
    fprintf('Hypothesis that the data comes from a normal distribution with mean value equal to 65 min is: False\n');
end
fprintf('The p-value for the hypothesis is: p=%4f\n',p2);

fprintf('\n<strong>Duartion Time greater than 2.5:\n</strong>');
[h3,p3,ci3,stats3] = vartest(wu_data,w_sd^2);
fprintf(['At the 95 percentage significance level the confidence interval for the standrad deviation is [%.4f,%.4f]: \n'],sqrt(ci3(1)),sqrt(ci3(2)));

if h3==0
    fprintf('Hypothesis that the data comes from a normal distribution with standrad deviation 10 min is: True\n'); 
elseif h3==1
    fprintf('Hypothesis that the data comes from a normal distribution with standrad deviation 10 min is: False\n');
end
fprintf('The p-value for the hypothesis is: p=%4f\n',p3);

fprintf('\n');
[h4,p4,ci4,stats4] = ttest(wu_data,wu_check);
fprintf(['At the 95 percentage significance level the confidence interval for the mean value is [%.4f,%.4f]: \n'],ci4(1),ci4(2));
if h4==0
    fprintf('Hypothesis that the data comes from a normal distribution with mean value equal to 91 min is: True\n');
elseif h4==1
    fprintf('Hypothesis that the data comes from a normal distribution with mean value equal to 91 min is: False\n');
end
fprintf('The p-value for the hypothesis is: p=%4f\n',p4);
