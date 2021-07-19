setwd("~/R_Projects/datasciencecoursera/Getting_and_Cleaning_Data")


#Q2
#The sqldf package allows for execution of SQL commands on R data frames. 
#We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL. 
#Download the American Community Survey data and load it into an R object called "acs"
#Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?
install.packages("sqldf")
install.packages("dplyr")
library(dplyr)
library(RMySQL)
library(sqldf)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",destfile = "acs.csv",method = "curl")
acs <- read.csv("acs.csv") #%>% data.frame()
acss <- select(acs,"pwgtp1","AGEP")
head(acss)
sqldf("select pwgtp1 from acs where AGEP < 50 LIMIT 10")

#不知道为什么这样子不行 T T
#查询了stackoverflow！ 得到了一个答案
#It doesn't seem like you need to load the RMySQL library when using sqldf, since you have already read the data into memory, which seems to be the problem here:
#关于如何detach RMySQL
#detach("package:RMySQL", unload=TRUE)
#???? 加了这一行之后竟然就可以了

#Q3: Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)
sqldf("select DISTINCT AGEP from acs LIMIT 10")

#Q4: How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
# http://biostat.jhsph.edu/~jleek/contact.html
# (Hint: the nchar() function in R may be helpful)


