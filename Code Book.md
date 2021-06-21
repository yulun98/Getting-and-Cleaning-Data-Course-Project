features <- features.txt : 561 rows, 2 columns
activities <- activity_labels.txt : 6 rows, 2 columns
subject_test <- test/subject_test.txt : 2947 rows, 1 column
subject_train <- test/subject_train.txt : 7352 rows, 1 column
x_test <- test/X_test.txt : 2947 rows, 561 columns
x_train <- test/X_train.txt : 7352 rows, 561 columns
y_test <- test/y_test.txt : 2947 rows, 1 columns
y_train <- test/y_train.txt : 7352 rows, 1 columns


Merges the training and the test sets to create one data set
x_compound (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function
y_compound (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function
subject_compound (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function
data_merged (10299 rows, 563 column) is created by merging Subject, Y and X using cbind() function

Extracts only the measurements on the mean and standard deviation for each measurement
mean_std_Data  is created by subsetting Merged_Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

Appropriately labels the data set with descriptive variable names
code column in TidyData renamed into activities
All () are replaced with ""
All start with character t in column’s name replaced by TimeDomain_
All start with character f in column’s name replaced by FrequencyDomain_
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope
All Mag in column’s name replaced by Magnitude
All -mean- in column's name replaced by _Mean_
All -std- in column's name replaced by _StandardDeviaion_
All code in column's name replaced by Activity
All subject in column's name replaced by Subject

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
Final_aggregate (180 rows, 68 columns) is created by sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
Export Final_aggregate into tidydata.txt file.
