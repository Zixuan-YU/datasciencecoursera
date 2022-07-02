##参考（1）https://github.com/byron-data/R-Programming-Assignment-3/blob/master/rankall.R
##参考（2） https://gist.github.com/mGalarnyk/21695638e94965640c35667e8683642c

rm(list = ls())
setwd("~/R_Projects/datasciencecoursera/rprog-ProgAssignment3-hospital")
library(dplyr)
rankall <- function(outcome, num = "best"){
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv")
  ## Check that num is valid
  if(!(num =="best" || num == "worst" || num%%1 == 0)){stop("invalid rank")}
  
  ## Check that outcome is valid
  if(!outcome %in% c("heart attack","heart failure","pneumonia")){
    stop("invalid outcome")
  }
  
  ## Replace "Not Available" string with NA to avoid coercion warnings
  data[data == "Not Available"] <- NA
  
  
  ## Get column number for the given outcome
  my_col <- if (outcome == "heart attack") {
    11
  } else if (outcome == "heart failure") {
    17
  } else {
    23
  }
  
  ## Make the valid outcome column numeric so the ordering will work correctly
  data[,my_col] <- sapply(data[,my_col], as.numeric)
  
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the (abbreviated) state name
  states <- unique(data$State) %>% sort() #sort the states by name alphabetically
  stateRanks <- data.frame(hospital=NA, state=NA)
  
  for (i in 1:length(states)) {
    ## Get outcomes for this state only    
            statedata <- subset(data, data$State==states[i])
      ## Sort stateData by chosen outcome and then Hospital Name, remove NA values
            statedata <- statedata[order(statedata[, my_col], statedata[,"Hospital.Name"], na.last = NA),]
  
  if (num=="best"){num<-1
  }else if(num=="worst"){num <-nrow(statedata)}
  
  hospitalName <- statedata[num, "Hospital.Name"] 
  stateRanks[i,] <- c(hospitalName, states[i])
  }
stateRanks
}


r <- rankall("heart attack", 4)
as.character(subset(r, state == "HI")$hospital)

r <- rankall("pneumonia", "worst")

r[r$state=="NJ",]

r <- rankall("heart failure", 10)
as.character(subset(r, state == "NV")$hospital)
