%% Psarras Dimitrios 
% Project 2022
% 5th exercise

clear; clc; close all;

%% Initialization
L = 1000;
M = 1000;

AEM = 4407;
country_gr = 'Greece';
level = 'national';
w_1 = '2021-W38';
w_2 = '2021-W50';

%% Find the Country that corresponds to the AEM of the student
country = mod(AEM+1,25);

countries = readtable('EuropeanCountries.xlsx','ReadRowNames',true);
countries_5 = countries{country-2:country+2,:};
fprintf('The countries for which the correletion of the positivity rate with Greece is checked are:\n');
for coun=1:length(countries_5)
    fprintf('%s, ',countries_5{coun});
end
fprintf('\n');

%% Find the weeks W38 - W50 of 2021 corresponding to WEEKLY positivity rate for 5 Countries arround the Country of the student 
% On national level and for the weeks 2021 - W38 - W50

Full_data_Table = readtable('ECDC-7Days-Testing.xlsx');
Full_data_Table_Rows = readtable('ECDC-7Days-Testing.xlsx','ReadRowNames',true);
table_eu = [];

for i=1:length(countries_5)
    T_mc = find(strcmp(Full_data_Table.country, countries_5{i}));
    table_eu = [table_eu; T_mc];
end

T_mc = find(strcmp(Full_data_Table.country, country_gr));
table_eu = [table_eu; T_mc];

data_Countries_5 = Full_data_Table_Rows(table_eu,:);

T_mn = find(strcmp(data_Countries_5.level,level));
data_National_Countries_5 = data_Countries_5(T_mn,:);

Index_1 = find(strcmp(data_National_Countries_5.year_week, w_1));
Index_2 = find(strcmp(data_National_Countries_5.year_week, w_2));
data_eu = data_National_Countries_5(Index_1(1):Index_2(1),:);
for j=2:length(Index_1)
    data_Countries_eu_5 = data_National_Countries_5(Index_1(j):Index_2(j),:);
    data_eu = [data_eu; data_Countries_eu_5];
end

data_pr_eu = data_eu.positivity_rate;

n = length(Index_1(1):Index_2(1));
m = length(countries_5);

data_all = reshape(data_pr_eu,n,m+1);

all_countries = [countries_5; country_gr];

%% Calculatio of pearson correletion for each pair of Greece with the 5 european countries

% Parousiasei twn apotelesmatwn gia mia prvth ektimisi
weeks = 38:1:50;
figure();
for o=1:size(data_all,2)
    subplot(3,2,o);
    plot(weeks,data_all(:,o));
    title(sprintf('Distribution of positivity rate for country %s',all_countries{o}));
    xlabel('week of 2021');
    ylabel('weekly positivity rate');
end

% Calculation of pearson correletion
data_gr = data_all(:,6);
r_pear = zeros(m,1);
for k=1:m
    [R,P,RL,RU] = corrcoef(data_gr,data_all(:,k));
    r_pear(k) = R(1,2);
end

fprintf('The pearson correletion for the pair of the weekly positivity rate of Greece with each of the 5 european countries.\n');
for k=1:m
    fprintf('%s with %s: r = %f\n',countries_5{k},country_gr,r_pear(k));
end

%% Parametric and non-Parametric test to check the correletion between Greece and the 5 european countries

printfig = 1;
binsL = round(sqrt(L));
alph = [0.05, 0.01];
counter = 0;
country_num = [];

