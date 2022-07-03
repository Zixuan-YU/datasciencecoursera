What a Code Book should contain 1) information about variables in the
data set not contained in the tidy data 2) Information about the summary
choices made 3) Information about the experimental study design used

A common format: Word/text file There should be a section called “Study
Design” that has a through description of how you collected data.

The instruction list - Ideally in R script - The input is raw data - The
output is the processed, tidy data - There are no parameters to the
script

The Three Rules of Tidy Data -Each variable must have its own column.
-Each observation must have its own row. -Each value must have its own
cell.

Get/set working directory -In Mac OS:

    setwd("./data")

-In Windows

    setwd("C:\\Users\\Andrew\\Downloads")

Checking for and creating directories

    if (!file.exists("data")){
        dir.create("data")
    }

Getting data from the Internet

    download.file(url = , destfile = , )

An example of downloading datat form baltimorecity website

    fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
    download.file(fileUrl, destfile = "./data/cameras.csv", method = "curl") #we only need to set the method to curl in MAC, while in Windows the HTTPS are the default method
    # It doesn't work because the url does not work!
    list.files("./data")
    dateDownloaded <- date()

How to open local file - I downloaded the Baltimore fixed camera dataset
mannually and save it in the file in “./data/Fixed\_Speed\_Cameras.csv”

Now try to read it!

    cameraData <- read.csv("./data/Fixed_Speed_Cameras.csv")
    head(cameraData)

Some important parameters quote - sometimes we should set quoted=""
na.strings - set the character that repressent a missing value nrows -
how many rows to read skip - number of lines to skip befere starting to
read

read Excel files

    library(xlsx)
    camrraData2 <- read.xlsx("./data/xxx.xlsx",sheetIndex = 1, header = TRUE)

-   read.xlxs2 is much faster than read.xlsx but for reading subsets of
    rows may be slightly unstable

-   XLConnect package has more options for writing and manipulating
    Excel files

-   XLCnonnect cignette is a good place to start for that package

Reading XML

1)Tags, elements and attributes Tages - Start tages
<section>

-   End tages
    </section>

          - Empty tags<line-break />

    Elements - <Greeting> Hello, world </Greeting> Attributes are
    componets of the label - <img scr = "jeff.jpg">
    alt=“instructor”/&gt; - <step number ="3"> Connect A to B. </step>

<!-- -->

    library(XML)
    fileUrl <- "http://www.w3schools.com/xml/simple/xml"
    doc <-xmlTreeParse(fileUrl, useInternalNodes = TRUE)
    rootNode <- xmlRoot(doc)

    #Progarammatically extract parts of the file
    xmlSApply(rootNode, xmlValue)

Get the items on the menu and prices

    xpathApply(rootNode"//name",xmlValue)
    xpathApply(rootNode"//price",xmlValue)

    myUrl <- "http://www.espn.com/nfl/team/_/name/bal/baltimore-ravens"
    doc <- htmlTreeParse(myUrl, useInternal = TRUE)
    scores <- xpathSApply(doc, "//li[@class='score']",xmlValue)
    teams <- xpathSApply(doc, "//li[@class='team-name']",xmlValue)

Reading Javascript Object Notation(JSON)  
- Lightweight data storage

    library(jsonlite)
    jsonDATA <- fromJSON("https://api.github.com/users/Zixuan-YU/repos")
    #names(jsonDATA)
    names(jsonDATA$owner)

    ##  [1] "login"               "id"                  "node_id"            
    ##  [4] "avatar_url"          "gravatar_id"         "url"                
    ##  [7] "html_url"            "followers_url"       "following_url"      
    ## [10] "gists_url"           "starred_url"         "subscriptions_url"  
    ## [13] "organizations_url"   "repos_url"           "events_url"         
    ## [16] "received_events_url" "type"                "site_admin"

    jsonDATA$owner$login

    ## [1] "Zixuan-YU" "Zixuan-YU" "Zixuan-YU" "Zixuan-YU" "Zixuan-YU" "Zixuan-YU"
    ## [7] "Zixuan-YU" "Zixuan-YU" "Zixuan-YU"

