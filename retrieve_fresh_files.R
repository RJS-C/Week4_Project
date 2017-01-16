# retrieve_fresh_files.R -  sourced from run_analysis.R

# Function:     retrieveFiles
# Parameters:   None
# Purpose:      To pull down & store fresh copies of data referenced in this project
# Return:       TRUE or FALSE - indicator as to the successful completion of the purpose

retrieveFiles <- function() {
        success <- FALSE
        
        # Create a directory into which to download & unzip the data if one does not exist
        if (dir.exists("./data") == FALSE) {
                dir.create("./data")
        }
        
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL, "./data/zippedFile.zip")
        
        # Unpack the data
        if (file.exists("./data/zippedFile.zip") == TRUE){
                unzippedFiles <- unzip("./data/zippedFile.zip", exdir = "./data", overwrite = TRUE)
                
                if (length(unzippedFiles) > 0) {
                        success <- TRUE
                }
        }
        
        success
}

# Function:     loadData
# Parameters:   character string "test" or "train" 
# Purpose:      load & join the related data for this project
# Return:       data frame of the joined measuredata to the subject & activity performed

loadData <- function(datatype) {
        tempResults <- read.table(paste0(datadirectory,datatype,"/X_",datatype,".txt"))
        tempLabels <- read.table(paste0(datadirectory,datatype,"/y_",datatype,".txt"))
        names(tempLabels) <- c("activityid")
        tempSubjects <- read.table(paste0(datadirectory,datatype,"/subject_",datatype,".txt"))
        names(tempSubjects) <- c("subjectid")
        tempData <- mutate(cbind(tempSubjects, tempLabels, tempResults),subjecttype = datatype)
        tempData
}