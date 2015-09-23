# CourseProject-GCD_Coursera
Contains R code, codebook, and readme for the Getting and Cleaning Data Coursera project

#OUTLINE OF ANALYTICAL AND PROCESSING STEPS USED IN RUN_ANALYSIS.R

- requires the reshape2 library to melt and dcast the data

1) downloads and unpacks data into local directories
2) Reads in proper metric names for later assignment to data
3) reads in and extracts just the activity labels
4) reads test data into R data frame ; X is metric data ; Y is activity category ; subject is subject ID
5) gives each column a descriptive name
6) binds all test data together by column
7) reads in training data into R data frames
8) gives each column a descriptive name
9) binds all training data together by column
10) binds the training and test data by rows
11) extracts just mean & SD by looking for the words "mean" or "sd" in the header names
12) melts the data with subject and activity still intact - ends up tall and skinny
13) recasts the melted data to a new df with the mean function applied
14) converts the numeric activity codes to descriptive names
15) Writes out final dataset 