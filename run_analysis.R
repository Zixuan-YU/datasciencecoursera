## The data linked to from the course website represent data collected from the 
## accelerometers from the Samsung Galaxy S smartphone.  
## A full description is available at the site where the data was obtained:

## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## Here are the data for the project:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

## You should create one R script called run_analysis.R that does the following. 

## 1.Merges the training and the test sets to create one data set.

## 2.Extracts only the measurements on the mean and standard deviation for each measurement. 

## 3.Uses descriptive activity names to name the activities in the data set

## 4.Appropriately labels the data set with descriptive variable names. 

## 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Good luck!

## Read the downloaded data
library(tidyverse)
setwd("C:/REPO/datasciencecoursera/Getting_and_Cleaning_Data/UCIData")

# Read the Activity files
dataActivityTest  <- read.table("test/Y_test.txt" ,header = FALSE)
dataActivityTrain <- read.table("train/Y_train.txt",header = FALSE)

# Read the Subject files
dataSubjectTrain <- read.table("train/subject_train.txt",header = FALSE)
dataSubjectTest  <- read.table("test/subject_test.txt",header = FALSE)

#Read Fearures files
dataFeaturesTest  <- read.table("test/X_test.txt" ,header = FALSE)
dataFeaturesTrain <- read.table("train/X_train.txt",header = FALSE)


#Explore the data
str(dataFeaturesTrain)
str(dataFeaturesTest)

## STEP 1
## Merges the training and the test sets to create one data set
## 1).Merge test data and train data by rows
Subject <- rbind(dataSubjectTrain, dataSubjectTest)
Activity<- rbind(dataActivityTrain, dataActivityTest)
Features<- rbind(dataFeaturesTrain, dataFeaturesTest)

## 2).set names to variables  
names(Subject)<-c("subject")
names(Activity)<- c("activity")
FeaturesNames <- read.table("features.txt",head=FALSE)
names(Features)<- FeaturesNames$V2
## 3).Merge all columns 
dat <- cbind(Subject,Activity)
Data <- cbind(Features,dat)

## STEP 2
## Extracts only the measurements on the mean and standard deviation for each measurement
## Use Regular expression to find column names contain "mean" or "std"
subdataFeaturesNames<-FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]
table(names(Data) %in% subdataFeaturesNames) ## How many columns are mean and sd 
# 66 TRUE

sub1 <- Data[,562:563]
names(sub1) = c("Subject", "activity")
data_sub <- cbind(sub1,Data[,names(Data) %in% subdataFeaturesNames])
str(data_sub)

## STEP 3
## Uses descriptive activity names to name the activities in the data set
## Read lables from file
activityLabels <- read.table("activity_labels.txt",header = FALSE)
## facorize Variale activity in the data frame Data using descriptive activity names
fac <- data_sub$activity %>% factor(levels = 1:6, labels = activityLabels$V2)
data_sub$activity <- fac  

## STEP 4
# Appropriately labels the data set with descriptive variable names
## ref:https://r4ds.had.co.nz/strings.html
names(data_sub)<-gsub("^t", "time", names(data_sub))
names(data_sub)<-gsub("^f", "frequency", names(data_sub))
names(data_sub)<-gsub("Acc", "Accelerometer", names(data_sub))
names(data_sub)<-gsub("Gyro", "Gyroscope", names(data_sub))
names(data_sub)<-gsub("Mag", "Magnitude", names(data_sub))
names(data_sub)<-gsub("BodyBody", "Body", names(data_sub))
names(data_sub)<-gsub("^t", "time", names(data_sub))
names(data_sub)<-gsub("\\()","",names(data_sub))

## STEP 5
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Data_avg<-aggregate(. ~Subject + activity, data_sub, mean)
Data_avg<-Data_avg[order(Data_avg$subject,Data_avg$activity),]
write.table(Data_avg, file = "tidydata.txt",row.name=FALSE)
