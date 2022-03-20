    function mean_M=simulation_exp(par,n,M)
        % the exponential distribution generator
        data=exprnd(par,n,M);
        % The average of all the sample means is calsulated
        mean_M=mean(mean(data));
        % The histogram of the sample mean values.
        figure;
        histfit(mean(data));
        title({['Histogram of ' num2str(M) ' sample means (mean values),' ...
            'where its sample has size ' num2str(n) ] [' the '... 
            'parameter of the distribution (lamda or t) has a value of ' num2str(par)]...
            ['The average of the mean values is ' num2str(mean_M)] });
        xlabel('Mean value of samples');
        ylabel('Counts');
    end