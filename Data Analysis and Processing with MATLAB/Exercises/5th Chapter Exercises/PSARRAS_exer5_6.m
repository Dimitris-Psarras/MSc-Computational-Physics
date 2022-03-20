%% Psarras Dimitrios
% Chapter 5: Exercise 6

clear; clc; close all;

distance = [2 3 8 16 32 48 64 80];
usage_per = [98.2 91.7 81.3 64.0 36.4 32.6 17.1 11.3];
n = length(distance);

%% Linear Fit

mean_d = mean(distance);
mean_u = mean(usage_per);
S_xy = sum((distance-mean_d).*(usage_per-mean_u));
S_xx = sum((distance-mean_d).^2);
S_yy = sum((usage_per-mean_u).^2);
r = S_xy/sqrt(S_xx*S_yy);
b_1 = S_xy/S_xx;
b_0 = mean_u - b_1*mean_d;

y_exp = b_1*distance + b_0;

s_xy = S_xy/(n-1);
s_x = S_xx/(n-1);
s_y = S_yy/(n-1);
s_e = sqrt(((n-1)/(n-2))*(s_y-b_1^2*s_x));
e_i = usage_per - y_exp;
e_i_n = e_i/s_e;

subplot(2,2,1);
hold on;
grid on;
scatter(distance, usage_per,'.');
plot(distance,y_exp);
title(['Linear fitting, r = ', num2str(r)])
xlabel('Distance [10^3 km]')
ylabel('Usage %')
legend('Data', sprintf('y = %.4f + %.4f x', b_0, b_1));

subplot(2,2,2);
hold on;
grid on;
scatter(y_exp,e_i_n,'.');
yline(2,'r');
yline(-2,'r');
title('Diagnostic Plot')
xlabel('Usage %')
ylabel('e_{i}^*')

%% Exponential Fit

usage_per_exp = log(usage_per);

mean_d = mean(distance);
mean_u = mean(usage_per_exp);
S_xy = sum((distance-mean_d).*(usage_per_exp-mean_u));
S_xx = sum((distance-mean_d).^2);
S_yy = sum((usage_per_exp-mean_u).^2);
r = S_xy/sqrt(S_xx*S_yy);
b_1_exp = S_xy/S_xx;
b_0_exp = mean_u - b_1_exp*mean_d;

y_exp = b_1_exp*distance + b_0_exp;

s_xy = S_xy/(n-1);
s_x = S_xx/(n-1);
s_y = S_yy/(n-1);
s_e = sqrt(((n-1)/(n-2))*(s_y-b_1_exp^2*s_x));
e_i = usage_per_exp - y_exp;
e_i_n = e_i/s_e;

subplot(2,2,3);
hold on;
grid on;
scatter(distance, usage_per_exp,'.');
plot(distance,y_exp);
title(['Linear fitting, r = ', num2str(r)])
xlabel('Distance [10^3 km]')
ylabel('Usage %')
legend('Data', sprintf('y = %.4f %.4f x', b_0_exp, b_1_exp));

subplot(2,2,4);
hold on;
grid on;
scatter(y_exp,e_i_n,'.');
yline(2,'r');
yline(-2,'r');
title('Diagnostic Plot')
xlabel('Usage %')
ylabel('e_{i}^*')

%% Power Fit

usage_per_pow = log(usage_per);
distance_pow = log(distance);

mean_d = mean(distance_pow);
mean_u = mean(usage_per_pow);
S_xy = sum((distance_pow-mean_d).*(usage_per_pow-mean_u));
S_xx = sum((distance_pow-mean_d).^2);
S_yy = sum((usage_per_pow-mean_u).^2);
r = S_xy/sqrt(S_xx*S_yy);
b_1 = S_xy/S_xx;
b_0 = mean_u - b_1*mean_d;

y_pow = b_1*distance_pow + b_0;

s_xy = S_xy/(n-1);
s_x = S_xx/(n-1);
s_y = S_yy/(n-1);
s_e = sqrt(((n-1)/(n-2))*(s_y-b_1^2*s_x));
e_i = usage_per_pow - y_pow;
e_i_n = e_i/s_e;

figure();
subplot(3,2,1);
hold on;
grid on;
scatter(distance_pow, usage_per_pow,'.');
plot(distance_pow,y_pow);
title(['Power fitting, r = ', num2str(r)])
xlabel('Distance [10^3 km]')
ylabel('Usage %')
legend('Data', sprintf('y = %.4f %.4f x', b_0, b_1));

