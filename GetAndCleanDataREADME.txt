==================================================================
Get and Clean Data README
==================================================================
A Steenekamp
==================================================================

- The assignment has been done with the assumption that only the test and training datasets are applicable and the Inertial Signals files have not been used
- The requirement for a code book is not clear and has not been done.

The dataset includes the following files:
=========================================
- 'GetAndCleanDataREADME.txt'
==========================================
'run_analysis.R': The R script for the assignment.
=================================================
- NOTE: library(dplyr) must be invoked before running the script 
- It consists of 4 distinct functions:
- 'fulltable' - input parameter: the rootpath to the UCI HAR dataset. 
	It merges the training and test datasets to create one tidy dataset. 
	It uses the result of headdf (which contains only measurements on the mean and standard deviation) when combining the 2 datasets
	It creates a second tidy data set with the average of each variable for each activity and each subject.  
- 'headdf' - extracts only the measurements on the mean and standard deviation for each measurement and assign names to the columns.
- 'testdata' - combines the subjects and activities of the datasets and translates the activities to meaningful names
==================================================
Output csv files
==================================================
- 'analysisdetail.csv' - take out the  
	"ftable %>% group_by(Subject, Activity) %>% summarize_each(funs(mean)) # summary" line from the r script and write.csv(detailcsv)
- 'summarydetail.csv' - run the script with
 	"ftable %>% group_by(Subject, Activity) %>% summarize_each(funs(mean)) # summary" and write.csv(summarycsv)
 
 

