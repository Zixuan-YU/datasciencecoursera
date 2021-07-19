#week2 by Jeffret Leek
install.packages("RMySQL")
library(RMySQL)
#https://genome.ucsc.edu/
#genome-mysql.cse.ucsc.edu

#Connecting and listing databases
ucscDb <- dbConnect(MySQL(),user="genome",
                    host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb);
#得到一个TRUE的response，是来自于dbDisconnect这个command的

hg19 <- dbConnect(MySQL(), user="genome",db="hg19",host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)

#Table = dataframe
#Field = Columnname
dbListFields(hg19,"affyU133Plus2")

dbGetQuery(hg19, "select count(*) from affyU133Plus2")
affyData <- dbReadTable(hg19,"affyU133Plus2")
View(head(affyData))

#Select a specific subset
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query); quantile(affyMis$misMatches)

#如果只是看一下little data
affyMisSmall <- fetch(query,n=10);dbClearResult(query);

dim(affyMisSmall) #show row numbers and column numbers

#Don't forget to close the connection!
dbDisconnect(hg19)


#Reading from HDF5
#large data sets, supports storing a range of data types
source("http://bioconductor.org/biocLite.R")
BiocManager::install("rhdf5")
library(rhdf5)
created = h5createFile("example.h5")
created

#create groups
created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5","baa")
created = h5createGroup("example.h5","foo/foobaa")
h5ls("example.h5")

#Write to groups
A = matrix(1:10, nrow = 5, ncol = 2)
h5write(A, "example.h5","foo/A")
h5ls("example.h5")

B = array(seq(0.1,2.0, by=0.1),dim=c(5,2,2))
attr(B, "scale") <- "liter"
h5write(B,"example.h5","foo/foobaa/B")
h5ls("example.h5")


#Write a data set
df = data.frame(1L:5L,seq(0,1,length.out = 5), c("ab","cde","fghi","a","s"), stringsAsFactors = FALSE)
h5write(df,"example.h5","df")
h5ls("example.h5")

#Reading data
readA = h5read("example.h5","foo/A")
readB = h5read("example.h5","foo/foobaa/B")
readdf = h5read("example.h5","df")
readdf

#Writing and reading chunks
h5write(c(12,13,14),"example.h5","foo/A",index=list(1:3,1))
#Write c(12,13,14) to the first 3 rows of first column in "foo/A"
h5read("example.h5","foo/A")
# Bioconductor HD5L tutorial: https://www.bioconductor.org/packages/release/bioc/vignettes/rhdf5/inst/doc/rhdf5.html
# HDF group: www.hdfgroup.org/HDF%/


#Reading from web
#Webscraping
# use Jeff's Google Scholar Page: https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en
con = url("https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con) #Don't forget!
htmlCode  ##It will come out unformated

library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes = TRUE)
#rootNode <- xmlRoot(html)
Title_list <- xpathSApply(htm,"//title",xmlValue)
Jeffpub_list <- xpathSApply(html,"//td[@id='col-citedbly",xmlValue)
#This method does not work!

#Find sth on the internet
#https://www.coursera.org/learn/data-cleaning/discussions/all/threads/TtgL_8PoEeeavAqJ3gjXqg
library(XML,RCurl)
# 1 extra line of code
gscholar_url <- "https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
curl_data <- getURL(gscholar_url)
html <- htmlTreeParse(curl_data, useInternalNodes = T)
xpathSApply(html, "//title", xmlValue)

# "Jeff Leek - Google Scholar Citations"
xpathSApply(html,"//td[@id='col-citedbly",xmlValue)

html <- htmlParse(rawToChar(get(url)$content))
xpathApply(html, "//title", xmlValue)


#GET from the httr package
library(httr)
html2 = GET(url)
content2 = content(html2,as="text")
parseedHtml = htmlParse(content2, asText = TRUE)
xpathSApply(parseedHtml,"//title", xmlValue)

#Accessing websites with password
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg1
names(pg1)
pg2 = GET("http://httpbin.org/basic-auth/user/passwd", 
          authenticate("user","passwd"))
pg2 
names(pg2)

#Using handles
google = handle("http://google.com")
pg1 = GET(handle = google, path = "/")
pg2 = GET(handle = google, path="search")


##Creating an application
myapp = oauth_app("twitter", key = "yourConsumerKeyHere",secret = "yourConsumerSecretHere")
sig = sign_oauth1.0(myapp,
                    token = "yourTokenHere",
                    token_secret = "yourTokenSecretHere")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)
#Converting the json object
json1 = content(homeTL)
json2 = jsonlite::fromJSON(json1) #reformat it!
json2[1,1:4]
#https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/get-statuses-show-id
#Resource URL:https://api.twitter.com/1.1/statuses/show.json
#In general look at the documentation
#https://api.twitter.com/docs/api/1.1/overview

library(httr)

