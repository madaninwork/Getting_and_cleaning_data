Getting-and-Cleaning-Data

"run_analysis.R" merges the training and the test sets to create one data set,
extracts only the measurements on the mean and standard deviation for each measurement
and then uses descriptive activity names to name the activities in the data set. 
It appropriately labels the data set with descriptive activity names and creates a second, 
independent tidy data set with the average of each variable for each activity and each subject.
The code is commented properly and understandable.

Your need to have"UCI HAR Dataset" in your working directory. data.table and
reshape2 package will be installed if it is not installed previously.

For test data, activity file and features are loaded to get activity labels and features.
Use greol to extract mean and standard deviation features. Assign every data of X_test with column name.
Extract mean and standard deviation of each column names and assign column names and then bind data.

Do the same for train data.

At last, merge the training and the test sets to create one data set. 
Then, create independent tidy data set with average of each variable for each activity and each subject.
