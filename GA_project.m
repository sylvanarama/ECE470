% Feature Selection for Year Prediction in Songs from 1922 t0 2011
% 1. Load data: 1 million songs encoded with 90 audio features each
data = readtable("year_prediction.csv");
feature_num = 90;

while(true)

    % 2. Generate chromosome: binary encoding representing the use or exclusion
    % of each feature for classification
    pop_size = 100; % dummy value --> look for good population number
    population = randi(1, pop_size, feature_num+1);
    population(1, :) = 1; % always keep label

    % 3. Evaluate the fitness of each chromosome for classification accuracy
    fitness = zeros(pop_size);
    for i = 1:pop_size
        features = data(:, population(i,:));
        [train, test, test_labels] = partition_data(features);
        model = fitceoc(features, label);
        [label,NegLoss,PBScore,Posterior] = predict(model, test_labels); 
        fitness(i) = calc_fitness(label, Posterior, test_labels);    
    end

    % 4. Check for termination condition
    if(termination_condition(population) == true) 
        break;
    end

    % 5. Select members from the population proportionally to their fitness
        new_pop = select(population, fitness);

    % 6. Perform crossover on selected chromosomes
        new_pop = crossover(new_pop);

    % 7. Perfrom mutation on selected chromosomes
        new_pop = mutate(new_pop);
end

% 8. Output final solution

