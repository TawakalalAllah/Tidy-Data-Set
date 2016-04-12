# Tidy-Data-Set - Code Book

This tidy data set is called dt2, and is uploaded in Tidy-Data-Set repo, and consists of:

1. Subject: Test subjects as column one which go from 1 to 30. subject_test.txt contains the information for these subjects

2. Activity: Six different kinds of activities i.e.
	1 WALKING
	2 WALKING_UPSTAIRS
	3 WALKING_DOWNSTAIRS
	4 SITTING
	5 STANDING
	6 LAYING
as column two. This information is extracted from y_text.txt file.

3. Features: 561 different features all in separate columns as required in a tidy data set for variables to be in their own columns. For info on these features see features.txt in UCI HAR Dataset.

-
Another tidy data set dt1 consists of the mean and std deviations of all the variables.

merged_signal_mean and merged_signal_sd are yet another two data sets which are created with sapply() to be visually appealing and present mean and sd for inertial signals.

For more information about the data sets and variables, please check UCI HAR Dataset.
