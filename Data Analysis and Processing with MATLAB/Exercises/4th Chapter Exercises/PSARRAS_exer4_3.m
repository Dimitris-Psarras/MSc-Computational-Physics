%% Psarras Dimitrios
% Chapter 4: Exercise 3

clear; clc;

%% A. and B.

V_m = 77.78;
V_sigma = 0.71;
I_m = 1.21;
I_sigma = 0.071;
f_m = 0.283;
f_sigma = 0.017;

P_m = V_m*I_m*cos(f_m);
P_sigma=sqrt((cos(f_m)*I_m*V_sigma)^2+(cos(f_m)*V_m*I_sigma)^2+(V_m*sin(f_m)*I_m*f_sigma)^2);

fprintf(['According to the mean values and sigma of V, I and f the power is : P(mean)=%4f +-',...
    '%4f, where ó_P=%4f\n'],P_m,P_sigma,P_sigma);

%simulation

M = 1000;
V = normrnd(V_m,V_sigma,1,M);
I = normrnd(I_m,I_sigma,1,M);
f = normrnd(f_m,f_sigma,1,M);

P=V.*I.*cos(f);
P_m_a=mean(P);
P_s=std(P);
%P_s=mean(sqrt((cos(f).*I*V_sigma).^2+(cos(f).*V*I_sigma).^2+(V.*sin(f).*I*f_sigma).^2));

fprintf(['For M=%d samples we can calculate that the mean value of Power is P(mean) = %4f',...
    ' and the variance of the Power is ó_P=%4f\n'],M ,P_m_a,P_s);

%Plot
figure();
hold on;
xline(P_m,'-r');
histogram(P);
legend("Expected\newline\mu_{P} = " + num2str(P_m));
title("Mean value \mu for P (M = " + M + " samples)");
xlabel('Mean value, \mu_{P}, (Watt)');
ylabel('Counts');
grid on;

%% C.

r=0.5;
sigmaP_vf=sqrt((cos(f_m)*I_m*V_sigma)^2+(cos(f_m)*V_m*I_sigma)^2+(V_m*sin(f_m)*I_m*f_sigma)^2-...
    2*V_m*I_m^2*sin(f_m)*cos(f_m)*r*V_sigma*f_sigma);
s_Vf=r*V_sigma*f_sigma;
mu=[V_m I_m f_m];
sigma=[V_sigma^2 0 s_Vf; 0 I_sigma^2 0;s_Vf 0 f_sigma^2];
V_f=mvnrnd(mu,sigma,1000);

V_c=(V_f(:,1))';
I_c=(V_f(:,2))';
f_c=(V_f(:,3))';

P_c=V_c.*I_c.*cos(f_c);
P_m_c=mean(P_c);
P_s_c=std(P_c);

fprintf('Considering that ñ=0.5 for V and f\n' );
fprintf(['For M=%d samples we can calculate that the mean value of Power is P(mean) = %4f',...
    ' and the variance of the Power is ó_P=%4f (witch expected value ó=%4f)\n'],M ,P_m_c,P_s_c,sigmaP_vf);