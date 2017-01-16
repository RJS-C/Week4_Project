# Week4_Project

### Required Libraries

* dplyr
* sqldf

### Assumptions: 
Data has not previously been downloaded & unzipped.

Source:
Description of Data:  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Actual Data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


### codebook.txt:
Compiles data from the original source 

### run_analysis.R (Primary Sourced File)
When sourced, this file will call out to retrieve_fresh_files.R (see description below) to download a fresh copy of the required data.
        
The data will be saved to "./data" and unzipped in the same location accordingly for processing.
        
First will run through a series of steps to:
        
* compile & merge the test & train data
* set descriptive variable / column names
* extract only the measurements associated with mean & standard deviation
* expose this data frame in the results as SelectedData
        
Finally, the SelectedData will be summarized in a data frame called SummaryData that averages
each variable for each subject & activity

Resulting Data Frames:
* SelectedData
* SummaryData

### retrieve_fresh_files.R 
Sourced from run_analysis.R in order to 

* Download & Extract Original Files from Source Location
* Load Data From .csv Files Into Data Frames for Processing.
        



