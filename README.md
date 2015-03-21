# GetCleanData
## Coursera Getting and Cleaning Data Course Project

The purpose of the course project is to create an R function that tidies up the data collected from the accelerometers from different subjects' Samsung Galaxy S smartphones.  

To run the script, first download and extract the zip file into a local folder ~/R/UCIHAR from the following address:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Fork the code into the same folder, then do the following on R-Studio:

setwd("~/R/UCIHAR")   
source("run_analysis.R")   
run_analysis()   
finaldata <- read.delim("finaldata.txt", header=TRUE)

The script will process the data into a tab-delimited text file, which can then be read back into R using read.delim function
