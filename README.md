# ECE470
Use genetic algorithms in MATLAB to select features to classify the year a song was released. 

The dataset used can be found at https://www.kaggle.com/uciml/msd-audio-features/version/1

To run GA_project.m:

1. load "songs1000.mat"
2. run GA_project, approximately 2:21 minutes, using default parameters
    * to decrease runtime: 
	  1. set pop_size = 100
	  2. in "partition_data" set n = 500
3. in "plot_fitness" set g = # generations run in "GA_project"
4. run "plot_fitness"

