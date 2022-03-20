%% Psarras Dimitrios 
% AEM = 4407
% Project 2022
% 2nd exercise

clear; clc; close all;

%% Initialization
M = 1000;

AEM = 4407;
level = 'national';
w_2020_1 = '2020-W48';
w_2020_2 = '2020-W53';
w_2021_1 = '2021-W45';
w_2021_2 = '2021-W50';

%% Find the Country that corresponds to the AEM of the student
country = mod(AEM+1,25);

countries = readtable('EuropeanCountries.xlsx','ReadRowNames',true);
my_country = cell2mat(countries(string(country),:).Country);

%% Find the weeks of 2020 and 2021 corresponding to the highest positivity rate for the Country of the Student 
% On national level and for the weeks 2020 - W45 - W50 and 2021 - W45 - W50

Full_data_Table = readtable('ECDC-7Days-Testing.xlsx');
Full_data_Table_Rows = readtable('ECDC-7Days-Testing.xlsx','ReadRowNames',true);

T_mc = find(strcmp(Full_data_Table.country, my_country));
data_myCountry = Full_data_Table_Rows(min(T_mc):max(T_mc),:);

T_mn = find(strcmp(data_myCountry.level,level));
data_National_MyCountry = data_myCountry(min(T_mn):max(T_mn),:);

Index_45w_20 = find(strcmp(data_National_MyCountry.year_week, w_2020_1));
Index_50w_20 = find(strcmp(data_National_MyCountry.year_week, w_2020_2));
Index_45w_21 = find(strcmp(data_National_MyCountry.year_week, w_2021_1));
Index_50w_21 = find(strcmp(data_National_MyCountry.year_week, w_2021_2));
data_MyCountry_45_50_2020 = data_National_MyCountry(Index_45w_20:Index_50w_20,:);
data_MyCountry_45_50_2021 = data_National_MyCountry(Index_45w_21:Index_50w_21,:);


week_2020 = data_MyCountry_45_50_2020(data_MyCountry_45_50_2020.positivity_rate == max(data_MyCountry_45_50_2020.positivity_rate),:);
week_20 = week_2020.year_week;
week_2021 = data_MyCountry_45_50_2021(data_MyCountry_45_50_2021.positivity_rate == max(data_MyCountry_45_50_2021.positivity_rate),:);
week_21 = week_2021.year_week;

%% Collect the corresponding data for the weeks

