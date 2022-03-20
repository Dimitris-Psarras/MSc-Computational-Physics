%% Psarras Dimitrios
% Chapter 6: Exercise 2

clear; clc; close all;

data = importdata('crutem3nh.dat');

n = length(data);
year = data(:,1);
Temp = data(:,2);


figure(1);
grid on;
plot(year,Temp,'.-')
title('Temperature index time series')
xlabel('Year')
ylabel('Temperature index')
grid on

x_bar = mean(Temp);

N = size(data,1);
lag = 20;

sum1 = 0;
sum2 = 0;
rho_corr = zeros(1,lag);
for m=1:lag
    for o=m+1:N
        sum1 = sum1 + ((Temp(o)-x_bar)*(Temp(o-m)-x_bar));
        sum2 = sum2 + (Temp(o)-x_bar)^2;
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

%% Polynomial Fit of 1st degree

k = 1;
alpha = 0.5;
x = [ones(n,1) year];
[b,bint] = regress(Temp,x,alpha);
y = x * b;
e_i = Temp - y;
s_e_i = sqrt((1/(n-k-1))*sum((e_i).^2));
e_i_n = e_i./s_e_i;

figure(3);
subplot(3,2,1);
hold on;
grid on;
scatter(year, Temp,'.');
plot(year,y);
title(['Polynomial fitting of ', num2str(k),' degree'])
xlabel('Year')
ylabel('Temperature index')
legend('Data', sprintf('y = %.4f + %.4f x', b(1), b(2)));

subplot(3,2,2);
hold on;
grid on;
scatter(y,e_i_n,'.');
yline(2,'r');
yline(-2,'r');
title('Diagnostic Plot')
xlabel('Temperature index')
ylabel('e_{i}^*')

Temp1 = Temp - y;
Temp1_bar = mean(Temp1);
for m=1:lag
    for o=m+1:N
        sum1 = sum1 + ((Temp1(o)-Temp1_bar)*(Temp1(o-m)-Temp1_bar));
        sum2 = sum2 + (Temp1(o)-Temp1_bar)^2;
    end
    rho_corr(1,m) = (sum1)/(sum2);
    sum1 = 0;
    sum2 = 0;
end

figure(4);
subplot(3,2,1);
grid on;
plot(year,Temp1,'.-')
title('Temperature index time series (1st degree trend subtracted)')
xlabel('Year')
ylabel('Temperature index')
grid on

subplot(3,2,2);
grid on
hold on
plot(rho_corr,'r.')
for l=1:lag
    plot([l,l],[0,rho_corr(1,l)],'r-')
end
yline(2/sqrt(N),'b');
yline(-2/sqrt(N),'b');
yline(0);
title('Autocorreletion Function (1st degree trend subtracted)')
xlabel('\tau')
ylabel('Sample Autocorreletion')
hold off

%% Polynomial Fit of 2nd degree

k = 2;
alpha = 0.5;
x = [ones(n,1) year year.^2];
[b,bint] = regress(Temp,x,alpha);
y = x * b;
e_i = Temp - y;
s_e_i = sqrt((1/(n-k-1))*sum((e_i).^2));
e_i_n = e_i./s_e_i;

figure(3);
subplot(3,2,3);
hold on;
grid on;
scatter(year, Temp,'.');
plot(year,y);
title(['Polynomial fitting of ', num2str(k),' degree']);
xlabel('Year')
ylabel('Temperature index')
legend('Data', sprintf('y = %.4f + %.4f x + %.4f x^2', b(1), b(2), b(3)));

subplot(3,2,4);
hold on;
grid on;
scatter(y,e_i_n,'.');
yline(2,'r');
yline(-2,'r');
title('Diagnostic Plot')
xlabel('Temperature index')
ylabel('e_{i}^*')


Temp2 = Temp - y;
Temp2_bar = mean(Temp2);
rho_corr = zeros(1,lag);
for m=1:lag
    for o=m+1:N
        sum1 = sum1 + ((Temp2(o)-Temp2_bar)*(Temp2(o-m)-Temp2_bar));
        sum2 = sum2 + (Temp2(o)-Temp2_bar)^2;
    end
    rho_corr(1,m) = (sum1)/(sum2);
    sum1 = 0;
    sum2 = 0;
