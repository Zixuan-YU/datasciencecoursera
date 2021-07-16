library(dplyr)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "Community_Survey.csv", method = "curl")
CS_Data <- read.csv("Community_Survey.csv")
#Data Dictionary: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
#Q1: How many properties are worth $1,000,000 or more?
count(filter(CS_Data, VAL >= 24))

#Q2: Use the data you loaded from Question 1. Consider the variable FES in the code book.
#Which of the "tidy data" principles does this variable violate? 
Q2 <- CS_Data %>% select(SERIALNO,FES)

#Answer: Tidy data has one variable per column. 


#Q3:Read rows 18-23 and columns 7-15 into R 
#and assign the result to a variable called "dat"
# Then run "sum(dat$Zip*dat$Ext,na.rm=T)", What is the result value?
library(xlsx)
Url_3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
#download.file(Url_3, destfile = "Gas.xlsx")
dat <- read.xlsx("Gas.xlsx",sheetIndex = 1, header = FALSE)
dat <- dat[18:23,7:15]
colnames(dat) <- dat[1,]
dat <- dat[-1,]
sum(dat$Zip*dat$Ext,na.rm=T)
#????

#Q4:Read the XML data on Baltimore restaurant, How many restaurants have zipcode 21231? 
#答案是127
library(XML)
Url_4 <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
#此处非常奇怪的是，原题中给的是https，将无法成功读取
doc<- xmlTreeParse(Url_4,useInternalNodes = TRUE)
rootNode <- xmlRoot(doc)
#xmlName(rootNode)
list_zip <- xpathSApply(rootNode, path = "//zipcode",xmlValue)
list_name <-xpathSApply(rootNode, path = "//name",xmlValue)
res <- cbind(list_zip,list_name)
res <- as.data.frame(res)
count(res[res$list_zip=="21231",])
#Stackoverflow有一段用RCurl读取的代码
# https://stackoverflow.com/questions/23584514/error-xml-content-does-not-seem-to-be-xml-r-3-1-0/23584751


#https://www.cnblogs.com/franose/p/6839505.html 这是一些资料


xml.file <- xmlParse( file = "http://www.w3schools.com/xml/simple.xml")

names    <- xpathSApply( doc  = xml.file
                         , path = "//name"
                         , fun  = xmlValue
)



#Q5:Question 5
#The American Community Survey distributes downloadable data about United States communities. 
#Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
#using the fread() command load the data into an R object
library(data.table)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "CS_2016.csv", method = "curl")
DT <-fread("CS_2016.csv")
#The following are ways to calculate the average value of the variable pwgtp15
#broken down by sex. Using the data.table package,
#which will deliver the fastest user time? 
A <- rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
B <- system.time(DT[,mean(pwgtp15),by=SEX])
C <- system.time(mean(DT$pwgtp15,by=DT$SEX)) X
D <- system.time(tapply(DT$pwgtp15,DT$SEX,mean)) XX
E <- system.time(sapply(split(DT$pwgtp15,DT$SEX),mean)) X

