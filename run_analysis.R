## run_analysis.R

## Load Relevant Libraries

library(dplyr)
library(sqldf)
source("retrieve_fresh_files.R")

# store intended location of files extracted from downloaded zip file

datadirectory <- "./data/UCI HAR Dataset/"

retrieveFiles()    

                
## Load data files
                
testdata <- loadData("test")
traindata <- loadData("train")
                
featuresdata <- read.table(paste0(datadirectory,"features.txt"))
names(featuresdata) <- c("featureid","featuredescription")
                
activitylabels <- read.table(paste0(datadirectory,"activity_labels.txt"))
names(activitylabels) <- c("activityid","activitydescription")
                
## Merge training & test sets to create 1 single dataset
alldata <- rbind(traindata,testdata)
                
# Give the column headers descriptive names. Columns are from left to right, subjectid, activityid, feature.txt data

columnheaders <- append(c("subjectid","activityid"), as.character(featuresdata$featuredescription))

# Select subjectid, activityid & then only those variables that represent measurements of mean & standard deviation
# and label the columns of the selected data set

SelectedData <- select(alldata,grep("^subjectid|^activityid|mean\\(|std\\(",columnheaders,ignore.case=TRUE))
names(SelectedData) <- grep("^subjectid|^activityid|mean\\(|std\\(",columnheaders,ignore.case=TRUE,value=TRUE)
                
# add the related activity description text and remove the activityid for more descriptive data

SelectedData <- sqldf("select al.activitydescription,sd.* from SelectedData sd 
                join activitylabels al on sd.activityid = al.activityid") %>% select(-activityid)
                
# Melt the data down by activity, subject & variable and then roll it back up to gather the mean for each 
# variable by subject & activity   

SummaryData <- melt(SelectedData,c("activitydescription","subjectid")) %>% 
        dcast(activitydescription + subjectid ~ variable,mean)
                

# Cleanup Variables
rm(list = c("featuresdata","alldata","activitylabels","columnheaders","testdata","traindata","datadirectory",
            "loadData","retrieveFiles"))
 