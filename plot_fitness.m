figure(1)
hold on
g = 40;
x = 1:g;
%plot(results(1:g,1), 'Linewidth', 2)
plot(results(1:g,2), 'Linewidth', 2)
plot(results(1:g,3), 'Linewidth', 2)
title('GA Performance over Generations')
xlabel('Generation')
ylabel('Fitness')
%legend('Diversity', 'Mean Fitness', 'Max Fitness', 'Location', 'southeast')
legend('Mean Fitness', 'Max Fitness', 'Location', 'southeast')
