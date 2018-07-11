#Download file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "C:/Users/Nana Yaa B Asamoah/Desktop/")

# Reading the train files into tables
x_train <- read.table("C:/Users/Nana Yaa B Asamoah/Desktop/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("C:/Users/Nana Yaa B Asamoah/Desktop/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("C:/Users/Nana Yaa B Asamoah/Desktop/UCI HAR Dataset/train/subject_train.txt")

# Reading the test files into tables
x_test <- read.table("C:/Users/Nana Yaa B Asamoah/Desktop/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("C:/Users/Nana Yaa B Asamoah/Desktop/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("C:/Users/Nana Yaa B Asamoah/Desktop/UCI HAR Dataset/test/subject_test.txt")

# Reading the feature into a table
features <- read.table("C:/Users/Nana Yaa B Asamoah/Desktop/UCI HAR Dataset/features.txt")

# Reading activity labels into a table
activity_labels <- read.table("C:/Users/Nana Yaa B Asamoah/Desktop/UCI HAR Dataset/activity_labels.txt")

# Assigning Column names
colnames(x_train) <- features[, 2]
colnames(y_train) <- "activity_ID"
colnames(subject_train) <- "subject_ID"

colnames(x_test) <- features[, 2]
colnames(y_test) <- "activity_ID"
colnames(subject_test) <- "subject_ID"

colnames(activity_labels) <- c("activity_ID", "subject_ID")

# Merging into one dataset
merged_train <- cbind(y_train, subject_train, x_train)
merged_test <- cbind(y_test, subject_test, x_test)
TestTrainData <- rbind(merged_train, merged_test)

#Read Column Names
colNames = colnames(TestTrainData)

#Getting  a subset of all the mean and standard deviations  and the correspondongin activityID and subjectID 
mean_and_std = (grepl("activity_ID" , colNames) | grepl("subject_ID" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames))

Mean_STD_subset <- TestTrainData[, mean_and_std == TRUE]

#Using descriptive activity names to name the activities
ActivityNames <- merge(TestTrainData, activity_labels, by = "activity_ID", all.x = TRUE)

#Making second tidy data set
Tidy_Data <- aggregate(. ~activity_ID + subject_ID.x, ActivityNames, mean)
Tidy_Data <- Tidy_Data[order(Tidy_Data$subject_ID.x, Tidy_Data$activity_ID),]

#Writing second tidy data set in txt file
write.table(Tidy_Data, "Tidy_Data.txt", row.name=FALSE)
