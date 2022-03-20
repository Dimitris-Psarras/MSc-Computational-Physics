%% Psarras Dimitrios
% AEM = 4407
% Thema 1

clear; clc; close all;

mu = 0;
sigmasq = 4;
n_all = [20,100];
N = 100;
B = 1000;
alpha = 0.05;
c11 = 0;
c12 = 0;

% X - N(0,4)

for j = 1 : length(n_all)
    
    n = n_all(j);
    
    fprintf('number of observations: n = %d\n',n);
    
    sigma = sqrt(sigmasq);
    X = normrnd(mu,sigma,[n,N]);

    for i = 1:size(X,2)
        x = X(:,i);
        [el_l,el_k] = Bootstrap(x,alpha,B);
        if el_l ~= 0 && el_k ~= 0
            c11 = c11 + 1;
        end

        [h,p,stats] = chi2gof(x);
        if h == 1
            c12 = c12 + 1;
        end
    end

    c11_tot = c11/N;
    c12_tot = c12/N;
    
    fprintf('X-N(0,4), Percentage of regection:\nBootstrap : %f, X^2: %f\n',c11_tot, c12_tot);

    % Y - N(0,4) and X = Y^2

    c11 = 0;
    c12 = 0;
    sigma = sqrt(sigmasq);
    Y = normrnd(mu,sigma,[n,N]);
    X = Y.^2;

    for i = 1:size(X,2)
        x = X(:,i);
        [el_l,el_k] = Bootstrap(x,alpha,B);
        if el_l ~= 0 && el_k ~= 0
            c11 = c11 + 1;
        end

        [h,p,stats] = chi2gof(x);
        if h == 1
            c12 = c12 + 1;
        end
    end

    c21_tot = c11/N;
    c22_tot = c12/N;
    
    fprintf('Y - N(0,4) and X = Y^2, Percentage of regection:\nBootstrap : %f, X^2: %f\n',c21_tot, c22_tot);

    % Y - N(0,4) and X = Y^3

    c11 = 0;
    c12 = 0;
    sigma = sqrt(sigmasq);
    Y = normrnd(mu,sigma,[n,N]);
    X = Y.^3;

    for i = 1:size(X,2)
        x = X(:,i);
        [el_l,el_k] = Bootstrap(x,alpha,B);
        if el_l ~= 0 && el_k ~= 0
            c11 = c11 + 1;
        end

        [h,p,stats] = chi2gof(x);
        if h == 1
            c12 = c12 + 1;
        end
    end

    c31_tot = c11/N;
    c32_tot = c12/N;
    
    fprintf('Y - N(0,4) and X = Y^3, Percentage of regection:\nBootstrap : %f, X^2: %f\n\n',c31_tot, c32_tot);
end

%% Sxolia

% Fainetai oti oi duo elegxoi exoun idia apodosi mono gia thn periptwsh
% opou n = 20 dhladh mikro. Otan to n = 100 ginetai megalo parathreitai
% diafora alla h telikh apofash gai rejection h no-rejection einai idia 
% kai gia tous 2 elegxous

% Shmantikh diafora sthn apodosh parateireitai sthn trith periptwsh opoy se
% poly megalo bathmo peftei ektos h apodosh pou ypologizetai apo th
% bootstrap.