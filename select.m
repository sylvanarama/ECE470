% SELECTION OPERATOR
% Creates a new population by selecting chromosomes with a probability 
% proportional to their fitness (roulette wheel selection)
% Fitness: measure of chromosome's classification performance

function [new_pop, new_fit] = select(population, fitness, elitism)
    pop_size = size(population,1);
    new_pop = zeros(size(population));
    new_fit = zeros(size(fitness));
    n = floor(elitism*pop_size);
    
    % Copy over the current best solutions to the new population
    [f_sort, f_idx] = sort(fitness, 'descend');
    pop_sort = population(f_idx,:);
    
    [pop_sort, ia, ~] = unique(pop_sort, 'stable', 'rows');
    f_sort = f_sort(ia);
    
    new_pop(1:n,:) = pop_sort(1:n,:);
    new_fit(1:n) = f_sort(1:n);
    
    % Build the roulette wheel from the fitnesses
    wheel = zeros(1,length(f_sort));
    for i = 1:length(f_sort)
        wheel(i) = sum(f_sort(1:i));
    end
    wheel = wheel/max(wheel);
    
    % Select chromosomes for the mating pool
    for i = n+1:pop_size
        x = rand();
        index = find(wheel > x, 1);
        new_pop(i,:) = pop_sort(index,:);
        new_fit(i) = f_sort(index);
    end
    %[new_fit, idx]  = sort(new_fit, 'descend');
    %new_pop = new_pop(idx, :);
     %[new_pop(2:end,:), idx] = datasample(population, pop_size-1, 'Weights', fitness);
end