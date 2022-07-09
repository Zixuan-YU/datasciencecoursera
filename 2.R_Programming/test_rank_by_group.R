g <- gl(4, 5)
x <- sample(20)
d <- data.frame(g, x)

d$xrank <- ave(d$x, d$g, FUN = rank)
d[d$xrank==2,]

outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
outcome$my_rank <- lapply(outcome$State,as.numeric(outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack),rank)
new <- outcome[,c("State","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack","my_rank")]
as.nu