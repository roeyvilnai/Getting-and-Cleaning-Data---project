#1 - Merge the training and the test sets to create one data set.

#read the data sets
train_data <- read.table("train/X_train.txt")
test_data <- read.table("test/X_test.txt")

train_labels <- read.table("train/y_train.txt")
test_labels <- read.table("test/y_test.txt")

train_subjects <- read.table("train/subject_train.txt")
test_subjects <- read.table("test/subject_test.txt")

#merge train and test data sets
full_data <- rbind(train_data, test_data)
full_labels <- rbind(train_labels, test_labels)
full_subjects <- rbind(train_subjects, test_subjects)

#2 - Extract only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("features.txt")
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

full_data <- full_data[, mean_and_std_features]

#3 - Use descriptive activity names to name the activities in the data set
activities <- read.table("activity_labels.txt")
labels <- activities[full_labels[, 1], 2]


#4 - Appropriately labels the data set with descriptive variable names. 
names(full_data) <- features[mean_and_std_features, 2]
names(labels) <- "activity"
names(full_subjects) <- "subject"

complete_data <- cbind(full_data, full_subjects, labels)
tidy_data <- aggregate(complete_data[,1:66], list(complete_data$labels, complete_data$subject), mean)
names(tidy_data)[1:2] <- c("activity", "subject")
write.table(tidy_data, "tidy.txt", row.names = FALSE, quote = FALSE)