Writing data frames to JSON

    myjson <- toJSON(iris, pretty = TRUE)
    cat(myjson)

    ## [
    ##   {
    ##     "Sepal.Length": 5.1,
    ##     "Sepal.Width": 3.5,
    ##     "Petal.Length": 1.4,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 4.9,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 1.4,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 4.7,
    ##     "Sepal.Width": 3.2,
    ##     "Petal.Length": 1.3,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 4.6,
    ##     "Sepal.Width": 3.1,
    ##     "Petal.Length": 1.5,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5,
    ##     "Sepal.Width": 3.6,
    ##     "Petal.Length": 1.4,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.4,
    ##     "Sepal.Width": 3.9,
    ##     "Petal.Length": 1.7,
    ##     "Petal.Width": 0.4,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 4.6,
    ##     "Sepal.Width": 3.4,
    ##     "Petal.Length": 1.4,
    ##     "Petal.Width": 0.3,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5,
    ##     "Sepal.Width": 3.4,
    ##     "Petal.Length": 1.5,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 4.4,
    ##     "Sepal.Width": 2.9,
    ##     "Petal.Length": 1.4,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 4.9,
    ##     "Sepal.Width": 3.1,
    ##     "Petal.Length": 1.5,
    ##     "Petal.Width": 0.1,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.4,
    ##     "Sepal.Width": 3.7,
    ##     "Petal.Length": 1.5,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 4.8,
    ##     "Sepal.Width": 3.4,
    ##     "Petal.Length": 1.6,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 4.8,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 1.4,
    ##     "Petal.Width": 0.1,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 4.3,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 1.1,
    ##     "Petal.Width": 0.1,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.8,
    ##     "Sepal.Width": 4,
    ##     "Petal.Length": 1.2,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.7,
    ##     "Sepal.Width": 4.4,
    ##     "Petal.Length": 1.5,
    ##     "Petal.Width": 0.4,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.4,
    ##     "Sepal.Width": 3.9,
    ##     "Petal.Length": 1.3,
    ##     "Petal.Width": 0.4,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.1,
    ##     "Sepal.Width": 3.5,
    ##     "Petal.Length": 1.4,
    ##     "Petal.Width": 0.3,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.7,
    ##     "Sepal.Width": 3.8,
    ##     "Petal.Length": 1.7,
    ##     "Petal.Width": 0.3,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.1,
    ##     "Sepal.Width": 3.8,
    ##     "Petal.Length": 1.5,
    ##     "Petal.Width": 0.3,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.4,
    ##     "Sepal.Width": 3.4,
    ##     "Petal.Length": 1.7,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.1,
    ##     "Sepal.Width": 3.7,
    ##     "Petal.Length": 1.5,
    ##     "Petal.Width": 0.4,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 4.6,
    ##     "Sepal.Width": 3.6,
    ##     "Petal.Length": 1,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.1,
    ##     "Sepal.Width": 3.3,
    ##     "Petal.Length": 1.7,
    ##     "Petal.Width": 0.5,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 4.8,
    ##     "Sepal.Width": 3.4,
    ##     "Petal.Length": 1.9,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 1.6,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5,
    ##     "Sepal.Width": 3.4,
    ##     "Petal.Length": 1.6,
    ##     "Petal.Width": 0.4,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.2,
    ##     "Sepal.Width": 3.5,
    ##     "Petal.Length": 1.5,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.2,
    ##     "Sepal.Width": 3.4,
    ##     "Petal.Length": 1.4,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 4.7,
    ##     "Sepal.Width": 3.2,
    ##     "Petal.Length": 1.6,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 4.8,
    ##     "Sepal.Width": 3.1,
    ##     "Petal.Length": 1.6,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.4,
    ##     "Sepal.Width": 3.4,
    ##     "Petal.Length": 1.5,
    ##     "Petal.Width": 0.4,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.2,
    ##     "Sepal.Width": 4.1,
    ##     "Petal.Length": 1.5,
    ##     "Petal.Width": 0.1,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.5,
    ##     "Sepal.Width": 4.2,
    ##     "Petal.Length": 1.4,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 4.9,
    ##     "Sepal.Width": 3.1,
    ##     "Petal.Length": 1.5,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5,
    ##     "Sepal.Width": 3.2,
    ##     "Petal.Length": 1.2,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.5,
    ##     "Sepal.Width": 3.5,
    ##     "Petal.Length": 1.3,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 4.9,
    ##     "Sepal.Width": 3.6,
    ##     "Petal.Length": 1.4,
    ##     "Petal.Width": 0.1,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 4.4,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 1.3,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.1,
    ##     "Sepal.Width": 3.4,
    ##     "Petal.Length": 1.5,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5,
    ##     "Sepal.Width": 3.5,
    ##     "Petal.Length": 1.3,
    ##     "Petal.Width": 0.3,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 4.5,
    ##     "Sepal.Width": 2.3,
    ##     "Petal.Length": 1.3,
    ##     "Petal.Width": 0.3,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 4.4,
    ##     "Sepal.Width": 3.2,
    ##     "Petal.Length": 1.3,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5,
    ##     "Sepal.Width": 3.5,
    ##     "Petal.Length": 1.6,
    ##     "Petal.Width": 0.6,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.1,
    ##     "Sepal.Width": 3.8,
    ##     "Petal.Length": 1.9,
    ##     "Petal.Width": 0.4,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 4.8,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 1.4,
    ##     "Petal.Width": 0.3,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.1,
    ##     "Sepal.Width": 3.8,
    ##     "Petal.Length": 1.6,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 4.6,
    ##     "Sepal.Width": 3.2,
    ##     "Petal.Length": 1.4,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.3,
    ##     "Sepal.Width": 3.7,
    ##     "Petal.Length": 1.5,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 5,
    ##     "Sepal.Width": 3.3,
    ##     "Petal.Length": 1.4,
    ##     "Petal.Width": 0.2,
    ##     "Species": "setosa"
    ##   },
    ##   {
    ##     "Sepal.Length": 7,
    ##     "Sepal.Width": 3.2,
    ##     "Petal.Length": 4.7,
    ##     "Petal.Width": 1.4,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.4,
    ##     "Sepal.Width": 3.2,
    ##     "Petal.Length": 4.5,
    ##     "Petal.Width": 1.5,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.9,
    ##     "Sepal.Width": 3.1,
    ##     "Petal.Length": 4.9,
    ##     "Petal.Width": 1.5,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.5,
    ##     "Sepal.Width": 2.3,
    ##     "Petal.Length": 4,
    ##     "Petal.Width": 1.3,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.5,
    ##     "Sepal.Width": 2.8,
    ##     "Petal.Length": 4.6,
    ##     "Petal.Width": 1.5,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.7,
    ##     "Sepal.Width": 2.8,
    ##     "Petal.Length": 4.5,
    ##     "Petal.Width": 1.3,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.3,
    ##     "Sepal.Width": 3.3,
    ##     "Petal.Length": 4.7,
    ##     "Petal.Width": 1.6,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 4.9,
    ##     "Sepal.Width": 2.4,
    ##     "Petal.Length": 3.3,
    ##     "Petal.Width": 1,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.6,
    ##     "Sepal.Width": 2.9,
    ##     "Petal.Length": 4.6,
    ##     "Petal.Width": 1.3,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.2,
    ##     "Sepal.Width": 2.7,
    ##     "Petal.Length": 3.9,
    ##     "Petal.Width": 1.4,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5,
    ##     "Sepal.Width": 2,
    ##     "Petal.Length": 3.5,
    ##     "Petal.Width": 1,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.9,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 4.2,
    ##     "Petal.Width": 1.5,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 6,
    ##     "Sepal.Width": 2.2,
    ##     "Petal.Length": 4,
    ##     "Petal.Width": 1,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.1,
    ##     "Sepal.Width": 2.9,
    ##     "Petal.Length": 4.7,
    ##     "Petal.Width": 1.4,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.6,
    ##     "Sepal.Width": 2.9,
    ##     "Petal.Length": 3.6,
    ##     "Petal.Width": 1.3,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.7,
    ##     "Sepal.Width": 3.1,
    ##     "Petal.Length": 4.4,
    ##     "Petal.Width": 1.4,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.6,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 4.5,
    ##     "Petal.Width": 1.5,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.8,
    ##     "Sepal.Width": 2.7,
    ##     "Petal.Length": 4.1,
    ##     "Petal.Width": 1,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.2,
    ##     "Sepal.Width": 2.2,
    ##     "Petal.Length": 4.5,
    ##     "Petal.Width": 1.5,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.6,
    ##     "Sepal.Width": 2.5,
    ##     "Petal.Length": 3.9,
    ##     "Petal.Width": 1.1,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.9,
    ##     "Sepal.Width": 3.2,
    ##     "Petal.Length": 4.8,
    ##     "Petal.Width": 1.8,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.1,
    ##     "Sepal.Width": 2.8,
    ##     "Petal.Length": 4,
    ##     "Petal.Width": 1.3,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.3,
    ##     "Sepal.Width": 2.5,
    ##     "Petal.Length": 4.9,
    ##     "Petal.Width": 1.5,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.1,
    ##     "Sepal.Width": 2.8,
    ##     "Petal.Length": 4.7,
    ##     "Petal.Width": 1.2,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.4,
    ##     "Sepal.Width": 2.9,
    ##     "Petal.Length": 4.3,
    ##     "Petal.Width": 1.3,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.6,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 4.4,
    ##     "Petal.Width": 1.4,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.8,
    ##     "Sepal.Width": 2.8,
    ##     "Petal.Length": 4.8,
    ##     "Petal.Width": 1.4,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.7,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 5,
    ##     "Petal.Width": 1.7,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 6,
    ##     "Sepal.Width": 2.9,
    ##     "Petal.Length": 4.5,
    ##     "Petal.Width": 1.5,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.7,
    ##     "Sepal.Width": 2.6,
    ##     "Petal.Length": 3.5,
    ##     "Petal.Width": 1,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.5,
    ##     "Sepal.Width": 2.4,
    ##     "Petal.Length": 3.8,
    ##     "Petal.Width": 1.1,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.5,
    ##     "Sepal.Width": 2.4,
    ##     "Petal.Length": 3.7,
    ##     "Petal.Width": 1,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.8,
    ##     "Sepal.Width": 2.7,
    ##     "Petal.Length": 3.9,
    ##     "Petal.Width": 1.2,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 6,
    ##     "Sepal.Width": 2.7,
    ##     "Petal.Length": 5.1,
    ##     "Petal.Width": 1.6,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.4,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 4.5,
    ##     "Petal.Width": 1.5,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 6,
    ##     "Sepal.Width": 3.4,
    ##     "Petal.Length": 4.5,
    ##     "Petal.Width": 1.6,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.7,
    ##     "Sepal.Width": 3.1,
    ##     "Petal.Length": 4.7,
    ##     "Petal.Width": 1.5,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.3,
    ##     "Sepal.Width": 2.3,
    ##     "Petal.Length": 4.4,
    ##     "Petal.Width": 1.3,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.6,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 4.1,
    ##     "Petal.Width": 1.3,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.5,
    ##     "Sepal.Width": 2.5,
    ##     "Petal.Length": 4,
    ##     "Petal.Width": 1.3,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.5,
    ##     "Sepal.Width": 2.6,
    ##     "Petal.Length": 4.4,
    ##     "Petal.Width": 1.2,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.1,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 4.6,
    ##     "Petal.Width": 1.4,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.8,
    ##     "Sepal.Width": 2.6,
    ##     "Petal.Length": 4,
    ##     "Petal.Width": 1.2,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5,
    ##     "Sepal.Width": 2.3,
    ##     "Petal.Length": 3.3,
    ##     "Petal.Width": 1,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.6,
    ##     "Sepal.Width": 2.7,
    ##     "Petal.Length": 4.2,
    ##     "Petal.Width": 1.3,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.7,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 4.2,
    ##     "Petal.Width": 1.2,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.7,
    ##     "Sepal.Width": 2.9,
    ##     "Petal.Length": 4.2,
    ##     "Petal.Width": 1.3,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.2,
    ##     "Sepal.Width": 2.9,
    ##     "Petal.Length": 4.3,
    ##     "Petal.Width": 1.3,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.1,
    ##     "Sepal.Width": 2.5,
    ##     "Petal.Length": 3,
    ##     "Petal.Width": 1.1,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.7,
    ##     "Sepal.Width": 2.8,
    ##     "Petal.Length": 4.1,
    ##     "Petal.Width": 1.3,
    ##     "Species": "versicolor"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.3,
    ##     "Sepal.Width": 3.3,
    ##     "Petal.Length": 6,
    ##     "Petal.Width": 2.5,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.8,
    ##     "Sepal.Width": 2.7,
    ##     "Petal.Length": 5.1,
    ##     "Petal.Width": 1.9,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 7.1,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 5.9,
    ##     "Petal.Width": 2.1,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.3,
    ##     "Sepal.Width": 2.9,
    ##     "Petal.Length": 5.6,
    ##     "Petal.Width": 1.8,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.5,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 5.8,
    ##     "Petal.Width": 2.2,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 7.6,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 6.6,
    ##     "Petal.Width": 2.1,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 4.9,
    ##     "Sepal.Width": 2.5,
    ##     "Petal.Length": 4.5,
    ##     "Petal.Width": 1.7,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 7.3,
    ##     "Sepal.Width": 2.9,
    ##     "Petal.Length": 6.3,
    ##     "Petal.Width": 1.8,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.7,
    ##     "Sepal.Width": 2.5,
    ##     "Petal.Length": 5.8,
    ##     "Petal.Width": 1.8,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 7.2,
    ##     "Sepal.Width": 3.6,
    ##     "Petal.Length": 6.1,
    ##     "Petal.Width": 2.5,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.5,
    ##     "Sepal.Width": 3.2,
    ##     "Petal.Length": 5.1,
    ##     "Petal.Width": 2,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.4,
    ##     "Sepal.Width": 2.7,
    ##     "Petal.Length": 5.3,
    ##     "Petal.Width": 1.9,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.8,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 5.5,
    ##     "Petal.Width": 2.1,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.7,
    ##     "Sepal.Width": 2.5,
    ##     "Petal.Length": 5,
    ##     "Petal.Width": 2,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.8,
    ##     "Sepal.Width": 2.8,
    ##     "Petal.Length": 5.1,
    ##     "Petal.Width": 2.4,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.4,
    ##     "Sepal.Width": 3.2,
    ##     "Petal.Length": 5.3,
    ##     "Petal.Width": 2.3,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.5,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 5.5,
    ##     "Petal.Width": 1.8,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 7.7,
    ##     "Sepal.Width": 3.8,
    ##     "Petal.Length": 6.7,
    ##     "Petal.Width": 2.2,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 7.7,
    ##     "Sepal.Width": 2.6,
    ##     "Petal.Length": 6.9,
    ##     "Petal.Width": 2.3,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6,
    ##     "Sepal.Width": 2.2,
    ##     "Petal.Length": 5,
    ##     "Petal.Width": 1.5,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.9,
    ##     "Sepal.Width": 3.2,
    ##     "Petal.Length": 5.7,
    ##     "Petal.Width": 2.3,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.6,
    ##     "Sepal.Width": 2.8,
    ##     "Petal.Length": 4.9,
    ##     "Petal.Width": 2,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 7.7,
    ##     "Sepal.Width": 2.8,
    ##     "Petal.Length": 6.7,
    ##     "Petal.Width": 2,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.3,
    ##     "Sepal.Width": 2.7,
    ##     "Petal.Length": 4.9,
    ##     "Petal.Width": 1.8,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.7,
    ##     "Sepal.Width": 3.3,
    ##     "Petal.Length": 5.7,
    ##     "Petal.Width": 2.1,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 7.2,
    ##     "Sepal.Width": 3.2,
    ##     "Petal.Length": 6,
    ##     "Petal.Width": 1.8,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.2,
    ##     "Sepal.Width": 2.8,
    ##     "Petal.Length": 4.8,
    ##     "Petal.Width": 1.8,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.1,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 4.9,
    ##     "Petal.Width": 1.8,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.4,
    ##     "Sepal.Width": 2.8,
    ##     "Petal.Length": 5.6,
    ##     "Petal.Width": 2.1,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 7.2,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 5.8,
    ##     "Petal.Width": 1.6,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 7.4,
    ##     "Sepal.Width": 2.8,
    ##     "Petal.Length": 6.1,
    ##     "Petal.Width": 1.9,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 7.9,
    ##     "Sepal.Width": 3.8,
    ##     "Petal.Length": 6.4,
    ##     "Petal.Width": 2,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.4,
    ##     "Sepal.Width": 2.8,
    ##     "Petal.Length": 5.6,
    ##     "Petal.Width": 2.2,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.3,
    ##     "Sepal.Width": 2.8,
    ##     "Petal.Length": 5.1,
    ##     "Petal.Width": 1.5,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.1,
    ##     "Sepal.Width": 2.6,
    ##     "Petal.Length": 5.6,
    ##     "Petal.Width": 1.4,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 7.7,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 6.1,
    ##     "Petal.Width": 2.3,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.3,
    ##     "Sepal.Width": 3.4,
    ##     "Petal.Length": 5.6,
    ##     "Petal.Width": 2.4,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.4,
    ##     "Sepal.Width": 3.1,
    ##     "Petal.Length": 5.5,
    ##     "Petal.Width": 1.8,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 4.8,
    ##     "Petal.Width": 1.8,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.9,
    ##     "Sepal.Width": 3.1,
    ##     "Petal.Length": 5.4,
    ##     "Petal.Width": 2.1,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.7,
    ##     "Sepal.Width": 3.1,
    ##     "Petal.Length": 5.6,
    ##     "Petal.Width": 2.4,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.9,
    ##     "Sepal.Width": 3.1,
    ##     "Petal.Length": 5.1,
    ##     "Petal.Width": 2.3,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.8,
    ##     "Sepal.Width": 2.7,
    ##     "Petal.Length": 5.1,
    ##     "Petal.Width": 1.9,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.8,
    ##     "Sepal.Width": 3.2,
    ##     "Petal.Length": 5.9,
    ##     "Petal.Width": 2.3,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.7,
    ##     "Sepal.Width": 3.3,
    ##     "Petal.Length": 5.7,
    ##     "Petal.Width": 2.5,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.7,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 5.2,
    ##     "Petal.Width": 2.3,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.3,
    ##     "Sepal.Width": 2.5,
    ##     "Petal.Length": 5,
    ##     "Petal.Width": 1.9,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.5,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 5.2,
    ##     "Petal.Width": 2,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 6.2,
    ##     "Sepal.Width": 3.4,
    ##     "Petal.Length": 5.4,
    ##     "Petal.Width": 2.3,
    ##     "Species": "virginica"
    ##   },
    ##   {
    ##     "Sepal.Length": 5.9,
    ##     "Sepal.Width": 3,
    ##     "Petal.Length": 5.1,
    ##     "Petal.Width": 1.8,
    ##     "Species": "virginica"
    ##   }
    ## ]

