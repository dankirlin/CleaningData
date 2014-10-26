Must place the R script in the top level of UCI HAR Dataset

You can then run the script from this location, all of my scripts are in the single file run_analysis.R.

When you run it, it will do all of its analysis in one pass, just make sure you have it nested in the top level of the 
UCI HAR Dataset available at (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

It will produce a data set of only mean columns (merged_mean), standard deviation columns (merged_std), 
a cleaned data set (merged_activities_cleaned), with more descriptive activities column values, and desciptive column names
and a data frame of means of variables by subject and activity(question5Answer)

Answer for individual questions are stored in these variables (you can use RStudio to inspect them after a run):
Question 1 Answer: merged_data
Question 2 Answer: merged_mean, merged_std
Question 3 Answer: merged_activities_cleaned
Question 4 Answer: merged_activities_cleaned
Question 5 Answer: question_5_answer