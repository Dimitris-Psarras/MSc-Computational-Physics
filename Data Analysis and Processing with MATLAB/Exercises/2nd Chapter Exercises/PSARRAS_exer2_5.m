%% Psarras Dimitrios
% Chapter 2: Exercise 5

clear; clc;

p=normcdf(3.9,4,0.1);
fprintf('The probabiity of a railraods length to be smaller than 3.9 is: %f\n\n',p);

x=norminv(0.01,4,0.1);
fprintf('In order to destroy only 1 percent of the railroads, the smallest acceptable length must be: %f',x);