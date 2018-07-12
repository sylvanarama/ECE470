% Mutation operator: introduce mutations (bit flip) with a probability of p

function mutated_pop = mutate(population, p)
    pop_size = size(population,1);
    num_features = size(population,2);
    mutated_pop = zeros(size(population));
    for i = 1:pop_size
        for j = 1:num_features
            x = rand();
            if x <= p
                mutated_pop(i,j) = ~population(i,j);
            else
                mutated_pop(i,j) = population(i,j);
            end
   
        end
    end
end