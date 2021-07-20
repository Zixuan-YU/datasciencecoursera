setwd("~/R_Projects/datasciencecoursera/Getting_and_Cleaning_Data")
##Q1: Register an application with the Github API here https://github.com/settings/applications. 
# Access the API to get information on your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos").
# Use this data to find the time that the datasharing repo was created. What time was it created?
# see https://medium.com/@GalarnykMichael/accessing-data-from-github-api-using-r-3633fb62cb08#.z0z07ph5h for more details.

# references: https://gist.github.com/mGalarnyk/ab0b1744fc718effa2759b2a1f17d60e
#install.packages("jsonlite")
library(jsonlite)
install.packages("httpuv")
library(httpuv)
#install.packages("httr")
library(httr)

# Can be github, linkedin etc depending on application
oauth_endpoints("github")

# Change based on your appname, key, and secret 
myapp <- oauth_app(appname = "mygitapp",
                   key = "7812238ae089755748d1",
                   secret = "471229c4d4c9885c20cd0d029d7651e632f17a8c")
# Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
# Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

# Take action on http error
stop_for_status(req)

# Extract content from a request
json1 = content(req)

# Convert to a data.frame
gitDF = jsonlite::fromJSON(jsonlite::toJSON(json1))

# Subset data.frame
gitDF[gitDF$full_name == "jtleek/datasharing", "created_at"] 


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
library(XML);library(RCurl)
url.j <- "http://biostat.jhsph.edu/~jleek/contact.html"
#curl_data <- getURL(url.j)

conn <- url(url.j)
htmlCode <- readLines(conn)
close(conn)
lst.n = vector()
for (i in c(10,20,30,100)){
  n <- nchar(htmlCode[i])
  lst.n <- c(lst.n,n)
}

#About append
x <- rep(10:15)
gfg <- append(x, 1, 1) #Add "1" after the first element


#Q5: Question 5
#Read this data set into R and report the sum of the numbers in the fourth of the nine columns.
#https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
#Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for
#(Hint this is a fixed width file format)

#Hint about fixed width file: https://riptutorial.com/r/example/31447/importing-fixed-width-files
library(readr)
library(dplyr)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for",destfile = "SST.for",method = "curl")
sst <- read.fwf("SST.for", skip=4, widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4))
#Speed comparison: readr::read_fwf() was ~2x faster than utils::read.fwf ().
sum(sst[,4])
s <- apply(sst$V2,2,sum)
