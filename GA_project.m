% Feature Selection for Year Prediction in Songs from 1922 t0 2011

% Set Parameters
pop_size = 250; % population size
ep = 0.25;      % elitism percentage (percentage of fittest chromosomes to preserve)
cp = 0.98;      % crossover probability (when not using adaptive)
mp = 0.006;      % mutation probability (when not using adaptive)
k1 = 0.9;      % Adaptive crossover factor
k2 = 0.4;      % Adaptive mutation factor

len = 90;
prev_gen_result = [0, 0, 0];
delta = [1, 1, 1];
max_gen = 200;
results = zeros(max_gen, 3);

% 1. Load data: 1 million songs encoded with 90 audio features each, and
% partition into training and testing sets
    data = songs1000;
    [train_data, test_data, test_labels] = partition_data(data);

% 2. Generate chromosome: binary encoding representing the use or exclusion
% of each feature for classification (100 random binary strings)

    % OPTION 1: random initialization
    population = randi([0,1], pop_size, len);
    population(1,:) = ones(1,90);

    % OPTION 2: heuristic initialization
    %Heuristic A
    %n = floor((pop_size-(2*len)-1)/2);
    %r = randi([0,1], n, len);
    %population = [ones(1,len); eye(len); ~eye(len); r; ~r];
    % Heuristic B
    %n = floor((pop_size-len-1)/2);
    %r = randi([0,1], n, len);
    %population = [ones(1,len); eye(len); r; ~r];

    % Calculate the performance of a model trained using all the features
    % Use at the end for comparison
    best_model = fitlm(train_data,'purequadratic', 'ResponseVar', 'label');
    %[best_model, validationRMSE] = trainRegressionModel(train_subset);
    %start_fit = 1/best_model.RMSE;
    %best_fit = start_fit;
    [predicted_labels] = predict(best_model, test_data); 
    start_fit = calc_fitness(predicted_labels, test_labels);
    best_fit = start_fit;
    best_chrom = ones(1,90);

% 3. For a set number of generations, evaluate the fitness of each chromosome for classification accuracy

for gen = 1:max_gen
    tic
    fprintf("Generation %d\n", gen);
    
    % Randomly select a new subset of training and testing data 
    % --> Prevents over-fitting but intruoduces variability 
    %[train_data, test_data, test_labels] = partition_data(data);

    % 3. Evaluate the fitness of each chromosome for classification accuracy
    fitness = zeros(pop_size, 1);
    
    for i = 1:pop_size      
        % 3.1 find indices of selected features
        k = find(population(i,:)); 
        
        % 3.2 create training and testing set using only selected features
            train_subset = train_data(:, [1,k+1]);
            test_subset = test_data(:, k);
        
        % 3.3 train model using selected features and evaluate accuracy/fitness   
            % METHOD 1: classification ensemble
            %model = fitcecoc(train_subset, 'label', 'Coding', 'onevsall', 'Learners', 'knn');
            %[predicted_labels] = predict(model, test_subset); 
            %fitness(i) = calc_fitness(predicted_labels, test_labels);

            % METHOD 2: regression model
            model = fitlm(train_subset,'purequadratic', 'ResponseVar', 'label');
            [predicted_labels] = predict(model, test_subset); 
            fitness(i) = calc_fitness(predicted_labels, test_labels);
            %fitness(i) = 1/model.RMSE;

        % 3.4 store the best performing chromosome and its model
        if fitness(i) > best_fit
            best_model = model;
            best_fit = fitness(i);
            [predicted_labels] = predict(model, test_subset);
            %best_acc = calc_fitness(predicted_labels, test_labels);
            best_chrom = population(i,:);
        end
        %fprintf("Fitness for chromosome %d is %d\n", i, fitness(i));
    end
    
    % 4. Check for termination condition
    [result, terminate] = termination_condition(population, fitness, prev_gen_result, delta);
    fprintf("D = %5.2f, Mean = %1.4f, Max = %1.4f\n", result(1), result(2), result(3));
    results(gen, :) = result;
    if(terminate) 
        break;
    end
    prev_gen_result = result;
    
    % 5. Select members from the population proportionally to their fitness
        [new_pop, new_fit] = select(population, fitness, ep);

    % 6. Perform crossover on selected chromosomes
        %new_pop = crossover_adaptive(new_pop, new_fit, ep, k1, k2);
        new_pop = crossover_static(new_pop, cp,ep);

    % 7. Perfrom mutation on selected chromosomes
        new_pop = mutate(new_pop, mp, ep);
        
    %replace empty chromosomes with a random string
    population = new_pop;
    for i = 1:pop_size
        if population(i,:) == zeros(1,len)
            population(i,:) = randi([0,1],1,len);
        end
    end
        
        toc
end

% 8. Output final solution