subplot(3,2,2);
hold on;
grid on;
scatter(y_pow,e_i_n,'.');
yline(2,'r');
yline(-2,'r');
title('Diagnostic Plot')
xlabel('Usage %')
ylabel('e_{i}^*')

%% y=a+blog(x) Fit

distance_log = log(distance);

mean_d = mean(distance_log);
mean_u = mean(usage_per);
S_xy = sum((distance_log-mean_d).*(usage_per-mean_u));
S_xx = sum((distance_log-mean_d).^2);
S_yy = sum((usage_per-mean_u).^2);
r = S_xy/sqrt(S_xx*S_yy);
b_1 = S_xy/S_xx;
b_0 = mean_u - b_1*mean_d;

y_log = b_1*distance_log + b_0;

s_xy = S_xy/(n-1);
s_x = S_xx/(n-1);

s_y = S_yy/(n-1);
s_e = sqrt(((n-1)/(n-2))*(s_y-b_1^2*s_x));
e_i = usage_per - y_log;
e_i_n = e_i/s_e;

subplot(3,2,3);
hold on;
grid on;
scatter(distance_log, usage_per,'.');
plot(distance_log,y_log);
title(['y=a+blog(x) fitting, r = ', num2str(r)])
xlabel('Distance [10^3 km]')
ylabel('Usage %')
legend('Data', sprintf('y = %.4f %.4f x', b_0, b_1));

subplot(3,2,4);
hold on;
grid on;
scatter(y_log,e_i_n,'.');
yline(2,'r');
yline(-2,'r');
title('Diagnostic Plot')
xlabel('Usage %')
ylabel('e_{i}^*')

%% Inverse Fit

distance_inv = 1./distance;

mean_d = mean(distance_inv);
mean_u = mean(usage_per);
S_xy = sum((distance_inv-mean_d).*(usage_per-mean_u));
S_xx = sum((distance_inv-mean_d).^2);
S_yy = sum((usage_per-mean_u).^2);
r = S_xy/sqrt(S_xx*S_yy);
b_1 = S_xy/S_xx;
b_0 = mean_u - b_1*mean_d;

y_inv = b_1*distance_inv + b_0;

s_xy = S_xy/(n-1);
s_x = S_xx/(n-1);

s_y = S_yy/(n-1);
s_e = sqrt(((n-1)/(n-2))*(s_y-b_1^2*s_x));
e_i = usage_per - y_inv;
e_i_n = e_i/s_e;

subplot(3,2,5);
hold on;
grid on;
scatter(distance_inv, usage_per,'.');
plot(distance_inv,y_inv);
title(['Inverse fitting, r = ', num2str(r)])
xlabel('Distance [10^3 km]')
ylabel('Usage %')
legend('Data', sprintf('y = %.4f %.4f x', b_0, b_1));

subplot(3,2,6);
hold on;
grid on;
scatter(y_inv,e_i_n,'.');
yline(2,'r');
yline(-2,'r');
title('Diagnostic Plot')
xlabel('Usage %')
ylabel('e_{i}^*')

%% Results & Prediction

prediction_x = 25;
prediction_y_exp = b_1_exp*prediction_x+b_0_exp;
prediction_y = exp(prediction_y_exp);

fprintf('According to diagnostic plots and the values of the correlation coefficient the best fitting for the data is the exponential fit.\n');

fprintf('Linear form:');
fprintf('ln(y) = %.4f + %.4fx', b_0_exp, b_1_exp);
fprintf('\nExponential form:\n');
fprintf('y = %.2f e^(%.4fx)\n\n', exp(b_0_exp), b_1_exp);

fprintf('After 25000km the tyre is %.4f %% usable.\n',prediction_y);

x_exponential=1:0.1:100;
y_exponential = exp(b_0_exp)*exp(b_1_exp*x_exponential);
figure ();
hold on;
grid on;
plot(distance,usage_per,'.');
plot(x_exponential,y_exponential);
title('Exponential fitting of data');
legend('Data', sprintf('y = %.2f e^{%.4fx}', exp(b_0_exp), b_1_exp));
xlabel('Distance [10^3 km]')
ylabel('usage %')