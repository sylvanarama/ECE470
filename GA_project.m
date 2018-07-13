% Feature Selection for Year Prediction in Songs from 1922 t0 2011

% Set Parameters
mp = 0.05; % mutation probability
feature_num = 90;
pop_size = 10; % dummy value --> look for good population number
prev_gen_result = [0, 0, 0];
delta = [1, 1, 1];

% 1. Load data: 1 million songs encoded with 90 audio features each, and
% partition into training, testing, and validation sets
%all_songs = readtable("year_prediction.csv");
%[train_data, test_data, test_labels, validation_data] = partition_data(all_songs);
[train_data, test_data, test_labels, validation_data] = partition_data(song_subset1000);

while(true)

    % 2. Generate chromosome: binary encoding representing the use or exclusion
    % of each feature for classification
    
    % Generate 100 random binary strings representing feature sets
    population = randi([0,1], pop_size, feature_num);

    % 3. Evaluate the fitness of each chromosome for classification accuracy
    fitness = zeros(pop_size);
    for i = 1:pop_size
        disp(i);
        % find indices of selected features
        k = find(population(i,:)); 
        % create training and testing set using only seected features
        train_features = train_data(:, [1,k+1]); 
        test_features = test_data(:, k);
        tic
        model = fitcecoc(train_features, 'label');
        toc
        tic
        [predicted_labels] = predict(model, test_data); 
        toc
        fitness(i) = calc_fitness(predicted_labels, test_labels);    
    end

    % 4. Check for termination condition
    [result, terminate] = termination_condition(population, fitness, prev_gen_result, delta);
    if(terminate) 
        break;
    end

    % 5. Select members from the population proportionally to their fitness
        new_pop = select(population, fitness);

    % 6. Perform crossover on selected chromosomes
        new_pop = crossover(new_pop);

    % 7. Perfrom mutation on selected chromosomes
        new_pop = mutate(new_pop, mp);
end

% 8. Output final solution

