%% Psarras Dimitrios
% Chapter 2: Exercise 4 for uniform continuous distribution in range 1 to 2 
clear; clc;

% mux is the expected mean value for the random variable X, the values are
% saved in a matrix form
% mu1x is the expected mean value for the random variable 1/X, the values
% are save in a matrix form
% n is a matrix 1x8 with elements the number of random values for the
% variable X
mux=[];mu1x=[];
n=10.^[1:8];

% with the for the simulation is repeated for the increasing number of
% random values of X
for i=1:length(n)
    % random values from uniform continuous distribution
    x=rand(1,n(i))+1;
    % matrix for 1/X
    x1=1./x;
    % expected mean values E[1/X] and 1/E[x]
    mux(end+1)=1/mean(x);
    mu1x(end+1)=mean(x1);
end

% plotting the mean values 1/E[X] and E[1/X] as a function of n
semilogx(n,mux,'o');
hold on
semilogx(n,mu1x,'o');
title({'Expected mean value E[1/X] and 1/E[X] as a function of number of random values of X'});
xlabel('Number of random values of X');
ylabel('Expected mean value E[1/X] and 1/E[X]');
legend({'Expected mean value 1/E[X]','Expected mean value E[1/X]'},'FontSize',10)
ylim([0.4,0.9])
hold off

%% Psarras Dimitrios
% Chapter 2: Exercise 4 for uniform continuous distribution in range 0 to 1 
clear; clc;

% mux is the expected mean value for the random variable X, the values are
% saved in a matrix form
% mu1x is the expected mean value for the random variable 1/X, the values
% are save in a matrix form
% n is a matrix 1x8 with elements the number of random values for the
% variable X
mux=[];mu1x=[];
n=10.^[1:8];

% with the for the simulation is repeated for the increasing number of
% random values of X
for i=1:length(n)
    % random values from uniform continuous distribution
    x=rand(1,n(i));
    % matrix for 1/X
    x1=1./x;
    % expected mean values E[1/X] and 1/E[x]
    mux(end+1)=1/mean(x);
    mu1x(end+1)=mean(x1);
end

figure();
% plotting the mean values 1/E[X] and E[1/X] as a function of n
semilogx(n,mux,'o');
hold on
semilogx(n,mu1x,'o');
title({'Expected mean value E[1/X] and 1/E[X] as a function of number of random values of X'});
xlabel('Number of random values of X');
ylabel('Expected mean value E[1/X] and 1/E[X]');
legend({'Expected mean value 1/E[X]','Expected mean value E[1/X]'},'FontSize',6)
hold off

%% Psarras Dimitrios
% Chapter 2: Exercise 4 for uniform continuous distribution in range -1 to 1 
clear; clc;

% mux is the expected mean value for the random variable X, the values are
% saved in a matrix form
% mu1x is the expected mean value for the random variable 1/X, the values
% are save in a matrix form
% n is a matrix 1x8 with elements the number of random values for the
% variable X
mux=[];mu1x=[];
n=10.^[1:8];

% with the for the simulation is repeated for the increasing number of
% random values of X
for i=1:length(n)
    % random values from uniform continuous distribution
    x=2*rand(1,n(i))-1;
    % matrix for 1/X
    x1=1./x;
    % expected mean values E[1/X] and 1/E[x]
    mux(end+1)=1/mean(x);
    mu1x(end+1)=mean(x1);
end

figure();
% plotting the mean values 1/E[X] and E[1/X] as a function of n
semilogx(n,mux,'o');
hold on
semilogx(n,mu1x,'o');
title({'Expected mean value E[1/X] and 1/E[X] as a function of number of random values of X'});
xlabel('Number of random values of X');
ylabel('Expected mean value E[1/X] and 1/E[X]');
legend({'Expected mean value 1/E[X]','Expected mean value E[1/X]'},'FontSize',6)
hold off

%% Psarras Dimitrios
% Comments

disp('We observe that range 1 to 2 for random values for X the equation E[1/X]=1/E[X] is not true, although marginally. However for the range 0 to 1 and -1 to 1 because the random variable X takes values near to zero the fraction 1/X tends to have big values and as a result in these case the equation for the expected mean values is not True');