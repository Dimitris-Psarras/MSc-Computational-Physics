clear; clc;

% 1000 random numbers generated
n=1000;
num=rand(1,n);

% Cumulative distribution Function (cdf) of exponential probability density
% function (pdf)
l=1;
F=-(1/l)*log(1-num);

% Plot histogram of exponential cdf. Y - axis represents the probability
% value and X - axis represents the values of cdf. On this histogram the
% pdf is plotted too.
p=[];
figure;
hold on;
p(1)=histogram(F,'Normalization','pdf');
p(2)=fplot(@(x)l*exp(-l*x),[0,max(F)]);
grid on
title({'Histogram of random values from exponential distribution'});
xlabel('X');
ylabel('P(X)');
legend(p,'histogram of exponential function','pdf: f(x)=ë*exp(-ëx), ë=1');