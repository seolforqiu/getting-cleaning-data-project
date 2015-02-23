library(reshape2)
library(Hmisc)
library(plyr)
library(dplyr)

## import data.frames to build the train and test data sets
## setwd("./Google Drive/Course/Data Science/GetClnData")
train <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("./UCI HAR Dataset/train/y_train.txt")
test <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("./UCI HAR Dataset/test/y_test.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

## extract information of subjects for train and test sets
subtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subtest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

## introduce the column names for the feature variables
colnames(train) <- features$V2
colnames(test) <- features$V2

## row indices containing mean() or std() in features
indices <- c(1:6,41:46, 81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,
             345:350, 424:429, 503:504, 516:517, 529:530, 542:543)
             
## use indices to select the columns with mean() or std() and use them to build two new datasets as
##  trainselected and test selected          
selectedfeatures <- features[indices,]
selectedfeatures <- as.vector(selectedfeatures$V2)
trainselected <- train[,selectedfeatures]
testselected <- test[,selectedfeatures]

## bind the subject and activity info to the data.frame as new column to the left
trainselected <- cbind(train_y, trainselected)
testselected <- cbind(test_y, testselected)

## use descriptive names for marking activities
level <- c("WALKING","WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
trainselected$V1 <- factor(trainselected$V1, 1:6, level)
testselected$V1 <- factor(testselected$V1, 1:6, level)

## change the column name of data.frame
names(trainselected)[1]<-paste("activity")
names(testselected)[1]<-paste("activity")

## add subject info as a new column on the left
trainselected <- cbind(subtrain, trainselected)
testselected <- cbind(subtest, testselected)

## change the newly added column name to subject
names(trainselected)[1]<-paste("subject")
names(testselected)[1]<-paste("subject")

## create the 1st dataset
trainselected$dataset <- 0 ## 0 as train set
testselected$dataset <- 1 ## 1 as test set
dataset <- rbind(trainselected,testselected)
dataset$dataset <- factor(dataset$dataset, c(0,1), c("train","test"))

## melt the dataset and use subject and activity as id's
Molten <- melt(dataset, id = c("subject", "activity"), measure.vars=selectedfeatures)

## create the second dataset to get the mean value for each activity and subject
dataset2 <- dcast(Molten,subject+activity ~ variable, mean)

## write the new dataset to the new file result.txt
write.table(dataset2, file="result.txt")