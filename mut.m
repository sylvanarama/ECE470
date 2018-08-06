function result = mut(input)
    result = zeros(size(input));
    for j = 1:length(input)
        x = rand();
        if x <= 0.05
            result(j) = ~input(j);
        end
    end
end
        
            