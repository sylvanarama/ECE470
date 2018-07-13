% Calculate fitness from predictions **UNFINISHED**

function fitness = calc_fitness(predicted_labels, test_labels)
    test_labels = table2array(test_labels);
    fitness = (predicted_labels == test_labels);
    fitness = sum(fitness);
end