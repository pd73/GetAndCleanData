GetAndCleanData Course Project
==============================
This README file describes how the script run_analysis.R works

Comments in the file specify where the original data were sourced, via a ZIP file
It can be downloaded and manually unzipped.
According to the instructions for the assignment, the data files are assumed to be in the working directory.
I load in 8 text files that describe the data
features.txt contains the list of variable names
X_train.txt is the main set of training data
y_train.txt is the activity code for each row of data in Train
subject_train.txt links a subject ID to each row in Train
X_test.txt is the main set of testiong data
y_test.txt is the activity code for each row of data in Test
subject_test.txt links a subject ID to each row in Test
activity_labels.txt lists in english what the activity codes represent

We want just mean and std columns. Mean always precedes std, unless it appears with Freq, which we want to discard.
Therefore I find the indices in features that contain "std()" for the STD columns, and the MEAN colums are always 1 index before that

Next I make the table of all the data
I use column bind to link the activity code, subject ID and data for each of the Training and Test data sets, then row bind these together
I update the names of this frame to be descriptive

I append a final column which is the English language lable for the activity code of that row

To make the tidy summary data I make an empty data frame 180 x 68
I use brute force for loops to cycle though all combinations of subject and activity
For each of these I subset the rows that contain data for that subject and activity and use colMeans to summarize this set

Lasty I update the names of the columns in the tidy data set and write it out as a Text file in CSV format