Convert back to JSON

    iris2 <- fromJSON(myjson)
    head(iris2)

    ##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
    ## 1          5.1         3.5          1.4         0.2  setosa
    ## 2          4.9         3.0          1.4         0.2  setosa
    ## 3          4.7         3.2          1.3         0.2  setosa
    ## 4          4.6         3.1          1.5         0.2  setosa
    ## 5          5.0         3.6          1.4         0.2  setosa
    ## 6          5.4         3.9          1.7         0.4  setosa

More informations about JSON: 1) <http://www.json.org/> 2) tutorail:
<http://www.r-bloggers.com/new-package-jsonlite-a-smarter-json-encoderdecoder/>
3) jsonlite vignette

Data.table 1) written in C and much faster 2) all functions accept
data.frame work on data.table

    library(data.table)
    DT = data.table(x=rnorm(9), y=rep(c("a","b","c"),each=3), z=rnorm(9))
    head(DT,3)

    ##              x y         z
    ## 1: -0.06599164 a 0.9083333
    ## 2:  1.59981914 a 0.6042161
    ## 3:  0.44145001 a 2.2498823

    tables()

    ##    NAME NROW NCOL MB  COLS KEY
    ## 1:   DT    9    3  0 x,y,z    
    ## Total: 0MB

\#see all the data tables in memory

