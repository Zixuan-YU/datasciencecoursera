#Data scouce: http://hospitalcompare.hhs.gov
setwd("~/R_Projects/datasciencecoursera/rprog-ProgAssignment3-hospital")
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
hospital <- read.csv("hospital-data.csv")

#1 Plot the 30-day mortality rates for heart attack
outcome[,11] <- as.numeric(outcome[,11])
## Because we originally read the data in as character (by specifying colClasses = "character" we need to coerce the column to be numeric. 
## You may get a warning about NAs being introduced; that is okay
hist(outcome[,11])


#2 Finding the best hospital in a state
#11. Hospital 30-Day Death (Mortality) Rates from Heart Attack: Lists the risk adjusted rate (percentage) for each hospital.
#7. State: varchar (2) Lists the 2 letter State code in which the hospital is located.
library(dplyr)
library(stringr)

# Heart.Attack mortality rate NA = NA
#Note that pneumonia/Heart.Failure mortality rate NA = "Not Available"

a <- tapply(na.omit(without_m_NA[,11]), without_m_NA$State,mean)
best <- function(state, tr){
    if((state %in% outcome$State)&(tr %in% c("heart attack","heart failure","pneumonia"))){
        if(tr == "heart attack"){
            rate <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
        }else if(tr == "heart failure"){
            rate <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
        }else if(tr == "pneumonia"){
            rate <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
        }
      f <- outcome[outcome$State==state,c("Hospital.Name",rate)]
      g <- f[order(f$Hospital.Name),] #先按照医院名称的字母表顺序排序，再按照rate
      k <- g[order(as.numeric(g[,rate])),]
      #order排序的话，NA/ Not Available这种奇奇怪怪的东西默认是在最后面的
      result <- k[1,1]
    }else if(!state %in% outcome$State){
      result <- 'Error in best(\"BB", "heart attack") : invalid state'
    }else if(!tr %in% c("heart attack","heart failure","pneumonia")){
      result <- 'Error in best(\"NY\", "hert attack") : invalid outcome'
    }
print(result)  
}

b <- outcome %>% select(Hospital.Name,State, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
# tapply(b$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,b$State, rank) #根据各个state排序


state = "MD"
tr = "pneumonia" #输入为全小写，需要转换为首字母大写，用“str_to_title”
best <- function(state, tr){
rate <- paste("Hospital.30.Day.Death..Mortality..Rates.from.",str_to_title(tr, locale = "EN"), sep = "")
f <- outcome[outcome$State==state,c("Hospital.Name","State",rate)] 
g <- f[order(f$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia),] #order排序的话，NA/ Not Available这种奇奇怪怪的东西默认是在最后面的
g
}
c("Hospital.Name","State",rate)
k <- outcome[order(outcome$Hospital.Name),] 
m <- k[order(k$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack),]
j <- m[,c("Hospital.Name","State","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack")] 
s <- outcome %>% arrange(Hospital.Name, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)




#Ranking hospitals by outcome in a state

rankhospital <- function(state, tr, num = "best") {
  ## Read outcome data
  if((state %in% outcome$State)&(tr %in% c("heart attack","heart failure","pneumonia"))){
    if(tr == "heart attack"){
      rate <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
    }else if(tr == "heart failure"){
      rate <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
    }else if(tr == "pneumonia"){
      rate <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
    }
    f <- outcome[outcome$State==state,c("Hospital.Name",rate)]
    g <- f[order(f$Hospital.Name),] #先按照医院名称的字母表顺序排序，再按照rate
    k <- g[order(as.numeric(g[,rate])),]
    #order排序的话，NA/ Not Available这种奇奇怪怪的东西默认是在最后面的
    if(num == "best"){num=1
    }else if(num == "worst"){num = length(k)}
    result <- k[num,1]
  }else if(!state %in% outcome$State){
    result <- 'Error in best(\"BB", "heart attack") : invalid state'
  }else if(!tr %in% c("heart attack","heart failure","pneumonia")){
    result <- 'Error in best(\"NY\", "hert attack") : invalid outcome'
  }
print(result)  
}



rank_by_state <- function(tr, num = "best") {
  ## Read outcome data
  if((state %in% outcome$State)&(tr %in% c("heart attack","heart failure","pneumonia"))){
    if(tr == "heart attack"){
      rate <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
    }else if(tr == "heart failure"){
      rate <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
    }else if(tr == "pneumonia"){
      rate <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
    }
    f <- outcome[outcome$State==state,c("Hospital.Name",rate)]
    g <- f[order(f$Hospital.Name),] #先按照医院名称的字母表顺序排序，再按照rate
    k <- g[order(as.numeric(g[,rate])),]
    #order排序的话，NA/ Not Available这种奇奇怪怪的东西默认是在最后面的
    if(num == "best"){num=1
    }else if(num == "worst"){num = length(k)}
    result <- k[num,1]
  }else if(!state %in% outcome$State){
    result <- 'Error in best(\"BB", "heart attack") : invalid state'
  }else if(!tr %in% c("heart attack","heart failure","pneumonia")){
    result <- 'Error in best(\"NY\", "hert attack") : invalid outcome'
  }
result
}

#Ranking hospitals in all states
rankall <- function(outcome, num = "best") {
  ## Read outcome data
}
## Check that state and outcome are valid
## For each state, find the hospital of the given rank
## Return a data frame with the hospital names and the
## (abbreviated) state name
apply(split(outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, outcome$State), rank)

f <- outcome[,c("State","Hospital.Name","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack")]
t <- f %>% group_by(State) %>% mutate(my_ranks = order(order(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,State)))
order(t$my_ranks)

res <- iris %>%
  dplyr::group_by(Species) %>%
  dplyr::arrange(dplyr::desc(Sepal.Length)) %>%
  rank_in_group(.)

# display first few results
res %>%
  dplyr::filter(rank <= 3)