for a=1:length(alph)
    alpha = alph(a);
    fprintf('\nParametric and non-parametric test for significance level alpha = %f\n',alpha);
    lowlim = round((alpha/2)*L);
    uplim = round((1-alpha/2)*L);
    tcrit = tinv(1-alpha/2,n-2);
    if printfig == 1
        figure();
    end
    for i=1:m
        dat_c = data_all(:,i);
        xM = [data_gr dat_c];
        tmpM = corrcoef(xM);
        r = tmpM(1,2);
        rV = NaN*ones(L,1);
        for j=1:L
            zM = [data_gr dat_c(randperm(n),1)];
            tmpM = corrcoef(zM);
            rV(j) = tmpM(1,2);
        end
        t = r*sqrt((n-2)/(1-r^2));
        tV = rV.*sqrt((n-2)./(1-rV.^2));
        otV = sort(tV);
        tl = otV(lowlim); 
        tu = otV(uplim);
        fprintf('--- Country %s \n',countries_5{i});
        if abs(t)>tcrit
            fprintf(' parametric test (alpha=%.2f): abs(t-statistic)=%2.3f > %1.3f -> reject H0 \n',alpha,abs(t),tcrit);
            fprintf(' The correletion of the weekly positivity rate between %s and %s is statistically important.\n',country_gr,countries_5{i})
            counter = counter + 1;
            country_num(end+1) = i;
        else
            fprintf(' parametric test (alpha=%.2f): abs(t-statistic)=%2.3f < %1.3f -> no reject H0 \n',alpha,abs(t),tcrit);
            fprintf(' The correletion of the weekly positivity rate between %s and %s is statistically unimportant.\n',country_gr,countries_5{i})
        end
        if t<tl || t>tu
            fprintf(' randomization test (alpha): t-statistic=%2.3f not in [%1.3f,%1.3f] -> reject H0 \n',t,tl,tu);
            fprintf(' The correletion of the weekly positivity rate between %s and %s is statistically important.\n',country_gr,countries_5{i})
        else
            fprintf(' randomization test (alpha): t-statistic=%2.3f in [%1.3f,%1.3f] -> no reject H0 \n',t,tl,tu);
            fprintf(' The correletion of the weekly positivity rate between %s and %s is statistically unimportant.\n',country_gr,countries_5{i})
        end    
        
        if printfig == 1
            subplot(3,2,i);
            hold on
            histogram(rV,binsL)
            xline(r,'r',{'Correlation Coefficient','Sample'});
            xline(0,'b',{'Correlation Coefficient r=0','H0 hypothesis'});
            xlabel('r')
            ylabel('counts')
            title(sprintf('n=%d, L=%d, alpha=%.2f r-randomized-histogram for countries %s - Greece',n,L,alpha,countries_5{i}))
        end
    end
    printfig = 0;
    fprintf('\nFor importnace level alpha = %.2f, the number of countries for which the correletion of weekly pisitivity rate is statistically important is: %d\n',alpha,counter);
    fprintf('The correlated pairs are:\n');
    for index=1:length(country_num)
        fprintf('%d. %s - %s\n',index,country_gr,countries_5{country_num(index)});
    end
    counter = 0;
    country_num = [];
end

sc = find(r_pear==max(r_pear));
fprintf('\nThe strongest statistically important correletion of weekly positivity rate with Greece data belongs to country: %s, with value of Pearson correlator r = %f\n',countries_5{sc},r_pear(sc));

%% Sxolia

% To figure 1 aptelei thn parousiasei twn dedomenwn prokeimenoy na dothei
% mia prwth ektimhsh. Apo ta graphimata, loipon, ektimatai apo ton foititi
% oti megaliteri sisxetisi emfanizetai anamesa sto weekly pisitivity rate
% ths Czechia kai ths Greece. Auto to symperasma prokeiptei apo thn
% parathrhsh oti kata tis idies periodous peripou (me mia mirkh usterisi)
% parousiazetai auxish tou positivity rate opou ftanei se ena megisto kai 
% meta meiwnetai. Oi upoloipes xwres emfanizoun eite peripoy monotwnei
% auxisei eite emganizoyn epishs elaxista kai gia auto to logo o foititis
% aporiptei to endexomeno na yparxei shmantikh sysxetish.

% Arxika ypologisthikan ta r (correlation coefficient) gia kathe zeygari.
% Apo tis times toys fainetai mono to zeygari ths Czechia - Greece na exei
% r megalitero tou 0.5 gegonos poy enisxyei thn arxikh ypothesi tou foititi.

% Pragmatopoihthike elegxos simantikothtas toy synteleasti sysxetisis gia
% kathe zeugari tvn 5 xwrxn me thn ellada. O elegxos pragmatopoihthike gia
% epipedo shmantikothtaw 0.05 kai 0.01. Egine toso parametrikos elegxos me
% student oso kai mh-parametrikos me tuxaiopoihsh. Oi elegxoi ginontai me
% thn ypothesi oti to r kathe zeugous einai 0. Kai oi dyo elegxoi
% epistrefoun to idio apotelesma. Dhladh oti h null hypothesis H0
% aporipetai mono gia to zeugos Czechia - Greece kai den aporiptetai gia ta
% ypoloipa zeygoi. Epomenos, yparxei statistika shmantiki sysxetisi mono
% metaxi Czechia kai Greece kai episis to zeugos auto parousiazei to
% megalitero r syntelesth susxetisis r = 0.716972