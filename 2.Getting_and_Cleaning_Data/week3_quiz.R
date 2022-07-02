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
jpeg.j <- readJPEG("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", native = FALSE)
img <- readJPEG(system.file("img", "Rlogo.jpg", package="jpeg"))


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
#order 有一点复杂，用arrange更快一些
#rank.gdp <- match.gdp[order(as.numeric(match.gdp$Economy), dec reasing = TRUE),]  
rank.gdp <- match.gdp %>% arrange(desc(Economy))
aa <- rank.gdp %>% mutate(Group = as.numeric(Economy)*2)

subgroup <- edu[,c(1,3)]
gdp.subgroup <- merge(rank.gdp, subgroup, by.x = "Country", by.y = "CountryCode")
#分组求平均值用tapply
tapply(as.numeric(gdp.subgroup$Economy), gdp.subgroup$Income.Group, mean)

#Q5: Cut the GDP ranking into 5 separate quantile groups. 
#Make a table versus Income.Group. How many countries
#are Lower middle income but among the 38 nations with highest GDP?
gdp.subgroup <- gdp.subgroup %>% arrange(as.numeric(Economy))
top38 <- gdp.subgroup[1:38,]
LMI.countries <- gdp.subgroup %>% filter(Income.Group == "Lower middle income") %>% select(Country) 
LMI.countries %in% gdp.subgroup[1:38,1]
#Inner Join
#参考： https://r-coder.com/merge-r/
merge(LMI.countries, top38, by.x = "Country", by.y = "Country" )
