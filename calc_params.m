% CALC PARAMS

% Genetic Algorithm Parameters
pop_size = 100; % population size
ep = 0.35;      % elitism percentage
cp = 0.93;      % crossover probability (when not using adaptive)
mp = 0.002;      % mutation probability (when not using adaptive)
k1 = 0.90;      % Adaptive crossover factor
k2 = 0.25;      % Adaptive mutation factor

% Test Code Parameters
max_gen = 100;                 % Maximum generations
len = 90;                      % Chromosome length
target = randi([0,1], 1, len); % Goal Sequence
trials = 10;                   % Number of trials for each parameter value
test_var = k2;                 % Parameter being tested

figure
hold on

% Population Size
if (test_var == pop_size)
    pop_size = len:100:100*len;
    test_var = pop_size;
    max_fit_final = zeros(max_gen, length(pop_size));
    max_fit_temp = zeros(max_gen, trials);
    for i = 1:length(pop_size)
        for j = 1:trials
            [d, avg, mx] = test_ga(target, len, pop_size(i), max_gen, ep, mp, cp, k1, k2, true);
            max_fit_temp(:,j) = mx;
        end
        max_fit_final(:,i) = mean(max_fit_temp,2);
        plot(max_fit_final(:,i), 'linewidth', 2)
    end
end

% Elitism Percentage
if (test_var == ep)
    ep = 0.:0.01:0.55;
    test_var  = ep;
    max_fit_final = zeros(max_gen, length(ep));
    max_fit_temp = zeros(max_gen, trials);
    for i = 1:length(ep)
        for j = 1:trials
            [d, avg, mx] = test_ga(target, len, pop_size, max_gen, ep(i), mp, cp, k1, k2, true);
            max_fit_temp(:,j) = mx;
        end
        max_fit_final(:,i) = mean(max_fit_temp,2);
        plot(max_fit_final(:,i), 'linewidth', 2)
    end
end

% Crossover Probability
if (test_var == cp)
    %cp = 0.9:0.001:0.95;
    %test_var = cp;
    max_fit_final = zeros(max_gen, length(cp));
    max_fit_temp = zeros(max_gen, trials);
    for i = 1:length(cp)
        for j = 1:trials
            [d, avg, mx] = test_ga(target, len, pop_size, max_gen, ep, mp, cp(i), k1, k2, false);
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
            [d, avg, mx] = test_ga(target, len, pop_size, max_gen, ep, mp(i), cp, k1, k2, false);
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
            [d, avg, mx] = test_ga(target, len, pop_size, max_gen, ep, mp, cp, k1(i), k2, true);
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
            [d, avg, mx] = test_ga(target, len, pop_size, max_gen, ep, mp, cp, k1, k2(i), true);
            max_fit_temp(:,j) = mx;
        end
        max_fit_final(:,i) = mean(max_fit_temp,2);
        plot(max_fit_final(:,i), 'linewidth', 2)
    end
end


final = zeros(length(test_var), 2);
final(:,1) = test_var';
final(:,2) = max_fit_final(end,:);

%legend('0.1', '0.2', '0.3','0.4', '0.5', '0.6', '0.7', 'Location', 'southeast');
%legend('0.80','0.85', '0.90','0.95', '1.0', 'Location', 'southeast');
legend('0.24','0.25', '0.26','0.27', '0.28', '0.29', '0.30', 'Location', 'southeast');
title('Optimization of Mutation Factor k2, Crossover Factor k1 = 0.9');
%legend('0.41', '0.43', '0.45', '0.47', '0.49', '0.51','Location', 'southeast');
%ylim([0.0 1.0])