%% Psarras Dimitrios
% Chapter 5: Exercise 4

clear; clc; close all;

data = importdata('lightair.dat');

air = data(:,1);
light = data(:,2);

dim = size(data);
n = dim(1);
a = 0.05;

%% A.

[R,P,RL,RU] = corrcoef(air,light);
rho = R(1,2);

figure();
scatter(air,light,'.');
xlabel('Air Density, ñ (kg/m^3)');
ylabel('Speed of Light, c_{air} (-299000 km/s)');
title({'Scatter Diagram',sprintf('The speed of light as a function of air density (r=%.4f)',rho)});
grid on;

%% B.
fprintf('<strong>B:\n</strong>');

t_c = tinv(1-a/2,n-2);
mean_a = mean(air);
mean_l = mean(light);
S_xy = sum((air-mean_a).*(light-mean_l));
S_xx = sum((air-mean_a).^2);
S_yy = sum((light-mean_l).^2);
b_1 = S_xy/S_xx;
b_0 = mean_l - b_1*mean_a;

s_xy = S_xy/(n-1);
s_x = S_xx/(n-1);
s_y = S_yy/(n-1);

s_e = ((n-1)/(n-2))*(s_y-b_1^2*s_x);
s_b_1 = sqrt(s_e/S_xx);
s_b_0 = sqrt(s_e)*sqrt((1/n)+(mean_a^2/S_xx));

b_1_lower = b_1-t_c*s_b_1;
b_1_upper = b_1+t_c*s_b_1;
b_0_lower = b_0-t_c*s_b_0;
b_0_upper = b_0+t_c*s_b_0;


fprintf('Least Square Method y = b1*x + b0:\n');
fprintf('y = %.4f*x + %.4f\n\n', b_1, b_0);
fprintf('Variance of e:\ns_e\xB2 = %.4f\n\n', s_e);
fprintf('%.0f%% Confidence Interval for constant b0: [%.4f, %.4f]\n',(1-a)*100,b_0_lower, b_0_upper);
fprintf('%.0f%% Confidence Interval for constant b1: [%.4f, %.4f]\n',(1-a)*100,b_1_lower, b_1_upper);

%% C.

fprintf('<strong>C:\n</strong>');

s_y_mean = sqrt(s_e)*sqrt((1/n)+((air-mean_a).^2/S_xx));
s_y_measurement = sqrt(s_e)*sqrt(1+(1/n)+((air-mean_a).^2/S_xx));

y_mean_lower = b_1*air + b_0 - t_c*s_y_mean;
y_mean_upper = b_0 + b_1*air + t_c*s_y_mean;
y_measurement_lower = b_0 + b_1*air - t_c*s_y_measurement;
y_measurement_upper = b_0 + b_1*air + t_c*s_y_measurement;

figure();
hold on;
scatter(air,light,'.');
xlabel('Air Density, ñ (kg/m^3)');
ylabel('Speed of Light, c_{air} (-299000 km/s)');
title({'Scatter Diagram',sprintf('The speed of light as a function of air density (r=%.4f)',rho)});
grid on;
fplot(@(x) b_0+b_1*x,[min(air),max(air)]);
plot(air,y_mean_lower,'--g');
plot(air,y_measurement_upper,'-.m');
plot(air,y_mean_upper,'--g');
plot(air,y_measurement_lower,'-.m');
legend('Data',sprintf('y = %.4fx + %.4f', b_1, b_0),'Confidence Interval (mean value)','Confidence Interval (measurement)');
hold off;

x_air = 1.29;
y_light = b_0+b_1*x_air;
s_y_mean_x = sqrt(s_e)*sqrt((1/n)+((x_air-mean_a).^2/S_xx));
s_y_measurement_x = sqrt(s_e)*sqrt(1+(1/n)+((x_air-mean_a).^2/S_xx));
y_mean_lower_x = b_1*x_air + b_0 - t_c*s_y_mean_x;
y_mean_upper_x = b_0 + b_1*x_air + t_c*s_y_mean_x;
y_measurement_lower_x = b_0 + b_1*x_air - t_c*s_y_measurement_x;
y_measurement_upper_x = b_0 + b_1*x_air + t_c*s_y_measurement_x;

fprintf('Prediction for x = %.4f: y = %.4f\n\n',x_air, y_light);
fprintf('%.0f%% Confidence Interval for mean value y: [%.4f, %.4f]\n',(1-a)*100,y_mean_lower_x, y_mean_upper_x);
fprintf('%.0f%% Confidence Interval for measurement y: [%.4f, %.4f]\n',(1-a)*100,y_measurement_lower_x, y_measurement_upper_x);

%% D.
fprintf('<strong>D:\n</strong>');

c = 299792.458;
d0 = 1.29;
b0 = c - 299000;
b1 = -0.00029*c/d0;
fprintf('Least Square Method y = b1*x + b0:\n');
fprintf('y = %.4f*x + %.4f\n\n', b1, b0);

if (b0>b_0_lower && b0<b_0_upper)
    fprintf('b0: actual value b0 = %.4f is inside the %.0f%% Confidence Interval for constant b0 [%.4f, %.4f]\n',b0,(1-a)*100,b_0_lower, b_0_upper);
else
    fprintf('b0: actual value b0 = %.4f is not inside the %.0f%% Confidence Interval for constant b0 [%.4f, %.4f]\n',b0,(1-a)*100,b_0_lower, b_0_upper);
end

if (b1>b_1_lower && b1<b_1_upper)
    fprintf('b1: actual value b1 = %.4f is inside the %.0f%% Confidence Interval for constant b1 [%.4f, %.4f]\n\n',b1,(1-a)*100,b_1_lower, b_1_upper);
else
    fprintf('b1: actual value b1 = %.4f is not inside the %.0f%% Confidence Interval for constant b1 [%.4f, %.4f]\n\n',b1,(1-a)*100,b_1_lower, b_1_upper);
end

y_value = x_air*b1+b0;

if (y_value>y_mean_lower_x && y_value<y_mean_upper_x)
    fprintf('y: actual value y = %.4f is inside the %.0f%% Confidence Interval for constant b1 [%.4f, %.4f]\n',y_value,(1-a)*100,y_mean_lower_x, y_mean_upper_x);
else
    fprintf('y: actual value y = %.4f is not inside the %.0f%% Confidence Interval for constant b1 [%.4f, %.4f]\n',y_value,(1-a)*100,y_mean_lower_x, y_mean_upper_x);
end