The ReadMe file is written as per the instructions of the course assignment. 
This file explains how each piece of the code is related and how the whole code comes about.

1.The first block of the code is about reading the train data into R.
2.This data is then concatenated(using cbind)
3.The same is done for the test data and combined using cbind.
4.The dataset created using the above steps is the combined using row bind to create a major data set called combdata.
5.The featues file is loaded and column names are assigned to combined data created in step 4
6.Using the grep() function the column names with the text string "mean" and "std" are extracted.
7.Using negation "!" with grep all column names containing the string "meanFreq" are excluded.
8.Using the for loop function the script loops over all the rows and checks the integer value of the activity.
9.Depending on the activity the if command assigns the descriptive names to activity column.
10.The resulting data set is melted using subject and activity as id
11.The data is recast aggregating by subject id-activity-and means of the various columns.
12.The resulting dataset is given to a new text file using sink() command. 

THE FINAL DATA SET IS ARRANGED BY EACH SUBJECT, ACTIVITY FOR EACH SUBJECT AND THE RESPECTIVE COLUMN MEANS.
THE FINAL DATA SET HAS 180 ROWS (6 ACTIVITIES * 30 PEOPLE) AND MEAN AND STD COLUMNS FOR EACH MEASURMENT