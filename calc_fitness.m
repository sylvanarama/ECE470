% Calculate fitness from predictions

function fitness = calc_fitness(predicted_labels, test_labels)
%     fitness =(abs(predicted_labels - test_labels)).^-1;
%     fitness(fitness == Inf) = 1;
%     fitness(fitness > 1) = 1;
%     fitness = sum(fitness)/length(test_labels);
    year_spread = max(test_labels)-min(test_labels);
    accuracy = 1-(abs(test_labels-predicted_labels)./year_spread);
    accuracy(accuracy < 0) = 0;
    fitness = mean(accuracy);
end