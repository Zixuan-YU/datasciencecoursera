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
library(jpeg)
jpeg.j <- readJPEG("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", native = TRUE)

#Q3:
library(dplyr)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",destfile = "gdp.csv",method = "curl")
gdp <- read.csv("gdp.csv") %>% data.frame()
gdp <- gdp[5:nrow(gdp),c(1,2,4,5)]
colnames(gdp) <- c("Country","Economy","whole_name","Mdolars")

#Load the educational data from this data set:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile = "edu.csv", method = "curl")
edu <- read.csv("edu.csv") %>% data.frame  
match.gdp <- gdp[gdp$Country %in% edu$CountryCode,] 
#gdp2 <- gdp %>% mutate(across(where(is.character),~na_if(.,"")))



y <- c("1,200","20,000","100","12,111")
as.numeric(gsub(",","", y))
gsub(",","",as.numeric(match.gdp$Mdolars))
as.numeric(gsub("([0-9]+)\\,([0-9])","\\1\\2", gdp$Mdolars)) 

#您可以让read.table或read.csv半自动为您完成此转换。
#首先创建一个新的类定义，然后创建一个转换函数，
#并使用setAs函数将其设置为" as"方法，如下所示
#references:https://www.codenong.com/1523126/
setClass("num.with.commas")
setAs("character","num.with.commas",
      function(from) as.numeric(gsub(",","",from)))
DF <- read.csv("xxx.csv",
               colClasses = 'num.with.commas','factor','character','numeric','num.with.commas')

match.gdp <- match.gdp[!is.na(as.numeric(match.gdp$Economy)),]
rank.gdp <- match.gdp[order(as.numeric(match.gdp$Economy), decreasing = TRUE),]  




