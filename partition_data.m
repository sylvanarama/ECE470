% Partition data into training, testing, and validation sets 

function [train, test, test_labels] = partition_data(features)
    
%     % Randomly permute the dataset indices
%     num_samples = size(features, 1);
%     perm = randperm(num_samples);
%     
% 
%     % Split the dataset into 70% training and 30% validation
%     split = floor(num_samples * 0.7);
%     train_indices = perm(1:split);
%     validation_indices = perm(split + 1:end);
% 
%     % Split the training data into 70% training and 30% testing
%     split = floor(length(train_indices) * 0.7);
%     test_indices = train_indices(split+1:end);
%     train_indices = train_indices(1:split);
%     
%     % Partition the dataset 
%     train = features(train_indices, :);
%     test = features(test_indices, 2:end);
%     test_labels = table2array(features(test_indices, 1));
%     validate = features(validation_indices, :);
    
year = 1922;
train = table();
test = table();
test_labels = [];
n = 500;
split = floor(n*0.7);

for i = 1:90
    songs = features(features.label == year, :);
    if size(songs,1) >= n
        songs = datasample(songs, n);
        train = [train; songs(1:split, :)];
        test = [test; songs(split+1:end, 2:end)];
        test_labels = [test_labels; table2array(songs(split+1:end, 1))];
        %songs1000 = [songs1000; songs];
    end
    year = year+1;
end

end