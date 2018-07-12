% Crossover operator **TODO: select parents with probability p

function offspring = crossover(parents)
    pop_size = size(parents,1);
    num_features = size(parents,2);
    offspring = zeros(size(parents));
    for i = 1:2:pop_size-1
        cross_pt = randi(num_features);
        parent1 = parents(randi(pop_size), :);
        parent2 = parents(randi(pop_size), :);
        offspring(i,:) = [parent1(1:cross_pt), parent2(cross_pt+1:end)];
        offspring(i+1,:) = [parent2(1:cross_pt), parent1(cross_pt+1:end)];
    end
end