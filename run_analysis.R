setwd("X:/Users/Omar.AbdAllah-PC/Coursera/2Scraping data/Assignment")

#Get all file names
test_names <- list.files("UCI HAR Dataset/test", pattern="*.txt", full.names=TRUE)
test_signals_names <- list.files("UCI HAR Dataset/test/Inertial Signals", pattern="*.txt", full.names=TRUE)
train_names <- list.files("UCI HAR Dataset/train", pattern="*.txt", full.names=TRUE)
train_signals_names <- list.files("UCI HAR Dataset/train/Inertial Signals", pattern="*.txt", full.names=TRUE)

#Read all files
test <- lapply(test_names, read.csv, header = FALSE, stringsAsFactors = FALSE)
test_signals <- lapply(test_signals_names, read.csv, header = FALSE, stringsAsFactors = FALSE)
train <- lapply(train_names, read.csv, header = FALSE, stringsAsFactors = FALSE)
train_signals <- lapply(train_signals_names, read.csv, header = FALSE, stringsAsFactors = FALSE)

#Merge files; test and train data sets
merged <- mapply(rbind, test, train)
merged_signals <- mapply(rbind, test_signals, train_signals)

#strsplit features and inertial signals (these may take a while...)
merged_signals2 <- lapply(merged_signals, function(x) data.frame(do.call('rbind', strsplit(x, "\\s+"))))
merged[[2]] <- data.frame(do.call('rbind', strsplit(merged[[2]], "\\s+")))

#Descriptive names
names(merged) <- c("Subject", "Feature", "Activity")

#Remove the first empty column from features and intertial signals
merged$Feature <- merged$Feature[2:562]
merged_signals2 <- lapply(merged_signals2, function(x) x[,2:129])

#Functions to convert character/factor to double
asDouble <- function(x) as.double(as.character(x))
#factorsDouble <- function(d) modifyList(d, lapply(d[, sapply(d, is.factor)], asDouble))
allDouble <- function(d) modifyList(d, lapply(d, asDouble))

#Make features and inertial signals to double
merged$Feature <- allDouble(merged$Feature)
merged_signals3 <- lapply(merged_signals2, allDouble)
#merged_signals3 <- lapply(merged_signals3, function(x) x[,2:129])

#Give descriptive names to Inertial Signal data set
inertialSignals <- gsub("_test.txt", "", list.files("test/Inertial Signals", pattern="*.txt", full.names=FALSE))
names(merged_signals3) <- inertialSignals
for(i in 1:9) {
     names(merged_signals3[[i]]) <- paste("X", 1:128, sep = "")
}

#Activity labels
activityLabels <- unlist(read.csv("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE, header = FALSE, sep = "\n"), use.names = FALSE)
merged$Activity <- activityLabels[merged$Activity]

#Descriptive variable names for features
descriptiveNames <- unlist(read.csv("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE, header = FALSE, sep = "\n"))
names(merged$Feature) <- descriptiveNames

#Combine both features and inertial signals
merged2 <- cbind(merged, merged_signals3)
#Make it a data frame
merged2 <- as.data.frame(merged)

#Mean and standard deviation for each measurement
library(dplyr)
dt1 <- rbind (merged2 %>% summarise_each(funs(mean)),
              merged2 %>% summarise_each(funs(sd)) )
row.names(dt1) <- c("Mean", "Std Deviation")

#dt1_inertialSignals <- rbind (merged_signals3 %>% summarise_each(funs(mean)),
#              merged_signals3 %>% summarise_each(funs(sd)) )
#row.names(dt1_inertialSignals) <- c("Mean", "Std Deviation")

#More clear and nice merged_signal3 Mean and Std Deviation tables with sapply
merged_signals_mean <- sapply(merged_signals3, colMeans)
merged_signals_sd <- sapply(merged_signals3, apply, 2, sd)

#Second data set: avg of each var for each activity & each subject
dt2 <- merged2 %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))

#Write the second tidy data set
write.table(dt2, row.names = FALSE, file = "Tidy Data Set.txt")
