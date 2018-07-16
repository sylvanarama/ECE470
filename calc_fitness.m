% Calculate fitness from predictions

function fitness = calc_fitness(predicted_labels, test_labels)
    fitness =(abs(predicted_labels - test_labels)).^-1;
    fitness(fitness == Inf) = 1;
    fitness = sum(fitness)/length(test_labels);
end