%% Psarras Dimitrios
% Chapter 2: Exercise 6

clear; clc;

% N symbolizes the number of Y random variables and n the number of X
% random variables
N=10000; n=100;

% a matrix n x N is generated. This matrix contains N samples of size 100.
% The distribution is uniform
x=rand(n,N);
% Y is the sum of the 100 numbers in its sample. y is a matrix 1 x N
y=sum(x);
% The average value of the sample means multiplied by the size of the
% samples is equal to the mean value of the distribution of th y random
% variables
mug=mean(mean(x))*n;
% The squared root of the mean value of variance for N samples multiplied
% by the square root of the size n of the samples is equal to the the 
% variance
sg=sqrt(mean(var(x)))*sqrt(n);

% calculation of the pdf of each value for the random variable Y
y=sort(y);
z1=normpdf(y,mug,sg);

% Histogram of random variable and the normal distribution for mean value
% and the standared deviation calculated on the lines 19 and 23
figure();
histogram(y,'Normalization','pdf'); hold on;
plot(y,z1,'LineWidth',1.5);
title({'Histogram of the distribution for the random variable Y and the '...
    'normal distribution with mean value and standrad deviation the values'...
    ' calculated from the distribution of Y'});
xlabel('Y (random variable)');
ylabel('PDF');
legend({'Histogram of Y values','Normal Distribution'},'FontSize',6);

%% Psarras Dimitrios
% Chapter 2: Exercise 6 (Different solution)

clear; clc;

% N symbolizes the number of Y random variables and n the number of X
% random variables
N=10000; n=100;

% a matrix n x N is generated. This matrix contains N samples of size 100.
% The distribution is uniform
x=rand(n,N);
% Y is the sum of the 100 numbers in its sample. y is a matrix 1 x N
y=sum(x);

% Histogram of random variable and the normal distribution
figure();
histfit(y);
title({'Histogram of the distribution for the random variable Y and the '...
    'normal distribution with mean value and standrad deviation the values'...
    ' calculated from the distribution of Y'});
xlabel('Y (random variable)');
ylabel('PDF');