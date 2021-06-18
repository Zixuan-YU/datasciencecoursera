x0 <-1 
to1 <-le-8

repeat{
      x1 <- computeEstimate() #It is not a real function
      
      if(abs(x1 - x0) < to1){
            break
      } else {
              x0 <- x1   
      }
}


## next
s = 0
for (i in 1:100) {
    if (i <= 20) {
              next
    }
    s = s + 1
}

#function: add 2 numbers together
add2 <- function(x, y){
        x + y
}

#show elements in a list that is greater than n
above <- function(x,n=10) {
        use <- x>n
        x[use]
}

#write a function that will calculate the mean of all the columns
y <- matrix(1:12, ncol = 3)
colmean <- function(y, removeNA = TRUE){
      nc <- ncol(y)
      means <- numeric(nc)
      for (i in 1:nc){
            means[i] <- mean(y[,i], na.rm = removeNA)
      }
      means
}

# The "..." Argument

