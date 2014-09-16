---
title: "CodeBook"
output: html_document
---

# CodeBook: tidySummaryData.txt


## The original data

The variables for this data set have been processed from

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The data from the above study will be referred to as the "Original data".


## The data processing from orginal data to tidySummaryData.txt

tidySummaryData.txt is based on data from the following text files found in the original data

activity_labels.txt
features.txt

subject_test.txt
X_test.txt
y_test.txt

subject_train.txt
X_train.txt
y_train.txt


The data from Xtest was modified by adding two columns to the data. These columns being subjecttest.txt and ytest. 

The resulting data frame was converted into a table data frame (tbl_df).

The above process was repeated for Xtrain.txt, subjecttrain.txt and ytrain.txt to create a second table data frame.

These two data frames were then row bound to create one larger table data frame containing all the test and train data.

From this larger data frame the variables containing the strings "mean()" and "std()" of the original data set were extracted. The data stored in the subjectID and activity variables were also extracted for processing.

The values in the activity variable were replaced with more descriptive names
1 WALKING  
2 WALKING_UPSTAIRS  
3 WALKING_DOWNSTAIRS  
4 SITTING  
5 STANDING  
6 LAYING  

The variable names for the extracted data were changed by removing parentheses "()", replacing hyphens with underscores and changing any instances of the string "BodyBody" within a variable name to "Body".

The tidySummaryData was initially set up with all the mean and standard deviation columns that had been extracted for processing, the two additional columns containing the subjectID and the (descriptive) activity variables were also added.

The tidySummaryData table data frame was grouped by both subjectID and by activity.

The columns of the tidySummaryData data frame where then processed by taking the average of each variable (these being the extracted mean and standard deviation values) for each activity (the unique values in the activity column) and each subject (the unique values in subjectID column).

The variables in the tidySummaryData were then renamed adding the prefix: "Mean_of_". 

The grouping within the tidySummaryData table data frame were removed.


## The variables in the tidySummaryData

tidySummaryData contains 180 observations of 68 variables. Each column is a variable and the result is a tidy wide data frame.

[Column 1]:
Var name:       subjectID       
integer values: from 1 to 30 
represents:     each number indicating a particular test subject.

[Column 2]:
Var name:       activity        
string values:  "WALKING" "WALKING_UPSTAIRS" "WALKING_DOWNSTAIRS" "SITTING" "STANDING" "LAYING". 
represents:     The type of activity being monitored.

[Column 3-68]:
                                
Var Names:                
Mean_of_tBodyAcc_mean_X
Mean_of_tBodyAcc_mean_Y
Mean_of_tBodyAcc_mean_Z
Mean_of_tBodyAcc_std_X
Mean_of_tBodyAcc_std_Y
Mean_of_tBodyAcc_std_Z
Mean_of_tGravityAcc_mean_X
Mean_of_tGravityAcc_mean_Y
Mean_of_tGravityAcc_mean_Z
Mean_of_tGravityAcc_std_X
Mean_of_tGravityAcc_std_Y
Mean_of_tGravityAcc_std_Z
Mean_of_tBodyAccJerk_mean_X
Mean_of_tBodyAccJerk_mean_Y
Mean_of_tBodyAccJerk_mean_Z
Mean_of_tBodyAccJerk_std_X
Mean_of_tBodyAccJerk_std_Y
Mean_of_tBodyAccJerk_std_Z
Mean_of_tBodyGyro_mean_X
Mean_of_tBodyGyro_mean_Y
Mean_of_tBodyGyro_mean_Z
Mean_of_tBodyGyro_std_X
Mean_of_tBodyGyro_std_Y
Mean_of_tBodyGyro_std_Z
Mean_of_tBodyGyroJerk_mean_X
Mean_of_tBodyGyroJerk_mean_Y
Mean_of_tBodyGyroJerk_mean_Z
Mean_of_tBodyGyroJerk_std_X
Mean_of_tBodyGyroJerk_std_Y
Mean_of_tBodyGyroJerk_std_Z
Mean_of_tBodyAccMag_mean
Mean_of_tBodyAccMag_std
Mean_of_tGravityAccMag_mean
Mean_of_tGravityAccMag_std
Mean_of_tBodyAccJerkMag_mean
Mean_of_tBodyAccJerkMag_std
Mean_of_tBodyGyroMag_mean
Mean_of_tBodyGyroMag_std
Mean_of_tBodyGyroJerkMag_mean
Mean_of_tBodyGyroJerkMag_std
Mean_of_fBodyAcc_mean_X
Mean_of_fBodyAcc_mean_Y
Mean_of_fBodyAcc_mean_Z
Mean_of_fBodyAcc_std_X
Mean_of_fBodyAcc_std_Y
Mean_of_fBodyAcc_std_Z
Mean_of_fBodyAccJerk_mean_X
Mean_of_fBodyAccJerk_mean_Y
Mean_of_fBodyAccJerk_mean_Z
Mean_of_fBodyAccJerk_std_X
Mean_of_fBodyAccJerk_std_Y
Mean_of_fBodyAccJerk_std_Z
Mean_of_fBodyGyro_mean_X
Mean_of_fBodyGyro_mean_Y
Mean_of_fBodyGyro_mean_Z
Mean_of_fBodyGyro_std_X
Mean_of_fBodyGyro_std_Y
Mean_of_fBodyGyro_std_Z
Mean_of_fBodyAccMag_mean
Mean_of_fBodyAccMag_std
Mean_of_fBodyAccJerkMag_mean
Mean_of_fBodyAccJerkMag_std
Mean_of_fBodyGyroMag_mean
Mean_of_fBodyGyroMag_std
Mean_of_fBodyGyroJerkMag_mean
Mean_of_fBodyGyroJerkMag_std


Data Type:      Double
represents:     These are the average values for each activity and each subjectID of the -mean() and -std() features from the original data set. The naming convention follows that of the original data. (See below Original Data Note)


## Original Data Note: The naming convention of the variables.

Note: The information below is largely taken from the features_info.txt file found in the Original data. It has been edited in places removing mention of any variables not relevant for the tidySummaryData. For further information concerning the original data consult the features_info.txt file found with the original data.

The original study came from the accelerometer and gyroscope 3-axial raw signals (tAcc-XYZ and tGyro-XYZ).The t prefix denotes the time domain signal measurements. These measurements had noise removed through a Butteroworth filter.

The original study then split the acceleration signal data into body and gravitational signals (tBodyAcc-XYZ and tGravityAcc-XYZ). 

The body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. [Note: the 'f' indicates frequency domain signals.]

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ  
tGravityAcc-XYZ  
tBodyAccJerk-XYZ  
tBodyGyro-XYZ  
tBodyGyroJerk-XYZ  
tBodyAccMag  
tGravityAccMag  
tBodyAccJerkMag  
tBodyGyroMag  
tBodyGyroJerkMag  
fBodyAcc-XYZ  
fBodyAccJerk-XYZ  
fBodyGyro-XYZ  
fBodyAccMag  
fBodyAccJerkMag  
fBodyGyroMag  
fBodyGyroJerkMag  

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
