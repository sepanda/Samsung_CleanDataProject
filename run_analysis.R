## This R script is intended as the submission for 
## Project 1: Getting and Cleaning Data.
##
## The script assumes that the Samsung data 
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
## 
## has been unzipped and is available within the same directory as this script.
##
## The aim is to 
## 1. merge training and test data sets together
## 2. extract only the measurements that concern the mean & standard dev of each
##    measurement.
## 3. use descriptive activity names.
## 4. use appropriate labels for the variable names in the data set.
## 5. produce a second tidy data set with the average of each variable [means/std]
##    for each activity and each subject.
##
## Concerning the scipt if saveTidySummary = TRUE 
## the tidySummaryData will be saved to a text file in the current directory


saveTidySummary <- FALSE


library(dplyr)

## =============================================================================
## Read in the data
## =============================================================================

### The test data:
X_test <- read.table(".//UCI HAR Dataset//test//X_test.txt",
                     sep="",
                     colClasses="numeric",
                     header=FALSE)

y_test <- read.table(".//UCI HAR Dataset//test//Y_test.txt",
                     sep="",
                     colClasses="numeric",
                     header=FALSE, 
                     col.names="activity")

subject_test <- read.table(".//UCI HAR Dataset//test//subject_test.txt",
                           sep="",
                           colClasses="numeric",
                           header=FALSE, 
                           col.names="subjectID")

### Combine the test data variables into one data frame
testData <- data.frame(X_test,subject_test,y_test)
testData <- tbl_df(testData)

### remove the unnecessary data from memory
rm(X_test,y_test,subject_test)

### Add another column to the data indicating the subject type 
### [takes value: test or train]
testData <- mutate(testData,subjectType="test")


### The train data:
X_train <- read.table(".//UCI HAR Dataset//train//X_train.txt",
                      sep="",
                      colClasses="numeric",
                      header=FALSE)

y_train <- read.table(".//UCI HAR Dataset//train//Y_train.txt",
                      sep="",
                      colClasses="numeric",
                      header=FALSE, 
                      col.names="activity")

subject_train <- read.table(".//UCI HAR Dataset//train//subject_train.txt",
                            sep="",
                            colClasses="numeric",
                            header=FALSE, 
                            col.names="subjectID")

### Combine the train data variables into one data frame
trainData <- data.frame(X_train,subject_train,y_train)
trainData <- tbl_df(trainData)

### remove the unnecessary data from memory
rm(X_train,y_train,subject_train)

### Add another column to the data indicating the subject type 
### [takes value: test or train]
trainData <- mutate(trainData,subjectType="train")


## =============================================================================
## Stitch the test/train data together
## =============================================================================

### Use rbind to make one long tbl_df from testData and trainData
mergedData <- rbind(testData,trainData)
rm(testData,trainData)


## =============================================================================
## Extract mean and standard deviation for each measurement.
## =============================================================================

### Note: The cols V1-V561 extracted from the X_test.txt & X_train files are 
### documented in the file "./Data/UCI HAR Dataset/features.txt". 
### Reading in this data the mean/std variables will be identified.

rawVarNames <- read.table(".//UCI HAR Dataset//features.txt",
                          header=FALSE,
                          stringsAsFactors=FALSE,
                          #NULL col1 as we don't need the first column
                          colClasses=c("NULL","character"), 
                          sep=""
                          )

### Note: rawVarNames which contain the string "mean()" or "std()" using grep. 
### Including the brackets removes the occurrence of items like meanFreq.

varWith_mean_Index <- grep("mean\\(\\)",x=rawVarNames[,]) # loc of mean vars
varWith_std_Index <- grep("std\\(\\)",x=rawVarNames[,])   # loc of std vars


### Extract the relevant variables of interest from the mergedData

### The vector of column numbers with variables related to the mean and std
meanstdCols <- sort( c(varWith_mean_Index,varWith_std_Index) )

### Extract mean and standard deviation variables
extractedDataMeanStd <- select(mergedData,meanstdCols) 


## =============================================================================
## Uses descriptive activity names to name the activities in the data set.
## =============================================================================

### The activities are currently stored as numbers 1,2,3,4,5,6. 
### From the data set we have
###
### > 1 WALKING  
### > 2 WALKING_UPSTAIRS  
### > 3 WALKING_DOWNSTAIRS  
### > 4 SITTING  
### > 5 STANDING  
### > 6 LAYING  

## convert the column to a factor
mergedData$activity <- factor(mergedData$activity)

## add the descriptive levels
levels(mergedData$activity) <- c("WALKING",
                                 "WALKING_UPSTAIRS",
                                 "WALKING_DOWNSTAIRS",
                                 "SITTING",
                                 "STANDING",
                                 "LAYING")


## =============================================================================
## Appropriately label the data set with descriptive variable names. 
## =============================================================================

### The variable names found in the features.txt data file is full of illegal 
### characters and nondescript words. In order to use descriptive activity names 
### for the means and standard deviations, gsub and regex can be used to clean 
### up the var names.

### The variable names to be assigned to the data set and edited
varNamesMeanStd <- rawVarNames[meanstdCols,]

### removing all brackets and replace hyphens with underscores
varNamesMeanStd <- gsub(pattern="\\(\\)",replacement="",x=varNamesMeanStd)
varNamesMeanStd <- gsub(pattern="-",replacement="_",x=varNamesMeanStd)

### There is a little misnaming in the data set where there is an extra Body 
### in the varname eg fBodyBodyAccJerkMag_std, here the extra Body substring 
## is removed.
varNamesMeanStd <- gsub(pattern="BodyBody",replacement="Body",x=varNamesMeanStd)

### Now add the cleaned var names to the data set
names(extractedDataMeanStd) <- varNamesMeanStd

### Now remove all the unnecessary values and data concerned with var names
rm(rawVarNames,
   meanstdCols,
   varNamesMeanStd,
   varWith_mean_Index,
   varWith_std_Index)


## =============================================================================
## Create a second, independent tidy data set with the average of each variable 
## for each activity and each subject.
## =============================================================================

### The second tidy data set will be called tidySummaryData

tidySummaryData <- extractedDataMeanStd # based on extractedDataMeanStd

## Add subjectID column and activity column
tidySummaryData <- mutate(tidySummaryData,subjectID=mergedData$subjectID)
tidySummaryData <- mutate(tidySummaryData,activity=mergedData$activity)

### use the dplyr group_by function to group the tidySummaryData by
### subjectID and activity
tidySummaryData <- group_by(tidySummaryData, subjectID, activity)

### We want the mean of each of the variables. the summarise_each function from 
### the dplyr package will summarise and mutate multiple columns excluding the 
### grouped columns.
tidySummaryData <- summarise_each(tidySummaryData, funs(mean))

### summarise_each doesn't rename columns [will do that here]
tidyDataNames <- names(tidySummaryData) # Note: 1st 2 are subjectID & activity
numNames <- length(tidyDataNames)

tidyDataNames[3:numNames] <- paste("Mean_of_",tidyDataNames[3:numNames],sep="")

### rename the column variables
names(tidySummaryData) <- tidyDataNames

### remove the unnecessary values
rm(numNames,tidyDataNames)

### remove the grouping from the tidySummaryData
tidySummaryData <- ungroup(tidySummaryData)


## =============================================================================
## save tidySummaryData to a text file if option is chosen
## =============================================================================

if(saveTidySummary){
        write.table(tidySummaryData,file="./tidySummaryData.txt",row.names=FALSE)
}


