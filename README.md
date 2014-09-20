Course Project for Getting and Cleaning Data 
=========================================

This repo contains the code for performing my analysis for the Getting and Cleaning Data Course Project and a code book

This readme file explains my script: 

The task was to: 
create one R script called run_analysis.R that does the following: 
1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement. 
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names. 
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


My Script does the following: 

1. As a first step my script loads all the files needed in R with a read.table code
2. Then it merges the test and the training sets into tree complete tables --> <b>TASK 1)</b>
3. Then it exchanges the labes for the activities in the Y table with the real activitynames --> TASK 3)
4. It gives the columns of the X file the names stores in the features text file --> TASK 4)
5. Then it will correct the mistakes in the feature names, namely "bodybody" instead of just one "body"
6. Then it searches for those columns that contain mean or the standard deviation(std)
7. It will create a smaller X that only contains the columns with mean and std identified in the step above --> TASK 2)
6. After that, it will merge together the subjects and activities with the obervations stored in the X file, and give them the column names: "subject" and "activities"
7. For the following steps it loads the reshape2 package in R
8. It melts all observations except of subject and activities
9. It splits the Meltet file by subject, so that we have 30 tables for each subject
10. It melts down the observations and returns the mean for each activity in each subject table --> TASK 5)
11. Thean it writes the table of step 10. that it sortet by subject and gives the mean observations for every activity in a text file



