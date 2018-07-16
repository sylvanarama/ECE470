% Feature Selection for Year Prediction in Songs from 1922 t0 2011

% Set Parameters
pop_size = 199; % population size
ep = 0.1;      % elitism percentage (percentage of fittest chromosomes to preserve)
cp = 0.93;      % crossover probability (when not using adaptive)
mp = 0.05;      % mutation probability (when not using adaptive)
k1 = 1.0;      % Adaptive crossover factor
k2 = 0.5;      % Adaptive mutation factor

len = 90;
prev_gen_result = [0, 0, 0];
delta = [1, 1, 1];
max_gen = 200;
results = zeros(max_gen, 3);

% 1. Load data: 1 million songs encoded with 90 audio features each, and
% partition into training, testing, and validation sets
%all_songs = readtable("year_prediction.csv");
%[train_data, test_data, test_labels, validation_data] = partition_data(all_songs);
[train_data, test_data, test_labels, validation_data] = partition_data(song_subset1000);
train_data = datasample(train_data, 2500);
[test_data, index] = datasample(test_data, 500);
test_labels = test_labels(index);

% 2. Generate chromosome: binary encoding representing the use or exclusion
% of each feature for classification (100 random binary strings)
%population = randi([0,1], pop_size, feature_num);
%population = zeros(pop_size, len);
n = floor((pop_size-(2*len)-1)/2);
r = randi([0,1], n, len);
population = [ones(1,len); eye(len); ~eye(len); r; ~r];
%population(pop_size/2+1:end, :) = ~population(2:pop_size/2, :);


for gen = 1:max_gen
    tic
    fprintf("Generation %d\n", gen);

    % 3. Evaluate the fitness of each chromosome for classification accuracy
    fitness = zeros(pop_size, 1);
    for i = 1:pop_size
        % find indices of selected features
        k = find(population(i,:)); 
        % create training and testing set using only seected features
        train_subset = train_data(:, [1,k+1]); 
        test_subset = test_data(:, k);
        model = fitcecoc(train_subset, 'label', 'Coding', 'onevsall', 'Learners', 'knn');
        [predicted_labels] = predict(model, test_subset); 
        fitness(i) = calc_fitness(predicted_labels, test_labels);
        %fprintf("Fitness for chromosome %d is %d\n", i, fitness(i));
    end
    
    %fprintf("Fitnesses: \n");
    %disp(fitness);
    
    % 4. Check for termination condition
    [result, terminate] = termination_condition(population, fitness, prev_gen_result, delta);
    fprintf("D = %5.2f, Mean = %1.2f, Max = %1.2f\n", result(1), result(2), result(3));
    results(gen, :) = result;
    if(terminate) 
        break;
    end
    prev_gen_result = result;
    
    % 5. Select members from the population proportionally to their fitness
        [new_pop, new_fit] = select(population, fitness, ep);

    % 6. Perform crossover on selected chromosomes
        new_pop = crossover_adaptive(new_pop, new_fit, ep, k1, k2);

    % 7. Perfrom mutation on selected chromosomes
       % new_pop = mutate(new_pop, mp, ep);
        
        population = new_pop;
        for i = 1:pop_size
            if population(i,:) == zeros(1,len)
                population(i,:) = randi([0,1],1,len);
            end
        end
        
        toc
end

% 8. Output final solution

