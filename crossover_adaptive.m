% Crossover operator: performs single point corssover with probablity p

function offspring = crossover_adaptive(parents, fitness, ep, k1, k2)
    %k1 = 0.9;
    %k2  = 0.4;
    fmax = max(fitness);
    favg = mean(fitness);
    pc = k1*(fmax - fitness)./(fmax - favg);
    pc(fitness <= favg) = k1;
    pm = k2*(fmax - fitness)./(fmax - favg);
    pm(fitness <= favg) = k2;
    
    pop_size = size(parents,1);
    num_features = size(parents,2);
    offspring = zeros(size(parents));
    n = floor(ep*pop_size);
    % preserve best solutions **assumes "select" was run before crossover**
    offspring(1:n,:) = parents(1:n,:);
%     for i = 1:n
%         for j = 1:num_features
%             x = rand();
%             if x <= pm(i)
%                 offspring(i,j) = ~offspring(i,j);
%             end
%         end
%     end
   
    for i = 1:2:pop_size-1   
        x = rand();
        cross_idx = find(pc > x);
        if length(cross_idx) >= 2
            p1 = cross_idx(randi(length(cross_idx)));
            p2 = cross_idx(randi(length(cross_idx)));
            parent1 = parents(p1,:);
            parent2 = parents(p2,:);
            if x <= pm(p1)
                parent1 = mut(parent1);
            end
            if x <= pm(p2)
                parent2 = mut(parent2);
            end
            cross_pt = randi(num_features);
            offspring(i,:) = [parent1(1:cross_pt), parent2(cross_pt+1:end)];
            offspring(i+1,:) = [parent2(1:cross_pt), parent1(cross_pt+1:end)];
%             offspring(i,:) = and(parent1, parent2);
%             offspring(i+1,:) = or(parent1, parent2);
        else
            p1 = randi(size(parents, 1));
            p2 = randi(size(parents, 1));
            parent1 = parents(p1,:);
            parent2 = parents(p2, :);
            if x <= pm(p1)
                parent1 = mut(parent1);
            end
            if x <= pm(p2)
                parent2 = mut(parent2);
            end
           
            offspring(i,:) = parent1;
            offspring(i+1,:) = parent2;
        end
           parents([p1,p2], :) = [];
           pc([p1,p2]) = [];
    end
end