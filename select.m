% SELECTION OPERATOR
% Creates a new population by selecting chromosomes with a probability 
% proportional to their fitness (roulette wheel selection)
% Fitness: measure of chromosome's classification performance

function new_pop = select(population, fitness)
    pop_size = size(population,1);
    new_pop = zeros(size(population));
    wheel = zeros(1,pop_size);
    for i = 1:pop_size
        wheel(i) = sum(fitness(1:i));
    end
    wheel = wheel/max(wheel);
    
    for i = 1:pop_size
        x = rand();
        index = find(wheel>=x, 1);
        new_pop(i,:) = population(index,:);
    end
        
end