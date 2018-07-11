% Partition data into testing and training sets **UNFINISHED**

function [train, test, test_labels] = partition_data(features)
    train = features(1:100, :);
    test = features(101:200, 2:end);
    test_labels = features(101:200, 1);
end