% Termination operator **UNFINISHED**

function [result, terminate] = termination_condition(population, fitness, prev_gen_result, delta)
    min_diversity = 2;
    diversity = sum(pdist(population, 'hamming'));
    mean_fitness = mean(fitness);
    max_fitness = max(fitness);
    result = [diversity, mean_fitness, max_fitness];
    if((abs(result-prev_gen_result)<= delta) & (diversity <= min_diversity)) 
        terminate = true;
    end
end