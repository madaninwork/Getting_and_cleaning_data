


#loading packages

library(plyr)
library(data.table)
library(tidyr)

## Download and unzip dataset to use them
if (!file.exists("./UCI HAR Dataset")) {
  fileUrl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, "Dataset.zip")
  unzip("Dataset.zip") 
}

#Load the data files
data_test_X <- read.table("./UCI HAR Dataset/test/X_test.txt")
data_train_X <- read.table("./UCI HAR Dataset/train/X_train.txt")

#Load the activity files
data_test_Y <- read.table("./UCI HAR Dataset/test/Y_test.txt")
data_train_Y <- read.table("./UCI HAR Dataset/train/Y_train.txt")

#Load the subject files
data_test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
data_train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#1.Merge the test and train sets to create one data set

#For X
data_all_X <- rbind(data_train_X, data_test_X)

#For Y
data_all_Y <- rbind(data_train_Y, data_test_Y)

#For subject
data_all_subject <- rbind(data_train_subject, data_test_subject)

#2. Extract only the measurements on the mean and standard deviation for each measurement.
#Load features.txt file
data_features <- read.table("./UCI HAR Dataset/features.txt")

#Get list of mean and std columns
mean_std <- grep("-(mean|std)\\(\\)", data_features[, 2])

#Subset the mean and std columns
data_all_X <- data_all_X[, mean_std]

#Set column names
names(data_all_X) <- data_features[mean_std, 2]

#3. Use descriptive activity names to name the activities in the data set
#Load activity_labels.txt file
data_activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

#Update activity name
data_all_Y[, 1] <- data_activities[data_all_Y[, 1], 2]

names(data_all_Y) <- "activity"

#4. Giv label to data set

names(data_all_subject) <- "subject"

# Binding data sets
all_data <- cbind(data_all_X, data_all_Y, data_all_subject)

#Updating labels
names(all_data)<-gsub("std()", "SD", names(all_data))
names(all_data)<-gsub("mean()", "MEAN", names(all_data))
names(all_data)<-gsub("^t", "time", names(all_data))
names(all_data)<-gsub("^f", "frequency", names(all_data))
names(all_data)<-gsub("Acc", "Accelerometer", names(all_data))
names(all_data)<-gsub("Gyro", "Gyroscope", names(all_data))
names(all_data)<-gsub("Mag", "Magnitude", names(all_data))
names(all_data)<-gsub("BodyBody", "Body", names(all_data))

#5. Create a second, independent tidy data set with the average of each variable for each activity and each subject
avg <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

#Create tidy data set
write.table(avg, "tidy_data.txt", row.name=FALSE)
