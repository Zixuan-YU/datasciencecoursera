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