end

figure(4);
subplot(3,2,3);
grid on;
plot(year,Temp2,'.-')
title('Temperature index time series')
xlabel('Year')
ylabel('Temperature index (2nd degree trend subtracted)')
grid on

subplot(3,2,4);
grid on
hold on
plot(rho_corr,'r.')
for l=1:lag
    plot([l,l],[0,rho_corr(1,l)],'r-')
end
yline(2/sqrt(N),'b');
yline(-2/sqrt(N),'b');
yline(0);
title('Autocorreletion Function (2nd degree trend subtracted)')
xlabel('\tau')
ylabel('Sample Autocorreletion')
hold off

%% 

k = 3;
alpha = 0.5;
x = [ones(n,1) year year.^2 year.^3];
[b,bint] = regress(Temp,x,alpha);
y = x * b;
e_i = Temp - y;
s_e_i = sqrt((1/(n-k-1))*sum((e_i).^2));
e_i_n = e_i./s_e_i;

figure(3);
subplot(3,2,5);
hold on;
grid on;
scatter(year, Temp,'.');
plot(year,y);
title(['Polynomial fitting of ', num2str(k),' degree']);
xlabel('Year')
ylabel('Temperature index')
legend('Data', sprintf('y = %.4f + %.4f x + %.4f x^2 + %.4f x^3', b(1), b(2), b(3), b(4)));

subplot(3,2,6);
hold on;
grid on;
scatter(y,e_i_n,'.');
yline(2,'r');
yline(-2,'r');
title('Diagnostic Plot')
xlabel('Temperature index')
ylabel('e_{i}^*')

Temp3 = Temp -y;
Temp3_bar = mean(Temp3);
rho_corr = zeros(1,lag);
for m=1:lag
    for o=m+1:N
        sum1 = sum1 + ((Temp3(o)-Temp3_bar)*(Temp3(o-m)-Temp3_bar));
        sum2 = sum2 + (Temp3(o)-Temp3_bar)^2;
    end
    rho_corr(1,m) = (sum1)/(sum2);
    sum1 = 0;
    sum2 = 0;
end

figure(4);
subplot(3,2,5);
grid on;
plot(year,Temp3,'.-')
title('Temperature index time series (3rd degree trend subtracted)')
xlabel('Year')
ylabel('Temperature index')
grid on

subplot(3,2,6);
grid on
hold on
plot(rho_corr,'r.')
for l=1:lag
    plot([l,l],[0,rho_corr(1,l)],'r-')
end
yline(2/sqrt(N),'b');
yline(-2/sqrt(N),'b');
yline(0);
title('Autocorreletion Function (3rd degree trend subtracted)')
xlabel('\tau')
ylabel('Sample Autocorreletion')
hold off

%% First Differences

fd = zeros(N-1,1);

for i=2:N
    fd(i-1) = Temp(i) - Temp(i-1);
end

figure(5);
subplot(2,1,1);
grid on;
plot(year(2:N),fd,'.-')
title('Temperature index time series (First Differences trend subtracted)')
xlabel('Year')
ylabel('Temperature index')
grid on

fd_bar = mean(fd);
rho_corr = zeros(1,lag);
for m=1:lag
    for o=m+1:N-1
        sum1 = sum1 + ((fd(o)-fd_bar)*(fd(o-m)-fd_bar));
        sum2 = sum2 + (fd(o)-fd_bar)^2;
    end
    rho_corr(1,m) = (sum1)/(sum2);
    sum1 = 0;
    sum2 = 0;
end

subplot(2,1,2);
grid on
hold on
plot(rho_corr,'r.')
for l=1:lag
    plot([l,l],[0,rho_corr(1,l)],'r-')
end
yline(2/sqrt(N),'b');
yline(-2/sqrt(N),'b');
yline(0);
title('Autocorreletion Function (First Differences trend subtracted)')
xlabel('\tau')
ylabel('Sample Autocorreletion')
hold off