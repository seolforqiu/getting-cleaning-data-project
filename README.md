# getting-cleaning-data-project
## readme

## Introduction
///////////////////////////////////////////////////////////////////////

My code and data have been put into this repository. They are for the project of the course of "Getting and Cleaning Data".

## Raw data
///////////////////////////////////////////////////////////////////////

Test Set: 
The data of 561 features for different activities and different subjects are stored in the X_test.txt. 
The activity labels are in the y_test.txt file.
The test subjects label are in the subject_test.txt file.

Training Set: 
The data of 561 features for different activities and different subjects are stored in the X_train.txt. 
The activity labels are in the y_train.txt file.
The test subjects label are in the subject_train.txt file.

## Code and result dataset
///////////////////////////////////////////////////////////////////////

Please extract the zip file downloaded from the given link at course website to the main working directory.

The extracted "UCI HAR Dataset" folder should be in the same folder as the code. 
R command of "source("run_analysis.R")" can be called and the "result.txt" will be generated. The code firstly extracts the data and then builds up two data sets (trianing and testing data sets) which contains factorized subject and activity information. They are further merged with an added column to indicate each row's the train/test category. This dataset is melted and transformed to dataset2 with the average of each variable for each activity and each subject. dataset2 is stored in "result.txt".