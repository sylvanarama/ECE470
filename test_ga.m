% TEST GA
function [diversity, mean_fitness, max_fitness] = test_ga(target, len, pop_size, max_gen, ep, mp, cp, k1, k2, adapt)
%     cp = 0.93;
%     mp = 0.01;
%     pop_size = 350;
%     ep = 0.4;
%     max_gen = 200;
%     len = 90;
%     target = randi([0,1], 1, len);
%     population = randi([0 1], pop_size, len);
    %population = zeros(pop_size, len);
    %population(1:pop_size/2, :) = [ones(1,len); eye(len); randi([0,1],pop_size/2-len-1, len)];
    %population(pop_size/2+1:end, :) = ~population(1:pop_size/2, :);
    population = randi([0,1], pop_size, len);
    population(1,:) = ones(1,90);
    fitness = zeros(pop_size, 1);
    diversity = zeros(max_gen, 1);
    mean_fitness = zeros(max_gen, 1);
    max_fitness = zeros(max_gen, 1);
    
    for i = 1:max_gen
        %fprintf("Generation %d\n", i);
        % calculate fitness of chromosomes
        for j = 1:pop_size
            fitness(j) = sum(~xor(population(j,:),target))/len;
        end
        
        diversity(i) = sum(pdist(population, 'hamming'));
        mean_fitness(i) = mean(fitness);
        max_fitness(i) = max(fitness);
        %fprintf("D = %5.2f, Mean = %1.2f, Max = %1.2f\n", diversity(i), mean_fitness(i), max_fitness(i));

        % Select members from the population proportionally to their fitness
        [new_pop, new_fit] = select(population, fitness, ep);

        % Perform crossover and mutation on selected chromosomes
        if(adapt)
            new_pop = crossover_adaptive(new_pop, new_fit, ep, k1, k2);
        else
            new_pop = crossover_static(new_pop, cp, ep);
            new_pop = mutate(new_pop, mp, ep);
        end

        % Perfrom mutation on selected chromosomes
        %cp = k2/(max_fitness(i)-mean_fitness(i));
        %mp = max_gen/(i*500);
        %new_pop = mutate(new_pop, mp, ep);
        population = new_pop;
    end

%     diversity = diversity(1:i);
%     mean_fitness = mean_fitness(1:i);
%     max_fitness = max_fitness(1:i);
%     hold on
%     figure(1), plot(diversity)
%     title('Diversity')
%     hold on
%     figure(2), plot(mean_fitness)
%     title('Mean Fitness')
%     hold on
%     figure(3), plot(max_fitness)
%     title('Max Fitness')
end