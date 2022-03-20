%% Psarras Dimitrios
% Chapter 3: Exercise 3

clear; clc;

M = 1000;
n = [5,100];
t = 15;
for i=1:2
    data1=exprnd(t,n(i),M);
    data2=mean(data1);
    [h,p,ci,stats] = ttest(data2);
    eventcount = (data2 > ci(1) & data2 < ci(2));
    ratio = sum(eventcount)/length(eventcount);

    fprintf(['For M=%d samples with n=%d events the confidence interval is '...
        '[%.4f,%.4f] and the ratio of the average lifetime inside'...
        ' the confidence interval is %.4f\n'], M, n(i), ci(1), ci(2), ratio);
end