subsetting rows

    DT[2,]

    ##           x y         z
    ## 1: 1.599819 a 0.6042161

subsetting rows

    DT[c(2,3)]

    ##           x y         z
    ## 1: 1.599819 a 0.6042161
    ## 2: 0.441450 a 2.2498823

    #如果不加逗号，就是subsetting based on rows
    #此处需要注意！与data frame不同

subsetting columns!! DIFFERENT

    {
      x = 1
      y = 2
    }
    k = {print(10); 5}

    ## [1] 10

    print(k)

    ## [1] 5

Calculating values for variables with expressions

    DT <- data.table(x=rnorm(9), y=rep(c("a","b","c"),each=3), z = rnorm(9))
    DT

    ##             x y          z
    ## 1: -0.5643342 a -0.4645703
    ## 2:  0.1079518 a -0.7396543
    ## 3: -1.7249719 a -0.3621030
    ## 4:  0.2240548 b -1.1286545
    ## 5: -0.6067312 b  1.1318611
    ## 6:  0.3441858 b  0.3112528
    ## 7:  0.8949992 c -0.1859881
    ## 8: -0.5674394 c  0.2769630
    ## 9: -1.0322041 c -1.0920472

    DT[,list(mean(x),sum(z))]

    ##            V1        V2
    ## 1: -0.3249432 -2.252941

    DT[,table(y)]

    ## y
    ## a b c 
    ## 3 3 3

