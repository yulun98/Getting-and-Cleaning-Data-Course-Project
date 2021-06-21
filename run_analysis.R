library(dplyr)
##download file
filename <- "Coursera_DS3_Final.zip"

#check if archieve exist
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

#check if folder exist
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

## Reading file and renaming columns for merging
#features
features <- read.table('./UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')
feature_colname <- c("n", "functions")
colnames(features) <- feature_colname
#activities
activities <- read.table('UCI HAR Dataset/activity_labels.txt', header = FALSE, sep = ' ')
colnames(activities) <- c("code","activity")
activities
#subject_test
subject_test <- read.table('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep=' ')
colnames(subject_test) <- c("subject")
head(subject_test)
#subject_train
subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt', header = FALSE, sep=' ')
colnames(subject_train) <- c("subject")
head(subject_train)
#x_test
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
colnames(x_test) <- c(features$functions)
head(x_test)
#x_train
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
colnames(x_train) <- c(features$functions)
head(x_train)
#y_test
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
colnames(y_test) <- c("code")
head(y_test)
#y_train
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
colnames(y_train) <- c("code")
head(y_train)


## 1. Merges the training and the test sets to create one data set.

x_compound <- rbind(x_test, x_train)
y_compound <- rbind(y_test, y_train)
subject_compound <- rbind(subject_test, subject_train)
dim(x_compound)
dim(y_compound)
dim(subject_compound)
data_merged <- cbind(subject_compound, x_compound, y_compound)
dim(data_merged)
head(data_merged)

 ## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

mean_std_Data <- grep("mean\\(\\)|std\\(\\)", features[,2])


#get only variables with mean and std
x_compound <- x_compound[,mean_std_Data] 
dim(x_compound)

## 3. Uses descriptive activity names to name the activities in the data set.

head(activities)
head(y_compound)
y_compound[,1]<- activities[y_compound[,1],2] 
head(y_compound) 

## 4. Appropriately labels the data set with descriptive variable names. 

final_data_merged <- cbind(x_compound, y_compound, subject_compound)
dim(final_data_merged)
names(final_data_merged)

#Regex
names(final_data_merged) <- gsub("[(][)]", "", names(final_data_merged))
names(final_data_merged) <- gsub("^t", "TimeDomain_", names(final_data_merged))
names(final_data_merged) <- gsub("^f", "FrequencyDomain_", names(final_data_merged))
names(final_data_merged) <- gsub("Acc", "Accelerometer", names(final_data_merged))
names(final_data_merged) <- gsub("Gyro", "Gyroscope", names(final_data_merged))
names(final_data_merged) <- gsub("Mag", "Magnitude", names(final_data_merged))
names(final_data_merged) <- gsub("-mean-", "_Mean_", names(final_data_merged))
names(final_data_merged) <- gsub("-std-", "_StandardDeviation_", names(final_data_merged))
names(final_data_merged) <- gsub("-", "_", names(final_data_merged))
names(final_data_merged) <- gsub('Freq\\.',"Frequency.",names(final_data_merged))
names(final_data_merged) <- gsub('Freq$',"Frequency",names(final_data_merged))
names(final_data_merged) <- sub("code", "Activity", names(final_data_merged))
names(final_data_merged) <- sub("subject", "Subject", names(final_data_merged))
names(final_data_merged)


## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Final_aggregate<-aggregate(. ~Subject + Activity, final_data_merged, mean)
Final_aggregate<-Final_aggregate[order(Final_aggregate$Subject,Final_aggregate$Activity),]
write.table(Final_aggregate, file = "tidydata.txt",row.name=FALSE)
Final_aggregate
