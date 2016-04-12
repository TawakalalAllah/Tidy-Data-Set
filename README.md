# Tidy-Data-Set
The program works by getting all the file names in test and train directories and then reading them with read.csv().

Then the program merges the two data set creating a merged data set. Program also creates a merged_signals data set which is the inertial signals from test and train merged together.

Then it manipulates the merged data set so that all the features are in different columns. It also separates the 128-vector inertial signals into different columns.

Then it gives the columns their respective names: 1. Subject, Feature, Activity.

It also removes the first empty column from features and inertial signals which was created when earlier we separated the columns through strsplit.

Then the program converts the features and inertial signals to type double.

It gives descriptive names to the inertial signal data set taking names from the files.

It also marks all activity numbers with their respective labels.

It gives descriptive variable names for the feature set, reading all 561 names from the features.txt file.

The program combines now features and inertial signals to prepare for taking measurements.

Program makes this data set as a data frame called merged2

mean() and sd() functions are called on this data frame and a summarised dataframe is created called dt1 with rows Mean and Std Deviation

More clear and visually appealing dataframes are also created with the use of sapply. One for Inertial signal means, and other for std deviation of the inertial signals.

Now, second data set which is the average of each variable for each activity and each subject is created by name of dt2.

Finally, this dt2 tidy data set is exported with write.table().
