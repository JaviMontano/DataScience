corr <- function(directory, threshold = 0) {
        # Coursera
        # Especialización en Data Science
        # Johns Hopkins University
        # R Programming
        # Programming Assigment 1
        
        corrVector <- c()
        dir <- file.path(...=getwd(),as.character(directory))
        arch <- list.files(path=dir)
        for (i in 1:length(arch)) {
                dir <- file.path(...=getwd(),as.character(directory),sprintf("%03d.csv",i))
                FWorkingData <- read.csv(file=dir)
                SubsetData <- complete.cases(...=FWorkingData)
                FWorkingData <- FWorkingData[SubsetData,]
                if (nrow(FWorkingData)>threshold){
                        corrVector <- c(corrVector,cor(FWorkingData$sulfate,FWorkingData$nitrate)) 
                }
        }
        return (corrVector)
}