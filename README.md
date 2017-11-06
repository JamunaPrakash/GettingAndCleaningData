# GettingAndCleaningData
This file lists the steps to create the required tidy dataset from the given independent datasets for the Week#4's Programming assignment
for the Course Getting and Cleaning Data.

Steps:
------

1. Download and unzip the data into your working directory.
2. Download the run_analysis.R code into your working directory.
3. Run the R code to generate the tidydata.txt file in the same directory.

Data Collection:
----------------

The X data for this has been collected using waist strapped smart devices from 30 different subjects. The Y data defines the type of activities the subjects performed.

R Code Description:
-------------------
1. Reads data from the train and test data text files for the X, Y and the recorded data (uses the read.table call to read the text files).
2. The R code combines the train and test datasets into independent datasets(uses the rbind call). 
3. Searches for the data labels with "mean" and "std" in them, selects only those columns that match the searched texts (uses the grep command).
4. Cleans the data by replacing the numerical factors with descriptive names.
5. Creates a separate dataset with labels from selected variables with averages from each of the activities in separate variables (uses the cbind call, pipeline call to summarize the averages of data grouped by activities, by subjects 'group_by', 'summarize_all' functions are used from dplyr package).
6. Writes the data into a text file called "tidydata.txt" (uses the write.table command).
