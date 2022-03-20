function [numbers] = Polynomial_Stepwise(K,Y,k)
    
    epex_K = K;
    c = 0;
    index = 0;
    numbers = [];
    while c==0
        index = index + 1;
        h = NaN * ones(size(epex_K,2),1);
        R_2 = NaN * ones(size(epex_K,2),1);
        for i = 1: size(epex_K,2)
            x = epex_K(:,i);
            [~,R_2(i),h(i)] = Polynomial_Regress(x,Y,k);
        end
        [~, in] = max(R_2);
        if h(in) == 0
            numbers(index) = in;
            [y_h,~,~] = Polynomial_Regress(epex_K(:,in),Y,k);
            Y = Y - y_h;
            figure()
            scatter(epex_K(:,in),Y)
            title('Diagrama diasporas')
            xlabel('Epilegmenh epexigimatikh metablhth')
            ylabel('Metablhth apokrishs (lambanei ta sfalmata se kathe bhma)')
        else
            c = 1;
        end
    end
    
end