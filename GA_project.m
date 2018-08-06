% Feature Selection for Year Prediction in Songs from 1922 t0 2011

% Set Parameters
pop_size = 199; % population size
ep = 0.01;      % elitism percentage (percentage of fittest chromosomes to preserve)
cp = 0.93;      % crossover probability (when not using adaptive)
mp = 0.05;      % mutation probability (when not using adaptive)
k1 = 0.9;      % Adaptive crossover factor
k2 = 0.4;      % Adaptive mutation factor

len = 90;
prev_gen_result = [0, 0, 0];
delta = [1, 1, 1];
max_gen = 200;
results = zeros(max_gen, 3);

% 1. Load data: 1 million songs encoded with 90 audio features each, and
% partition into training, testing, and validation sets
%all_songs = readtable("year_prediction.csv");
data = songs1000;
[train_data, test_data, test_labels, validation_data] = partition_data(data);

% 2. Generate chromosome: binary encoding representing the use or exclusion
% of each feature for classification (100 random binary strings)
%population = randi([0,1], pop_size, feature_num);
%population = zeros(pop_size, len);
%n = floor((pop_size-(2*len)-1)/2);
n = floor((pop_size-len-1)/2);
r = randi([0,1], n, len);
%population = [ones(1,len); eye(len); ~eye(len); r; ~r];
population = [ones(1,len); eye(len); r; ~r];
%population(pop_size/2+1:end, :) = ~population(2:pop_size/2, :);


for gen = 1:max_gen
    tic
    fprintf("Generation %d\n", gen);

    % 3. Evaluate the fitness of each chromosome for classification accuracy
    fitness = zeros(pop_size, 1);
    for i = 1:pop_size
        % randomly select subset of traning and testing data (prevent
        % over-fitting)
        train_subset = datasample(train_data, 10000);
        [test_subset, index] = datasample(test_data, 3000);
        test_labels_subset = test_labels(index);
       
        % find indices of selected features
        k = find(population(i,:)); 
        
        % create training and testing set using only selected features
        train_subset = train_subset(:, [1,k+1]);
        test_subset = test_subset(:, k);
        %model = fitcecoc(train_subset, 'label', 'Coding', 'onevsall', 'Learners', 'knn');
        model = fitlm(train_subset,'purequadratic', 'ResponseVar', 'label');
        [predicted_labels] = predict(model, test_subset); 
        fitness(i) = calc_fitness(predicted_labels, test_labels_subset);
        %fprintf("Fitness for chromosome %d is %d\n", i, fitness(i));
    end
     
%     if gen == 1
%         names = string(data.Properties.VariableNames);
%         names(1) = 'All';
%         Fitness_by_Feature = table(names', fitness(1:91), 'VariableNames', {'Feature', 'Fitness'});
%         Fitness_by_Feature = sortrows(Fitness_by_Feature, 2, 'descend');
%     end
    
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

