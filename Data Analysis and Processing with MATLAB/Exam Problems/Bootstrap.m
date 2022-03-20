function [h_l,h_k] = Bootstrap(xV,a,B)
    N = length(xV);
    b_l = round(a*B/2);
    b_u = round((1-a/2)*B);
    l = NaN * ones(B,1);
    k = NaN * ones(B,1);
    
    mean_x = mean(xV);
%     L = ((1/N)*sum((xV-mean_x).^3))/((1/N)*sum((xV-mean_x).^2))^(3/2);
%     K = ((1/N)*sum((xV-mean_x).^4))/((1/N)*sum((xV-mean_x).^2))^(2)-3;
    
    for i=1:B
        data_b = xV(unidrnd(N,[N,1]),:);
        mean_b = mean(data_b);
        l(i) = ((1/N)*sum((data_b-mean_b).^3))/((1/N)*sum((data_b-mean_b).^2))^(3/2);
        k(i) = ((1/N)*sum((data_b-mean_b).^4))/((1/N)*sum((data_b-mean_b).^2))^(2)-3;
    end
    
    l = sort(l);
    k = sort(k);
    
    l_l = l(b_l);
    l_u = l(b_u);
    
    k_l = k(b_l);
    k_u = k(b_u);
    
    if 0>l_l && 0<l_u
        h_l = 0;
    else
        h_l = 1;
    end
    
    if 0>k_l && 0<k_u
        h_k = 0;
    else
        h_k = 1;
    end
end