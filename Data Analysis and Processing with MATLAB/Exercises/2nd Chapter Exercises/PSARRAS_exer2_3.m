clear; clc;

% number of values of random variables
n=100000000;

% give random values to the X and Y random variables for multivariable normal distribution 
mu = [0 0];
Sigma = [0.1 0; 0 0.1];
R = mvnrnd(mu,Sigma,n);
X=R(:,1);
Y=R(:,2);

% Calculate variance for X, Y and the sum X+Y
VarX=var(X);
VarY=var(Y);
VarXY=var(X+Y);

% An if command checks if the relation Var[X+Y]=Var[X]+Var[Y] is true for
% the variables X and Y.
if round(VarXY-VarX-VarY,4)==0
    disp('Property Var[X+Y]=Var[X]+Var[Y] is true for the dependent random variables X and Y.')
else
    disp('Property Var[X+Y]=Var[X]+Var[Y] is false for the dependent random variables X and Y.')
end