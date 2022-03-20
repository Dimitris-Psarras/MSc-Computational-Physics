%% Psarras Dimitrios
% Chapter 6: Exercise 1

clear; clc; close all;

data = importdata('sunspots.dat');

year = data(:,1);
sunspots = data(:,2);

figure(1);
grid on;
plot(year,sunspots,'.-')
title('Sunspot time series')
xlabel('Year')
ylabel('Number od Sunspots')
grid on

% According to the plot, the period is assumed to be 11 years
period = 11;

x_bar = mean(sunspots);

N = size(data,1);
p_sunspots=zeros(N,1);
spots = 0;
lag = 20;

sum1 = 0;
sum2 = 0;

rho_corr = zeros(1,lag);
for m=1:lag
    for o=m+1:N
        sum1 = sum1 + ((sunspots(o)-x_bar)*(sunspots(o-m)-x_bar));
        sum2 = sum2 + (sunspots(o)-x_bar)^2;
    end
    rho_corr(1,m) = (sum1)/(sum2);
    sum1 = 0;
    sum2 = 0;
end

figure(2);
grid on
hold on
plot(rho_corr,'r.')
for l=1:lag
    plot([l,l],[0,rho_corr(1,l)],'r-')
end
yline(2/sqrt(N),'b');
yline(-2/sqrt(N),'b');
yline(0);
title('Autocorreletion Function')
xlabel('\tau')
ylabel('Sample Autocorreletion')
hold off

for j=1:period
    p_sunspots(j:period:N) = mean(sunspots(j:period:N));
end

r_sunspots = sunspots - p_sunspots;

figure(3);
subplot(3,1,1);
grid on;
plot(year,sunspots,'.-')
title('Sunspots time series')
xlabel('Year')
ylabel('Number of Sunspots')
grid on

subplot(3,1,2);
grid on;
plot(year,p_sunspots,'.-')
title('Sunspots year circle time series')
xlabel('Year')
ylabel('Number of Sunspots')
grid on


subplot(3,1,3);
grid on;
plot(year,r_sunspots,'.-')
title('Sunspot time series (period component substracted)')
xlabel('Year')
ylabel('Number of Sunspots')
grid on

r_x_bar = mean(r_sunspots);
sum1 = 0;
sum2 = 0;
rho_corr = zeros(1,lag);
for m=1:lag
    for o=m+1:N
        sum1 = sum1 + ((r_sunspots(o)-r_x_bar)*(r_sunspots(o-m)-r_x_bar));
        sum2 = sum2 + (r_sunspots(o)-r_x_bar)^2;
    end
    rho_corr(1,m) = (sum1)/(sum2);
    sum1 = 0;
    sum2 = 0;
end

figure(4);
grid on
hold on
plot(rho_corr,'r.')
for l=1:lag
    plot([l,l],[0,rho_corr(1,l)],'r-')
end
yline(2/sqrt(N),'b');
yline(-2/sqrt(N),'b');
yline(0);
title('Autocorreletion Function (period component substracted)')
xlabel('\tau')
ylabel('Sample Autocorreletion')
hold off