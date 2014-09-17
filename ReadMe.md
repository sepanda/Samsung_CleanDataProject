---
title: "README"
output: html_document
---

## The data for this script
The data that this script proccesses can be found 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The script runs upon the data contained within the archive linked to above.


## Where to put this script
The script run_analysis.R should be contained in folder which contains the "USI HAR Dataset" folder.


## What does this script do?
The run_analysis.R performs the folling tasks:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## The result of running the script
After running the script results in the following named data sets to be created in the global environment

mergedData              Size: 10299 observations of 564 variables
extractedDataMeanStd    Size: 10299 observations of 66 variables

and

tidySummaryData         Size: 180 observations of 68 variables.

it is the tidySummaryData which makes up the data in tidySummaryData.txt

To find information concerning the variables in tidySummaryData consult the CodeBook.

## about tidySummaryData.txt
The data has been written to a text file from an x64 bit Windows 7 machine using the following code

write.table(tidySummaryData,file="./tidySummaryData.txt",row.names=FALSE)

One can view the data using the commands
data <- read.table(./tidySummaryData.txt, header = TRUE) 
View(data)

## Note on tidy data
The resulting data set tidySummaryData, is a tidy data set as
1. Each variable forms a column.
2. Each observation forms a row.

This is based on the definition of tidy data according to Hadley Wickham which can be grabbed at

http://vita.had.co.nz/papers/tidy-data.pdf

