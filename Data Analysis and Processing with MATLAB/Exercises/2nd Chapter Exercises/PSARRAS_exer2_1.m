clear;clc;

% uniform discrete distribution of 0 and 1, 1 for Tails and 0 for Heads

n=[10,100,1000,10000,100000,1000000,10000000];% number of times the coin is tossed, multiple 
% increasing values for n.
i=0; prob=[]; p=[];% initialization of index i, propability of tails for n number of coin flips
% and p, a vector with elements the semilog graphs of ratio tails/n as a function of n
subplot(2,2,1);
for i=1:length(n) % for loop for its value of n, number of times the coin is tossed.
    
    cflips=[]; ctails=[]; ratiotn=[];% initialization of vectors for the number of coin flips, 
    % the number the coin landed on tails and the ratio of tails to total flips
    
    cflips=unidrnd(2,[1,n(i)])-1;% Random numbers from discrete uniform distribution beteween
    % 0 and 1.
    ctails=cumsum(cflips);% cumulative sum of flips. 0 adds nothing to the sum thus the sum 
    % represents the times number 1 appeared meaning the number the coin
    % landed on tails for the momentary number of flips.
    ratiotn=ctails./(1:n(i));% ratio of momentary tails to momentary total number of flips
    prob(i)=ctails(end)/n(i);% ratio of tails, after the total numbers of flips completed,
    % to the total number of flips n
    p(end+1)=semilogx((1:n(i)),ratiotn,'.'); % semilog plot of ratio as a function of 
    % total flips
    grid on;
    hold on; % allows to plot on the same figure;
end
title({'Coin flips from discrete uniform distribution(Heads=0, Tails=1)'});
xlabel('Number of coin flips, n');
ylabel('Ratio Tails to Total Flips');
legend(p,{'total number of flips n=10','total number of flips n=100','total number of flips n=1000','total number of flips n=10000','total number of flips n=100000','total number of flips n=1000000','total number of flips n=10000000'},'FontSize',6);
hold off

subplot(2,2,2);% new figure
semilogx(n,prob,'o')% semilog plot of ratio tails/n as function of n after n number of flips
title({'Coin flips from discrete uniform distribution(Heads=0, Tails=1)',' last points of its simulation'});
xlabel('Number of coin flips, n');
ylabel('Ratio Tails to Total Flips');
grid on;

% uniform continuous distribution between 0 and 1, greater than 0.5 for Tails and lower than 0.5
% for Heads

clear;clc;

n=[10,100,1000,10000,100000,1000000,10000000];
i=0; prob=[]; p=[];

for i=1:length(n)
    cflips=[];
    ctails=[];
    ratiotn=[];
    cflips=round(rand(1,n(i)));
    ctails=cumsum(cflips);
    ratiotn=ctails./(1:n(i));
    prob(i)=ctails(end)/n(i);
    if i==1 % command figure creates a new figure. In order to seperate previous figure from this
        % and at the same time combine multiple plots, command figure is
        % used only for the first plot
        subplot(2,2,3);
    end
    p(end+1)=semilogx((1:n(i)),ratiotn,'.');
    grid on;
    hold on
end
title({'Coin flips from continuous uniform distribution(Heads=0, Tails=1)'});
xlabel('Number of coin flips, n');
ylabel('Ratio Tails to Total Flips');
legend(p,{'total number of flips n=10','total number of flips n=100','total number of flips n=1000','total number of flips n=10000','total number of flips n=100000','total number of flips n=1000000','total number of flips n=10000000'},'FontSize',6);
hold off

subplot(2,2,4);% new figure
semilogx(n,prob,'o')% semilog plot of ratio tails/n as function of n after n number of flips
title({'Coin flips from continuous uniform distribution(Heads=0, Tails=1)',' last points of its simulation'});
xlabel('Number of coin flips, n');
ylabel('Ratio Tails to Total Flips');
grid on;