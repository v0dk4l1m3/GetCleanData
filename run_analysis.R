run_analysis <- function() {
  setwd("~/R/UCIHAR")
  features <- read.table("features.txt")
  setwd("~/R/UCIHAR/train")
  X_train <- read.table("X_train.txt")
  subject_train <- read.table("subject_train.txt")
  y_train <- read.table("y_train.txt")
  setwd("~/R/UCIHAR/test")
  X_test <- read.table("X_test.txt")
  subject_test <- read.table("subject_test.txt")
  y_test <- read.table("y_test.txt")
  test <- cbind(subject_test,y_test,X_test)
  train <- cbind(subject_train,y_train,X_train)
  complete <- rbind(test,train)
  colnames(complete)[1] <- "subject"
  colnames(complete)[2] <- "activity"
  colnames(complete)[3:563] <- as.character(features[1:561,2])
  meanlist <- complete[, grepl("mean", names(complete))]
  stdlist <- complete[, grepl("std", names(complete))]
  subjectactivity <- complete[,c(1:2)]
  extracted <- cbind(subjectactivity,meanlist,stdlist)
  extracted$activity[extracted$activity == 1] <- "WALKING"
  extracted$activity[extracted$activity == 2] <- "WALKING_UPSTAIRS"
  extracted$activity[extracted$activity == 3] <- "WALKING_DOWNSTAIRS"
  extracted$activity[extracted$activity == 4] <- "SITTING"
  extracted$activity[extracted$activity == 5] <- "STANDING"
  extracted$activity[extracted$activity == 6] <- "LAYING"
  sorteddata <- extracted[order(extracted$subject,extracted$activity),]
  colgroup <- names(sorteddata)[1:2]
  dots <- lapply(colgroup, as.symbol)
  library(dplyr)
  finaldata <- sorteddata %>%
    group_by_(.dots=colgroup) %>%
    summarise_each(funs(mean))
  setwd("~/R/UCIHAR")
  write.table(finaldata, "C:/Users/mng/Documents/R/UCIHAR/finaldata.txt", row.name = FALSE, sep=",")
}
