pollutantmean <- function(directory, pollutant, id = 1:332) {
        # Coursera
        # Especialización en Data Science
        # Johns Hopkins University
        # R Programming
        # Programming Assigment 1
        
        if (is.vector(id)) {
                if (pollutant=="sulfate"  || pollutant=="nitrate") {
                        FWorkingData <- c()
                        for (i in id) {
                                dir <- file.path(...=getwd(),as.character(directory),sprintf("%03d.csv",i))
                                SubsetData <- read.csv(file=dir)
                                SubsetData <- SubsetData[[pollutant]]
                                FWorkingData <- c(FWorkingData,SubsetData[!is.na(SubsetData)])
                        }
                        return(mean(FWorkingData))
                }
                else {
                        message("invalid pollutant") 
                } 
        }
        else{
                message("invalid id")  
        }  
}
