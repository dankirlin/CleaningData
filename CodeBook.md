First I declare some variables

Variables:

features : List of features in the data set
activity_labels: List of activities in the data set
training_set : data.frame of the training set
training_label : labels of the training set
training_subject : subject in the training set
test_set : data.frame of the training set
test_label : labeles of the test set
test_subject : subject in the test set

I then go into a loop where I iterate over all the items in the features vector and expand them to be easier to read and store them in the new_features vector.
Extrapolations for what is easier to read comes from the README.txt of the original data set (refer to lines 25-48 of my code for examples of what I swapped out)

I then merge all my pieces of data (colbind label, subject and set ; rbind training and test)

I then create an activity data frame (activity_frame) where I could join back into my original table to get the more descriptive activities. I then splice out the artifact column to give me
(merged_data_activites_cleaned)

I think use regular expression to determine which columns are means and standard deviation columns (merged_mean, merged_std)
I use this factor to subselect from my primary table

For the final part of the problem I use a nested for loop to iterate over the subject and activities. 
For each of these I use the function colMeans to determine averages in each columnand then build a new table using rbind for each of the returned colMeans.

I then use write.table() to write out the results to a text file.

