% Mutation operator: introduce mutations (bit flip) with a probability of p

function mutated_pop = mutate(population, p, ep)
    pop_size = size(population,1);
    num_features = size(population,2);
    n = floor((ep*pop_size)/2);
    for i = n+1:pop_size
        for j = 1:num_features
            x = rand();
            if x <= p
                population(i,j) = ~population(i,j);
            end
        end
    end
    mutated_pop = population;
end