Adding new columns, using “:=”

    DT

    ##             x y          z
    ## 1: -0.5643342 a -0.4645703
    ## 2:  0.1079518 a -0.7396543
    ## 3: -1.7249719 a -0.3621030
    ## 4:  0.2240548 b -1.1286545
    ## 5: -0.6067312 b  1.1318611
    ## 6:  0.3441858 b  0.3112528
    ## 7:  0.8949992 c -0.1859881
    ## 8: -0.5674394 c  0.2769630
    ## 9: -1.0322041 c -1.0920472

    DT[,w:=z^2]

    DT2 <- DT

Multiple operations

    DT[,m:={tmp <-(x+z); log2(tmp+5)}]

plyr like operations

    DT[,a:=x>0]
    DT[,b:=mean(x+w),by=a]

Sepcial Variables .N An integer, lenth 1, containing the number

    set.seed(123);
    DT <- data.table(x=sample(letters[1:3],1E5,TRUE))
    DT[, .N, by=x]

    ##    x     N
    ## 1: c 33294
    ## 2: b 33305
    ## 3: a 33401

Keys

    DT <- data.table(x=rep(c("a","b","c"),each=100), y=rnorm(300))
    setkey(DT, x)
    DT['a']

    ##      x           y
    ##   1: a  0.88631257
    ##   2: a  2.82858132
    ##   3: a  2.03145429
    ##   4: a  1.90675413
    ##   5: a  0.21490826
    ##   6: a -0.86273413
    ##   7: a -2.20493863
    ##   8: a  0.24105923
    ##   9: a  1.83832419
    ##  10: a  0.79205468
    ##  11: a  0.65053469
    ##  12: a -1.53912061
    ##  13: a -0.60830053
    ##  14: a  0.38195644
    ##  15: a -1.07500044
    ##  16: a  0.21994264
    ##  17: a -0.78288781
    ##  18: a -1.11003346
    ##  19: a -1.65871456
    ##  20: a -0.50147343
    ##  21: a  1.91636375
    ##  22: a  1.41236645
    ##  23: a  0.92260986
    ##  24: a  1.01106201
    ##  25: a  0.57213026
    ##  26: a -0.62843126
    ##  27: a -0.36316140
    ##  28: a -1.05858811
    ##  29: a -0.42935803
    ##  30: a  0.86941467
    ##  31: a -0.54001647
    ##  32: a -1.14647747
    ##  33: a -0.17151840
    ##  34: a -0.56368340
    ##  35: a -0.42994346
    ##  36: a -1.23723779
    ##  37: a  0.15901329
    ##  38: a -1.16711067
    ##  39: a -0.08111944
    ##  40: a -0.51667953
    ##  41: a  0.99540703
    ##  42: a  0.79752142
    ##  43: a  0.53895224
    ##  44: a -1.40405605
    ##  45: a  0.40144065
    ##  46: a -0.52432237
    ##  47: a -0.83952146
    ##  48: a  0.47556591
    ##  49: a -0.01194696
    ##  50: a  0.10319780
    ##  51: a -0.38575415
    ##  52: a  1.11726438
    ##  53: a -0.49961390
    ##  54: a -0.44735091
    ##  55: a -0.23784512
    ##  56: a -0.86939374
    ##  57: a  1.14887678
    ##  58: a  0.53864996
    ##  59: a -0.10680992
    ##  60: a  0.60053649
    ##  61: a -1.47499445
    ##  62: a  0.98126964
    ##  63: a -0.61118738
    ##  64: a  0.08938648
    ##  65: a -0.01327227
    ##  66: a -0.97219341
    ##  67: a -0.57946225
    ##  68: a  0.14963144
    ##  69: a  0.47640689
    ##  70: a  0.44729682
    ##  71: a -0.19180956
    ##  72: a  0.51712710
    ##  73: a  0.40338273
    ##  74: a  1.78411385
    ##  75: a  0.27775645
    ##  76: a  0.77394978
    ##  77: a -2.08081928
    ##  78: a -0.35920889
    ##  79: a -0.45932217
    ##  80: a  0.20181947
    ##  81: a  0.62401138
    ##  82: a -0.25722981
    ##  83: a  0.94414021
    ##  84: a  0.25074808
    ##  85: a -0.72784257
    ##  86: a  0.36881323
    ##  87: a  0.44415068
    ##  88: a -1.00535422
    ##  89: a -0.33152471
    ##  90: a -0.37039325
    ##  91: a -0.79701529
    ##  92: a  0.28148559
    ##  93: a  0.33307250
    ##  94: a  0.52690325
    ##  95: a -0.78168949
    ##  96: a -0.02793948
    ##  97: a -1.74492339
    ##  98: a  0.65284209
    ##  99: a -0.93830821
    ## 100: a  0.62753159
    ##      x           y