countries_25 = countries.Country;
index_25 = [];
for i=1:size(countries_25)
    T = find(strcmp(Full_data_Table.country,countries_25{i}));
    index_25 = [index_25 T'];
end

Full_data_Table_25 = Full_data_Table(index_25,:);
Full_data_Table_Rows_25 = Full_data_Table_Rows(index_25,:);

T_1 = find(strcmp(Full_data_Table_25.level,level));
T_2 = find(strcmp(Full_data_Table_25.year_week,week_20));
T_3 = find(strcmp(Full_data_Table_25.year_week,week_21));

index_1 = T_1(ismember(T_1, T_2));
index_2 = T_1(ismember(T_1, T_3));

data1_Table = Full_data_Table_Rows_25(index_1,:);
data2_Table = Full_data_Table_Rows_25(index_2,:);

% auta einai ta dedomena ta opoia tha xrisimopoihthoun apo ton foititi 
data1 = data1_Table.positivity_rate;
data2 = data2_Table.positivity_rate;

% istograma twn dedomenwn prokeimenou na apoktithei mia prwth ektimisi
figure();
hold on;
histogram(data1,'Normalization','pdf');
histogram(data2,'Normalization','pdf');
title(sprintf('Histogram of positivity rate distributions for Year-Week = %s and %s from 25 european countries',data1_Table.year_week{1},data2_Table.year_week{1}));
xlabel('Positivity Rate');
ylabel('PDF');
legend(data1_Table.year_week{1},data2_Table.year_week{1});

%% Kolmogorov-Smirnov Test on 2 data distributions.
% efarmogi tou statistikou elegxou Kolmogorv - Smirnov

n = length(data1);
dif = zeros(n,1);
dif_all = zeros(M,1);
h = zeros(M,1);
ks2stat = zeros(M,1);

alpha = 0.05;
lowlim = round((alpha/2)*M);
upplim = round((1-alpha/2)*M);

data_f = [data1', data2']';
x = sort(data_f);

for i=1:n+n
    cdf1 = sum(data1<=x(i))/n;
    cdf2 = sum(data2<=x(i))/n;
    dif(i) = abs(cdf1-cdf2);
end

ks_sample = max(dif);

for i=1:M
    random_sim =data_f(randperm(n+n),1);
    set_1 = random_sim(1:n);
    set_2 = random_sim(n+1:n+n);
    sort1 = sort(set_1);
    sort2 = sort(set_2);
    for k=1:length(x)
        cdf1 = sum(sort1<=x(k))/n;
        cdf2 = sum(sort2<=x(k))/n;
        dif(k) = abs(cdf1-cdf2);
    end
    dif_all(i) = max(dif);
    [h(i),p,ks2stat(i)] = kstest2(set_1,set_2); 
end

otV = sort(dif_all);
ksl = otV(lowlim); 
ksu = otV(upplim);

fprintf('Hypothesis: The data distributions of positivity rate for year-weeek %s and %s from 25 european countries do not differ.\n',data1_Table.year_week{1},data2_Table.year_week{1});
if ks_sample<ksl || ks_sample>ksu
    fprintf('Randomization test (alpha): ks-statistic=%2.3f not in [%1.3f,%1.3f] -> reject Hypothesis \n',ks_sample,ksl,ksu);
else
    fprintf('Randomization test (alpha): ks-statistic=%2.3f in [%1.3f,%1.3f] -> no reject Hypothesis \n',ks_sample,ksl,ksu);
end   

figure();
hold on;
histogram(otV,'Normalization','pdf');
xline(ks_sample,'b',{'Kolmogorov-Smirnov','Sample Statistic'});
xline(ksl,'r',{'95% Confidence Interval','Lower Limit'});
xline(ksu,'r',{'95% Confidence Interval','Upper Limit'});
title('Histogram of Kolmogorov-Smirnov Statistic max_{x}|F_{X}(x)-F_{Y}(x)|');
xlabel('Kolmogorov-Smirnov Statistic max_{x}|F_{X}(x)-F_{Y}(x)|');
ylabel('PDF');

ks2stat = sort(ks2stat);
figure();
hold on;
histogram(ks2stat,'Normalization','pdf');
xline(ks_sample,'b',{'Kolmogorov-Smirnov','Sample Statistic'});
xline(ks2stat(lowlim),'r',{'95% Confidence Interval','Lower Limit'});
xline(ks2stat(upplim),'r',{'95% Confidence Interval','Upper Limit'});
title('Histogram of Kolmogorov-Smirnov Statistic max_{x}|F_{X}(x)-F_{Y}(x)|');
xlabel('Kolmogorov-Smirnov Statistic max_{x}|F_{X}(x)-F_{Y}(x)|');
ylabel('PDF');

fprintf('p-value from ks2test: %f\n',1-sum(h)/M)


%% Sxolia

% To figure 1 aptelei thn parousiasei twn dedomenwn prokeimenoy na dothei
% mia prwth ektimhsh. Apo to istograma loipon ektimatai apo ton foititi oti
% oi katanomes twn dedomenwn den diaferoun. Pithanologitai apo to foititi h
% katanomi poy proseggizei kalytera tis katanomes twn dedomenwn einai h
% ekthetiki (exponential).

% Gia na apantithei to erwtima xrisimopoihthike o statistikos elegxos
% Kolmogorov-Smirnov. Thewritai oti den gnwrizoume gnosti parametriki
% katanomi toy statistikoy kai gia ayto ginetai elegxos tuxaiopoihshs. Etsi
% apo ton elegxo tuxaiopoihshs tha ypologisthoun M=1000 tuxaiopoihmena
% deigmata. Se kathe deigma ypologizetai to statistiko kolmogorov kai
% sxediazetai to istogramma. Sto kathe sunolo
% M statistikwn kolmogorov-smirnov brisketai h 25 kai h 975 timi. Oi times
% autes apoteloun to diastima empistosynis. Etsi ypologizetai to statistiko
% Kolmogorov-smitnov gia to arxiko mh-tuxaiopoihmeno deigma twn 2 katanomwm.
% To statistiko sample exetazetai an periexetai entos twn diastimatwn
% empistosinis. An periexetai tote den einai dinato na aporifthei h
% mhdenikh ypothesis oti den diaferoun oi katanomes toy 2020 kai 2021. O
% elegxos pragmatopoihtai me duo tropous. Ston prwto o ypologismos toy
% statistikou kolmogorov-smirnov ginetai apo ton foititi enw sto deutero
% xrhsimopoithike h built-in synarthsh toy matlab kstest2 mesw ths opoios
% ypologisthhke to statistiko. Kai oi dyo katanomes twn statistikwn
% parousiazontai mazi me to sample statistic. Telos, apo thn xrhsh toy
% ks2test paroysiazetai kai h timi toy p gia ton elegxo ypothesis.