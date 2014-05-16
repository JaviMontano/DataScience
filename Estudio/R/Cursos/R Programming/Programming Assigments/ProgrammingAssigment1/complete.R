complete <- function(directory, id = 1:332) {
        # Coursera
        # Especialización en Data Science
        # Johns Hopkins University
        # R Programming
        # Programming Assigment 1
        
        if (is.vector(id)) {
                nobs <- c()
                for (i in id) {
                        dir <- file.path(...=getwd(),as.character(directory),sprintf("%03d.csv",i))
                        FWorkingData <- read.csv(file=dir)
                        SubsetData <- complete.cases(...=FWorkingData)
                        nobs <- c(nobs,nrow(FWorkingData[SubsetData,]))
                }
                return(data.frame(cbind(id,nobs)))
        } 
        else{
                message("invalid id")  
        }  
}