Joins

    DT1 <- data.table(x=c("a","a","b","dt1"),y=1:4)
    DT2 <- data.table(x=c("a","b","dt2"),z=5:7)
    setkey(DT1, x)
    setkey(DT2, x)
    merge(DT1,DT2)

    ##    x y z
    ## 1: a 1 5
    ## 2: a 2 5
    ## 3: b 3 6

Fast Reading

    big_df <- data.frame(x= rnorm(1E6), y=rnorm(1E6))
    file <- tempfile()
    write.table(big_df, file = file, row.names = FALSE, col.names = FALSE, sep = "\t", quote = FALSE)
    system.time(fread(file))

    ##    user  system elapsed 
    ##    0.04    0.02    0.05

    system.time(read.table(file, header = TRUE, sep = "\t"))

    ##    user  system elapsed 
    ##    3.29    0.11    3.40

the differences with df and dt:
<https://stackoverflow.com/questions/13618488/what-you-can-do-with-a-data-frame-that-you-cant-with-a-data-table>

When you save the notebook, an HTML file containing the code and output
will be saved alongside it (click the *Preview* button or press
*Cmd+Shift+K* to preview the HTML file).

The preview shows you a rendered HTML copy of the contents of the
editor. Consequently, unlike *Knit*, *Preview* does not run any R code
chunks. Instead, the output of the chunk when it was last run in the
editor is displayed.
