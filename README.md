---
title: "README.md"
output: html_document
---


## Peer-graded Assignment: Getting and Cleaning Data Course Project

This is a description of the script run_analysis.R, which is used to cready a tidy data set from
the UCI HAR Dataset provided for the assignment.

I first read in all of the relevant files.  Staring from the working directory, I load activity_labels.txt
and features.txt from the /UCI HAR Dataset directory.  Then load subject_test.txt, x_test.txt, and y_test.txt
from the test subdirectory and subject_train.txt, x_train.txt, and y_train.txt from the train subdirectory

Find the columns with mean or std numbers and select only those columns from the data

Use the features.txt data to rename those columns, and the activity_labels.txt data to change the activity
numbers to descriptive labels

Column-bind the test and train datasets(subject, activity, and main data), then merge the data to combine the test and train data into one dataset

Use dcast to group the data by subject and activity and compute the mean for each measurement

Write the tidy data set to a test file
