% Calculate fitness from predictions **UNFINISHED**

function fitness = calc_fitness(labels, post_prob, test_labels)
    fitness = sum(labels & test_labels);
end