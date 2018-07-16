% Crossover operator: performs single point corssover with probablity p

function offspring = crossover_static(parents, cp, ep)
    pop_size = size(parents,1);
    num_features = size(parents,2);
    offspring = zeros(size(parents));
    n = floor(ep*pop_size);
    % preserve best solutions **assumes "select" was run before crossover**
    offspring(1:n,:) = parents(1:n,:);
   
    for i = n+1:2:pop_size-1
        
        p1 = randi(size(parents, 1));
        p2 = randi(size(parents, 1));
        
        parent1 = parents(p1,:);
        parent2 = parents(p2, :);
        parents([p1,p2], :) = [];
        
        x = rand();
        if x <= cp
            cross_pt = randi(num_features);
            offspring(i,:) = [parent1(1:cross_pt), parent2(cross_pt+1:end)];
            offspring(i+1,:) = [parent2(1:cross_pt), parent1(cross_pt+1:end)];
        else
            offspring(i,:) = parent1;
            offspring(i+1,:) = parent2;
        end
        
    end
end