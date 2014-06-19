# run_analysis on UCI HAR dataset
# downloads and analyzes the data as instructed for Coursera - Gettings and Cleaning Data Project
#You should create one R script called run_analysis.R that does the following. 

#fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#if (!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")) {
#  download.file(fileURL,destfile = "getdata-projectfiles-UCI HAR Dataset")
#  }

## Manual unzip and move files into the main directory as specified by the assignment

#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 

features <- read.table("features.txt")

train <- read.table("X_train.txt")
acttrain <- read.table("y_train.txt")
subjecttrain <- read.table("subject_train.txt")

test <- read.table("X_test.txt")
acttest <- read.table("y_test.txt")
subjecttest <- read.table("subject_test.txt")

activityLabels <- read.table("activity_labels.txt")

stdList <- grep("-std()", features$V2)
meanList <- stdList -1

alldata <- rbind(cbind(acttrain, subjecttrain, train[,meanList], train[,stdList]), cbind(acttest, subjecttest, test[,meanList], test[,stdList]))

#Appropriately labels the data set with descriptive variable names. 
names(alldata) <- c("ActivityNum", "Subject", as.character(features$V2[meanList]),as.character(features$V2[stdList]) )

#Uses descriptive activity names to name the activities in the data set
for (i in 1:6) {
  alldata$ActivityLabel[alldata$ActivityNum == i] <- as.character(activityLabels$V2[i])
}

#Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
meanData <- as.data.frame(matrix(NA, nrow = 180, ncol = 68))
row = 1
for (subject in 1:30) {
  for (measure in 1:6) {
    meanData[row,1] <- subject
    meanData[row,2] <- as.character(activityLabels$V2[measure])
    meanData[row,3:68] <- colMeans(alldata[alldata$Subject == subject & alldata$ActivityNum == measure,3:68])
    row = row +1 
  }
}
names(meanData) <- c("Subject","Activity",  as.character(features$V2[meanList]),as.character(features$V2[stdList]) )
write.csv(meanData, file = "tidydata.txt")
