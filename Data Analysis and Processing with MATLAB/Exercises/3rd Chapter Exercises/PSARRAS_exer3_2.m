%% Psarras Dimitrios
% Chapter 3: Exercise 2.b

clear; clc;

% The simulation is repeated for an number of r times. The r has values
% from 1 to 11 and the number its time is calculated randomly. In case you
% want to insert manually the nu,ber of time the simualtion is repeated
% comment the next line and uncomment the line "r = input('Input the number of desirable repetitions: ')"
r = randi(10)+1;
%r = input('Input the number of desirable repetitions: ');

for i=1:r
    % the number of the sample, each sample size and the parameter of
    % distribution is randomly selected
    M = randi([1000,10000]);
    n = randi([100,1000]);
    t = randi(100);
    % histogram generated from the function "simulation"
    mu=simulation_exp(t,n,M);
    % Print of the average value of the sample means and the parameters of
    % the simulation
    formatspec = 'The average value of the sample means is %8.4f. The simulation has M=%d samples of size n=%d and t=%d \n';
    fprintf(formatspec,mu,M,n,t);
end