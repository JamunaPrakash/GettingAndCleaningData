library(dplyr)

##Load data from the zip file...
wd <- "G:/Miscellaneous/e-Learning/Coursera/DataScience/Course3-GettingAndCleaningData/Course3Assignment"
setwd(wd)
list.files()

## Read train data...
sub_trainData <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_trainData <- read.table("./UCI HAR Dataset/train/x_train.txt")
Y_trainData <- read.table("./UCI HAR Dataset/train/y_train.txt")

## Read test data...
sub_testData <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_testData <- read.table("./UCI HAR Dataset/test/x_test.txt")
Y_testData <- read.table("./UCI HAR Dataset/test/y_test.txt")

## Read variable names...
var_names <- read.table("./UCI HAR Dataset/features.txt")

## Read activity labels...
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

## Merge the train and test datasets...
X_all <- rbind(X_trainData, X_testData)
Y_all <- rbind(Y_trainData, Y_testData)
sub_all <- rbind(sub_trainData, sub_testData)

## Grep and get only the mean and sd values for each measurement...
mu_and_sigma_only <- var_names[grep("mean\\(\\)|std\\(\\)", var_names[,2]),]
X_all <- X_all[, mu_and_sigma_only[,1]]

## Replace the numerical activity name factors to descriptive activity name factors in the Y_all dataset...
colnames(Y_all) <- "activity"
Y_all$activity <- factor(Y_all$activity, labels = as.character(activity_labels[,2]))
activity <- Y_all[,1]

## Label the X_all dataset...
colnames(X_all) <- var_names[mu_and_sigma_only[,1],2]

## Fix matching descriptive labels and combine the individual datasets into one fresh dataset
## and group activities by subject...
colnames(sub_all) <- "subject"
all <- cbind(X_all, activity, sub_all)
all_mu <- all %>% group_by(activity, subject) %>% summarize_all(funs(mean))

dim(all_mu)
## Write tidy data into a text file...
write.table(all_mu, file = "./UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)

