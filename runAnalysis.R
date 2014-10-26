#features_info <- read.table("features_info.txt")
features_table <- read.table("features.txt")
features <-features_table[,2]
activity_labels <-read.table("activity_labels.txt")

training_set <-read.table("train/x_train.txt")
#names(training_set) <- as.character(features)
training_label <-read.table("train/y_train.txt")
names(training_label) <- c("activities")
training_subject <-read.table("train/subject_train.txt")
names(training_subject) <- c("subject")

test_set <-read.table("test/x_test.txt")
#names(test_set) <- as.character(features)
test_label <-read.table("test/y_test.txt")
names(test_label) <- c("activities")
test_subject <- read.table("test/subject_test.txt")
names(test_subject) <- c("subject")

features_character <- as.character(features)
new_features <- features_character
for (i in 1:length(features_character))
{
  temp <- features_character[i]
  temp1 <- gsub("Acc", " Accelerometer ", temp)
  temp2 <- gsub("Gyro", " Gyroscope ", temp1)
  temp3 <- gsub("fBody", " Fourier Transformed Body Signals ", temp2)
  temp4 <- gsub("fGracity", "Fourier Transformed Gravitational Signals ", temp3)
  temp5 <- gsub("tBody", " Body Signals ", temp4)
  temp6 <- gsub("tGracity", "Gravitational Signals ", temp5)
  temp7 <- gsub("Jerk", "Extrapolated Jerk Signal", temp6)
  temp8 <- gsub("mean()", "Mean Value", temp7)
  temp9 <- gsub("std()", "Standard Deviation", temp8)
  temp10 <- gsub("mad()", "Median Absolute Deviation", temp9)
  temp11 <- gsub("max()", "Largest Value in Array", temp10)
  temp12 <- gsub("min()", "Smallest Value in Array", temp11)
  temp13 <- gsub("sma()", "Signal Magnitude Array", temp12)
  temp14 <- gsub("energy()", "Energy Measure", temp13)
  temp15 <- gsub("iqr()", "Interquartile Range", temp14)
  temp16 <- gsub("entropy()", "Signal entropy", temp15)
  temp17 <- gsub("arCoeff()", "Autorregresion coefficients with Burg order equal to 4", temp16)
  temp18 <- gsub("correlation()", "Correlation Coefficient",temp17)
  temp19 <- gsub("maxInds()", "Index of the largest frequency component", temp18)
  temp20 <- gsub("meanFreq()", "Weighted average of the frequency components to obtain a mean frequency", temp19)
  temp21 <- gsub("skewness()", "skewness of the frequency domain signal", temp20)
  temp22 <- gsub("kurtosis()", "kurtosis of the frequency domain signal", temp21)
  temp23 <- gsub("bandsEnergy()", "Energy of a frequency interval ", temp22)
  temp24 <- gsub("angle()", "Angle between to vectors", temp23)
  new_features[i] <- temp24
}

names(training_set) <- as.character(new_features)
names(test_set) <- as.character(new_features)

activity_factor <- c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying")
activity_factor_numeric <- c("1","2","3","4","5","6")
activity_frame <- data.frame(activity_factor, activity_factor_numeric)
names(activity_frame) <- c("activities_description", "activities")

training_merged <- cbind(training_subject, training_label, training_set)
test_merged <- cbind(test_subject, test_label, test_set)
merged_data <- rbind(training_merged, test_merged)

merged_data_activities <- merge(activity_frame, merged_data, by="activities", All=TRUE)
subject_named <- merged_data_activities[,3]
names(subject_named) <- c("subject")
activities_named <-merged_data_activities[,2]
names(activities_named) <- c("activities")
merged_data_activites_cleaned <- cbind(subject_named, activities_named ,merged_data_activities[,c(4:564)])
#names(training_merged) <- as.character(features)
#names(test_merged) <- as.character(features)

mean_factor <- grep("Mean", features)
std_factor <- grep("Standard Deviation", features)
  
#training_mean <- training_merged[,mean_factor]
#training_std <-training_merged[,std_factor]
#test_mean <- test_merged[,mean_factor]
#test_std <- test_merged[,std_factor]
merged_mean <- merged_data[,mean_factor]
merged_std <- merged_data[,std_factor]

subj_array <- unique(merged_data_activites_cleaned$subject_named)
average_data <- merged_data_activites_cleaned[1,]
for (sj in 1:length(subj_array))
{
  for(ai in 1:length(activity_factor))
  {
    subj <- subj_array[sj]
    act <- activity_factor[ai]
    filteredTable <- merged_data_activites_cleaned[(merged_data_activites_cleaned$activities_named == act & merged_data_activites_cleaned$subject_named == subj),]
    filteredTableMeans <- as.factor(colMeans(filteredTable[3:563]))
    int1 <- append(subj, act)
    filteredRowMeans <- append(int1, filteredTableMeans)
    average_data <- rbind(average_data, filteredRowMeans)
    print(subj)
    print(act)
  }
}

question5Answer <- average_data[2:nrow(average_data), 2:ncol(average_data)]
write.table(question5Answer, "courseproject.txt")