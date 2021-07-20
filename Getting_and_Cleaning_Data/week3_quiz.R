setwd("~/R_Projects/datasciencecoursera/Getting_and_Cleaning_Data")
#Q1: The American Community Survey distributes downloadable data about United States communities. 
#Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 

#code book: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
#Create a logical vector that identifies the households on greater than 10 acres 
#who sold more than $10,000 worth of agriculture products. 
#Assign that logical vector to the variable agricultureLogical. 
#Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE. 
#which(agricultureLogical) 
#What are the first 3 values that result?

library(dplyr)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",destfile = "acs2006",method = "curl")
acs2006 <- read.csv("acs2006") %>% data.frame()
agricultureLogical <- (acs2006$VAL) >= 2 & (acs2006$ACR == 3)
which(agricultureLogical) 


#Q2:Using the jpeg package read in the following picture of your instructor into R
#https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg 
#Use the parameter native=TRUE. 
#What are the 30th and 80th quantiles of the resulting data? (some Linux systems may produce an answer 638 different for the 30th quantile)
install.packages("jpeg")
