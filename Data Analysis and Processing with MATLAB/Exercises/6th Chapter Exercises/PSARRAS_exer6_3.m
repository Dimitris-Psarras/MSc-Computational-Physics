%% Psarras Dimitrios
% Chapter 6: Exercise 3

clear; clc; close all;

N = 100;
x_data = zeros(100,1);
x_data(1) = 0.2;
year = linspace(1,N,N);

for i=2:year(N)
    x_data(i) = 4*x_data(i-1)*(1-x_data(i-1));
end

figure(1);
grid on;
plot(year,x_data,'.-')
title('Logistic animation time series')
xlabel('Year')
ylabel('Logistic animation')
grid on

figure(2);
grid on
plot(x_data(1:N-1),x_data(2:N),'.')
title('Logistic map')
xlabel('x_{t-1}')
ylabel('x_{t}')

lag = 20;

x_bar = mean(x_data);

sum1 = 0;
sum2 = 0;
rho_corr = zeros(1,lag);
for m=1:lag
    for o=m+1:N
        sum1 = sum1 + ((x_data(o)-x_bar)*(x_data(o-m)-x_bar));
        sum2 = sum2 + (x_data(o)-x_bar)^2;
    end
    rho_corr(1,m) = (sum1)/(sum2);
    sum1 = 0;
    sum2 = 0;
end

figure(3);
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