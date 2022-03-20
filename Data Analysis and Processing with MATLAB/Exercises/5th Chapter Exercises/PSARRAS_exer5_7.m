%% Psarras Dimitrios
% Chapter 5: Exercise 7

clear; clc; close all;

data = [0.76 110;...
    0.86 105;...
    0.97 100;...
    1.11 95;...
    1.45 85;...
    1.67 80;...
    1.92 75;...
    2.23 70;...
    2.59 65;...
    3.02 60;...
    3.54 55;...
    4.13 50;...
    4.91 45;...
    5.83 40;...
    6.94 35;...
    8.31 30;...
    10.00 25;...
    12.09 20;...
    14.68 15;...
    17.96 10;...
    22.05 5;...
    27.28 0;...
    33.89 -5;...
    42.45 -10;...
    53.39 -15;...
    67.74 -20;...
    86.39 -25;...
    111.30 -30;...
    144.00 -35;...
    188.40 -40;...
    247.50 -45;...
    329.20 -50];

R = data(:,1);
T = data(:,2);
x_data = log(R);
y_data = 1./(T+273.15);
n = length(x_data);

%% Polynomial Fit of 1st degree

k = 1;
alpha = 0.5;
x = [ones(n,1) x_data];
[b,bint] = regress(y_data,x,alpha);
y = x * b;
e_i = y_data - y;
s_e_i = sqrt((1/(n-k-1))*sum((e_i).^2));
e_i_n = e_i./s_e_i;

subplot(4,2,1);
hold on;
grid on;
scatter(x_data, y_data,'.');
plot(x_data,y);
title(['Polynomial fitting of ', num2str(k),' degree'])
xlabel('lnR (R is resistance)')
ylabel('1/T (T is temperature)')
legend('Data', sprintf('y = %.4f + %.4f x', b(1), b(2)));

subplot(4,2,2);
hold on;
grid on;
scatter(y,e_i_n,'.');
yline(2,'r');
yline(-2,'r');
title('Diagnostic Plot')
xlabel('1/T (T is temperature)')
ylabel('e_{i}^*')

%% Polynomial Fit of 2nd degree

k = 2;
alpha = 0.5;
x = [ones(n,1) x_data x_data.^2];
[b,bint] = regress(y_data,x,alpha);
y = x * b;
e_i = y_data - y;
s_e_i = sqrt((1/(n-k-1))*sum((e_i).^2));
e_i_n = e_i./s_e_i;


subplot(4,2,3);
hold on;
grid on;
scatter(x_data, y_data,'.');
plot(x_data,y);
title(['Polynomial fitting of ', num2str(k),' degree']);
xlabel('lnR (R is resistance)')
ylabel('1/T (T is temperature)')
legend('Data', sprintf('y = %.4f + %.4f x + %.4f x^2', b(1), b(2), b(3)));

subplot(4,2,4);
hold on;
grid on;
scatter(y,e_i_n,'.');
yline(2,'r');
yline(-2,'r');
title('Diagnostic Plot')
xlabel('lnR (R is resistance)')
ylabel('e_{i}^*')

%% 

k = 3;
alpha = 0.5;
x = [ones(n,1) x_data x_data.^2 x_data.^3];
[b,bint] = regress(y_data,x,alpha);
y = x * b;
e_i = y_data - y;
s_e_i = sqrt((1/(n-k-1))*sum((e_i).^2));
e_i_n = e_i./s_e_i;


subplot(4,2,5);
hold on;
grid on;
scatter(x_data, y_data,'.');
plot(x_data,y);
title(['Polynomial fitting of ', num2str(k),' degree']);
xlabel('lnR (R is resistance)')
ylabel('1/T (T is temperature)')
legend('Data', sprintf('y = %.4f + %.4f x + %.4f x^2 + %.4f x^3', b(1), b(2), b(3), b(4)));

subplot(4,2,6);
hold on;
grid on;
scatter(y,e_i_n,'.');
yline(2,'r');
yline(-2,'r');
title('Diagnostic Plot')
xlabel('1/T (T is temperature)')
ylabel('e_{i}^*')

%%

k = 4;
alpha = 0.5;
x = [ones(n,1) x_data x_data.^2 x_data.^3 x_data.^4];
[b,bint] = regress(y_data,x,alpha);
y = x * b;
e_i = y_data - y;
s_e_i = sqrt((1/(n-k-1))*sum((e_i).^2));
e_i_n = e_i./s_e_i;


subplot(4,2,7);
hold on;
grid on;
scatter(x_data, y_data,'.');
plot(x_data,y);
title(['Polynomial fitting of ', num2str(k),' degree']);
xlabel('lnR (R is resistance)')
ylabel('1/T (T is temperature)')
legend('Data', sprintf('y = %.4f + %.4f x + %.4f x^2 + %.4f x^3  %.4f x^4', b(1), b(2), b(3), b(4),b(5)));

subplot(4,2,8);
hold on;
grid on;
scatter(y,e_i_n,'.');
yline(2,'r');
yline(-2,'r');
title('Diagnostic Plot')
xlabel('1/T (T is temperature)')
ylabel('e_{i}^*')

%% Steinhart - Hart Model

k = 3;
alpha = 0.5;
x = [ones(n,1) x_data x_data.^2 x_data.^3];
[b,bint] = regress(y_data,x,alpha);
y = x * b;
e_i = y_data - y;
s_e_i = sqrt((1/(n-k-1))*sum((e_i).^2));
e_i_n = e_i./s_e_i;

figure()
subplot(2,2,1);
hold on;
grid on;
scatter(x_data, y_data,'.');
plot(x_data,y);
title(['Polynomial fitting of ', num2str(k),' degree']);
xlabel('lnR (R is resistance)')
ylabel('1/T (T is temperature)')
legend('Data', sprintf('y = %.4f + %.4f x + %.4f x^2 + %.4f x^3  %.4f x^4', b(1), b(2), b(3), b(4)));

subplot(2,2,2);
hold on;
grid on;
scatter(y,e_i_n,'.');
yline(2,'r');
yline(-2,'r');
title('Diagnostic Plot')
xlabel('1/T (T is temperature)')
ylabel('e_{i}^*')

alpha = 0.5;
x = [ones(n,1) x_data x_data.^3];
[b,bint] = regress(y_data,x,alpha);
y = x * b;
e_i = y_data - y;
s_e_i = sqrt((1/(n-k-1))*sum((e_i).^2));
e_i_n = e_i./s_e_i;

fprintf('The Steinhart - Hart model returns the b coefficients:\nb0 = %.10f, b1 = %.10f, b3 = %.10f', b(1), b(2), b(3));

subplot(2,2,3);
hold on;
grid on;
scatter(x_data, y_data,'.');
plot(x_data,y);
title('The Steinhart - Hart Model');
xlabel('lnR (R is resistance)')
ylabel('1/T (T is temperature)')
legend('Data', sprintf('y = %.4f + %.4f x + %.4f x^3', b(1), b(2), b(3)));

subplot(2,2,4);
hold on;
grid on;
scatter(y,e_i_n,'.');
yline(2,'r');
yline(-2,'r');
title('Diagnostic Plot')
xlabel('1/T (T is temperature)')
ylabel('e_{i}^*')