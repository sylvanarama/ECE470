% Crossover operator **UNFINISHED**

function offspring = crossover(parents, pop_size)
    offspring = zeros(size(parents));
    for i = 1:2:pop_size-1
        cross_pt = randi(90);
        parent1 = parents(randi(pop_size), :);
        parent2 = parents(randi(pop_size), :);
        offspring(i,:) = [parent1(1:cross_pt), parent2(cross_pt+1:end)];
        offspring(i+1,:) = [parent1(1:cross_pt), parent2(cross_pt+1:end)];
    end
end