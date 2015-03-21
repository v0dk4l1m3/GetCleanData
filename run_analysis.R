run_analysis <- function() {
  
  ## set working directory to a local directory called UCIHAR containing the unzipped data
  setwd("~/R/UCIHAR")
  
  ## the next few lines will read the required text files, some from different sub-folders
  features <- read.table("features.txt")
  setwd("~/R/UCIHAR/train")
  X_train <- read.table("X_train.txt")
  subject_train <- read.table("subject_train.txt")
  y_train <- read.table("y_train.txt")
  setwd("~/R/UCIHAR/test")
  X_test <- read.table("X_test.txt")
  subject_test <- read.table("subject_test.txt")
  y_test <- read.table("y_test.txt")
  
  ## combine all the "test" data into one data frame
  test <- cbind(subject_test,y_test,X_test)
  
  ## combine all the "train" data into one data frame
  train <- cbind(subject_train,y_train,X_train)
  
  ## combine "test" and "train" data into one data frame, assign column names to the data frame
  complete <- rbind(test,train)
  colnames(complete)[1] <- "subject"
  colnames(complete)[2] <- "activity"
  colnames(complete)[3:563] <- as.character(features[1:561,2])
  
  ## factor out only columns that contain mean and standard deviation data
  meanlist <- complete[, grepl("mean", names(complete))]
  stdlist <- complete[, grepl("std", names(complete))]
  
  ## factor out the subject and activity columns
  subjectactivity <- complete[,c(1:2)]
  
  ## combine into a single data frame containing only subject, activity, mean, and std columns
  extracted <- cbind(subjectactivity,meanlist,stdlist)
  
  ## turn the activity labels into human readable format
  extracted$activity[extracted$activity == 1] <- "WALKING"
  extracted$activity[extracted$activity == 2] <- "WALKING_UPSTAIRS"
  extracted$activity[extracted$activity == 3] <- "WALKING_DOWNSTAIRS"
  extracted$activity[extracted$activity == 4] <- "SITTING"
  extracted$activity[extracted$activity == 5] <- "STANDING"
  extracted$activity[extracted$activity == 6] <- "LAYING"
  
  ## sort the data by subject and then by activity
  sorteddata <- extracted[order(extracted$subject,extracted$activity),]
  
  ## calculate the average of each variable for each activity and each subject
  colgroup <- names(sorteddata)[1:2]
  dots <- lapply(colgroup, as.symbol)
  library(dplyr)
  finaldata <- sorteddata %>%
    group_by_(.dots=colgroup) %>%
    summarise_each(funs(mean))
  
  ## create a tidy data set in tab-delimited text format, which can then be read back in R
  setwd("~/R/UCIHAR")
  write.table(finaldata, "~/R/UCIHAR/finaldata.txt", row.name = FALSE, sep="\t")
}
