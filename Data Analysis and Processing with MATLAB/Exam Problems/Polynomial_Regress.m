function [y_hat,R2,h] = Polynomial_Regress(xV,yV,k)
    
    n = length(xV);
    alpha = 0.05;
    tcrit = tinv(1-alpha/2,n-2);
    
    y_mean = mean(yV);
    p = polyfit(xV,yV,k);
    y_hat = polyval(p,xV);
    
    comb = [yV, y_hat];
    tmpM = corrcoef(comb);
    r = tmpM(1,2);
    t = r*sqrt((n-2)/(1-r^2));
    
    R2 = 1 - ((sum((yV-y_hat).^2))/(sum((yV-y_mean).^2)));
    
    if abs(t)<tcrit
        h = 1;
    else
        h = 0;
    end
    
end