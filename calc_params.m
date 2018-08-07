% CALC PARAMS

% Genetic Algorithm Parameters
pop_size = 250; % population size
ep = 0.25;      % elitism percentage
cp = 0.98;      % crossover probability (when not using adaptive)
mp = 0.006;      % mutation probability (when not using adaptive)
k1 = 0.90;      % Adaptive crossover factor
k2 = 0.25;      % Adaptive mutation factor
pop_init = 0;

% Test Code Parameters
max_gen = 100;                 % Maximum generations
len = 90;                      % Chromosome length
target = randi([0,1], 1, len); % Goal Sequence
trials = 10;                   % Number of trials for each parameter value
test_var = 0;                 % Parameter being tested

figure
hold on

% Population Initialization: 1 = random, 2 = H1, 3 = H2
if (test_var == pop_init)
    pop_init = 1:3;
    test_var = pop_init;
    max_fit_final = zeros(max_gen, length(pop_init));
    max_fit_temp = zeros(max_gen, trials);
    for i = 1:length(pop_init)
        for j = 1:trials
            [d, avg, mx] = test_ga(target, len, pop_size, pop_init(i), max_gen, ep, mp, cp, k1, k2, false);
            max_fit_temp(:,j) = mx;
        end
        max_fit_final(:,i) = mean(max_fit_temp,2);
        plot(max_fit_final(:,i), 'linewidth', 2)
    end
end

% Population Size
if (test_var == pop_size)
    pop_size = 100:50:400;
    test_var = pop_size;
    max_fit_final = zeros(max_gen, length(pop_size));
    max_fit_temp = zeros(max_gen, trials);
    for i = 1:length(pop_size)
        for j = 1:trials
            [d, avg, mx] = test_ga(target, len, pop_size(i), pop_init, max_gen, ep, mp, cp, k1, k2, false);
            max_fit_temp(:,j) = mx;
        end
        max_fit_final(:,i) = mean(max_fit_temp,2);
        plot(max_fit_final(:,i), 'linewidth', 2)
    end
end

% Elitism Percentage
if (test_var == ep)
    ep = 0.15:0.05:0.45;
    test_var  = ep;
    max_fit_final = zeros(max_gen, length(ep));
    max_fit_temp = zeros(max_gen, trials);
    for i = 1:length(ep)
        for j = 1:trials
            [d, avg, mx] = test_ga(target, len, pop_size, pop_init, max_gen, ep(i), mp, cp, k1, k2, false);
            max_fit_temp(:,j) = mx;
        end
        max_fit_final(:,i) = mean(max_fit_temp,2);
        plot(max_fit_final(:,i), 'linewidth', 2)
    end
end

% Crossover Probability
if (test_var == cp)
    cp = 0.9:0.02:1.0;
    test_var = cp;
    max_fit_final = zeros(max_gen, length(cp));
    max_fit_temp = zeros(max_gen, trials);
    for i = 1:length(cp)
        for j = 1:trials
            [d, avg, mx] = test_ga(target, len, pop_size, pop_init, max_gen, ep, mp, cp(i), k1, k2, false);
            max_fit_temp(:,j) = mx;
        end
        max_fit_final(:,i) = mean(max_fit_temp,2);
        plot(max_fit_final(:,i), 'linewidth', 2)
    end
end

% Mutation Probability
if (test_var == mp)
    mp = 0.001:0.001:0.01;
    test_var = mp;
    max_fit_final = zeros(max_gen, length(mp));
    max_fit_temp = zeros(max_gen, trials);
    for i = 1:length(mp)
        for j = 1:trials
            [d, avg, mx] = test_ga(target, len, pop_size, pop_init, max_gen, ep, mp(i), cp, k1, k2, false);
            max_fit_temp(:,j) = mx;
        end
        max_fit_final(:,i) = mean(max_fit_temp,2);
        plot(max_fit_final(:,i), 'linewidth', 2)
    end
end

% k1
if (test_var == k1)
    k1 = 0.8:0.05:1;
    test_var = k1;
    max_fit_final = zeros(max_gen, length(k1));
    max_fit_temp = zeros(max_gen, trials);
    for i = 1:length(k1)
        for j = 1:trials
            [d, avg, mx] = test_ga(target, len, pop_size, pop_init, max_gen, ep, mp, cp, k1(i), k2, true);
            max_fit_temp(:,j) = mx;
        end
        max_fit_final(:,i) = mean(max_fit_temp,2);
        plot(max_fit_final(:,i), 'linewidth', 2)
    end
end

% k2
if (test_var == k2)
    %k2 = 0.24:0.01:0.3;
    %test_var = k2;
    max_fit_final = zeros(max_gen, length(k2));
    max_fit_temp = zeros(max_gen, trials);
    for i = 1:length(k2)
        for j = 1:trials
            [d, avg, mx] = test_ga(target, len, pop_size, pop_init, max_gen, ep, mp, cp, k1, k2(i), true);
            max_fit_temp(:,j) = mx;
        end
        max_fit_final(:,i) = mean(max_fit_temp,2);
        plot(max_fit_final(:,i), 'linewidth', 2)
    end
end


final = zeros(length(test_var), 2);
final(:,1) = test_var';
final(:,2) = max_fit_final(end,:);


title('Optimization of Population Initialization');
legend('Random','Heuristic 1', 'Heuristic 2', 'Location', 'southeast');

%title('Optimization of Population Size');
%legend('100','300', '500','700', '900', '1100','Location', 'southeast');
%legend('100','150', '200','250', '300', '350', '400','Location', 'southeast');


%title('Optimization of Elitism Percentage');
%legend('10', '20', '30','40', '50', '60', '70', 'Location', 'southeast');
%legend('15', '20', '25','30', '35', '40', '45', 'Location', 'southeast');
%legend('30', '35', '40','45', '50', '55', '60', 'Location', 'southeast');
% legend('27', '28', '29','30', '31', '32', '33', 'Location', 'southeast');
% 
% title('Optimization of Crossover Probability');
% legend('90','92', '94','96', '98', '100', 'Location', 'southeast');
% 
% title('Optimization of Mutation Probability');
% legend('0.0', '0.2', '0.4', '0.6', '0.8', '1.0','Location', 'southeast');
% 
% title('Optimization of Adaptive Crossover Factor');
% legend('0.8', '0.85', '0.90', '0.95', '1.0','Location', 'southeast');
% 
% title('Optimization of Adaptive Mutation Factor');
% legend('0.41', '0.43', '0.45', '0.47', '0.49', '0.51','Location', 'southeast');

%ylim([0.0 1.0])