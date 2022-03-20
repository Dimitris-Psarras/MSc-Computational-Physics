%% Psarras Dimitrios
% Chapter 4: Exercise 2

clear; clc;

%% A.
%uncertainty measured in meters (m)
uncertainty=5;

%measurements
len=500;
wid=300;

uncertainty_area=sqrt((len^2+wid^2)*uncertainty^2);

fprintf(['For the measurement of an area of Width = %d m and Length = %d m',...
    ' (uncertainty of each measurement ó_measure = %d m) the uncertainty is ó_A = %.4f m^2.\n\n'],...
    wid, len, uncertainty, uncertainty_area);

%Values of Width and Length for constant uncertainty on teh measurement of
%the area

angle = 0:0.001:pi/2;
radius=uncertainty_area/uncertainty;
x_wid = radius*cos(angle);
y_len = radius*sin(angle);
plot(x_wid,y_len);
title(['Equation: constant'...
    '=width^2+length^2, for width>0, length>0']);
xlabel('Width (m)');
ylabel('Length (m)');
axis equal;
axis([0 700 0 700]);
grid on;

%% B.

[X,Y]=meshgrid(1:10:1000,1:10:1000);
Z=sqrt((X.^2+Y.^2)*uncertainty^2);
figure();
surf(X,Y,Z);
xlabel('Width (m)');
ylabel('Length (m)');
zlabel('Uncertainty of area measurement');
colorbar