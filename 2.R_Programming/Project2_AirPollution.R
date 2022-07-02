#Coursera R Programming Project 2 -- Air Pollution

#Part 1
#Write a function named 'pollutantmean' that calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors. 
#The function 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. 
#Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' particulate matter data from the directory specified in the 'directory' argument 
#and returns the mean of the pollutant across all of the monitors, ignoring any missing values coded as NA. 

#Below is my solution
library(dplyr)
pollutantmean <- function(directory, pollutant, id = 1:332){ #id should be a list
      setwd(directory)
      cal_vec <- c()
      for (i in id) {
            idx = sprintf("%03d",i)
            filename <- paste(idx,".csv", sep = "")
            df <- read.csv(filename) %>% data.frame()
            cal_vec <- c(cal_vec, df[,pollutant])
      }
      total_mean <- mean(cal_vec, na.rm = TRUE)
      total_mean
}

#Part 2
#Write a function that reads a directory full of files and reports the number of completely observed cases in each data file. 
#The function should return a data frame where the first column is the name of the file 
#and the second column is the number of complete cases. 

#Below is my solution
library(dplyr)
complete <- function(directory, id = 1:332){
          setwd(directory)
          sum_table = data.frame()
          for (i in id) {
                idx = sprintf("%03d",i)
                filename <- paste(idx,".csv", sep = "")
                df <- read.csv(filename) %>% data.frame()
                complete_local <- sum(complete.cases(df))
                table_local = data.frame(
                      id=i,
                      nobs = complete_local
                )
                sum_table <- rbind(sum_table, table_local)
          }
  sum_table
}
complete("/Users/zixuanyu/R_Projects/datasciencecoursera/specdata", 1:3)
# References: dataframe manipulations 
# 1) https://www.cnblogs.com/studyzy/p/R_DataFrame_Operation.html
# 2) https://www.runoob.com/r/r-data-frame.html

#Quiz Question 7
RNGversion("3.5.1")  
set.seed(42)
cc <- complete("/Users/zixuanyu/R_Projects/datasciencecoursera/specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])


#Part 3
#Write a function that takes a directory of data files and a threshold for complete cases 
#and calculates the correlation between sulfate and nitrate for monitor locations 
#where the number of completely observed cases (on all variables) is greater than the threshold. 
#The function should return a vector of correlations for the monitors that meet the threshold requirement. 
#If no monitors meet the threshold requirement, then the function should return a numeric vector of length 0. 

#Below is my solution
# Warm reminder!! You should remove all the NAs before you calculate the correlation between sulfate and nitrate

library(dplyr)
corr <- function(directory, threshold = 0){
          setwd(directory)
          cr <- c()
          for(i in 1:332) {
                    idx = sprintf("%03d",i)
                    filename <- paste(idx,".csv", sep = "")
                    df <- read.csv(filename) %>% data.frame()
                    sum_complete_local <- sum(complete.cases(df))
                    if (sum_complete_local > threshold){
                              corr_local <- cor(df$sulfate, df$nitrate, use = "complete.obs")
                              cr <- c(cr, corr_local)
                    }
          }
  cr
}
#my_corr <- corr("/Users/zixuanyu/R_Projects/datasciencecoursera/specdata",150)

# Quiz Question 8
my_corr <- corr("/Users/zixuanyu/R_Projects/datasciencecoursera/specdata")                
my_corr <- sort(my_corr)   
RNGversion("3.5.1")
set.seed(868)                
out <- round(my_corr[sample(length(my_corr), 5)], 4)
print(out)

# Quiz Question 9
my_corr <- corr("/Users/zixuanyu/R_Projects/datasciencecoursera/specdata",129)                
my_corr <- sort(my_corr)  
n <- length(my_corr)    
RNGversion("3.5.1")
set.seed(197)                
out <- c(n, round(my_corr[sample(n, 5)], 4))
print(out)

# Quiz Question 10
my_corr <- corr("/Users/zixuanyu/R_Projects/datasciencecoursera/specdata",2000)                
n <- length(my_corr)
my_corr <- corr("/Users/zixuanyu/R_Projects/datasciencecoursera/specdata",1000)              
my_corr <- sort(my_corr)
print(c(n, round(my_corr, 4)))

