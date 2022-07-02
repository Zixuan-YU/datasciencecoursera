#fist paly swirl
library(swirl)
library(datasets)
data(iris)
# Then do week3 Quiz
# Question 1
# what is the mean of 'Sepal.Length' for the species virginica?
mean(iris[iris$Species == "virginica",]$Sepal.Length)

# Question 2
# what R code returns a vector of the means of the variables 'Sepal.Length', 'Sepal.Width', 'Petal.Length', and 'Petal.Width
sapply(iris[,1:4], mean)
apply(iris[,1:4], 2, mean)
colMeans(iris[,1:4])
#以上三种都ok！

# Question 3
?mtcars
data(mtcars)
#How can one calculate the average miles per gallon (mpg) by number of cylinders in the car (cyl)?
tapply(mtcars$mpg, mtcars$cyl, mean)
sapply(split(mtcars$mpg, mtcars$cyl), mean)
with(mtcars, tapply(mpg, cyl, mean))
#以上三种都ok！

# Question 4
#what is the absolute difference between the average horsepower of 4-cylinder cars and the average horsepower of 8-cylinder cars

avg_mpg <- as.numeric(tapply(mtcars$hp, mtcars$cyl, mean))
difference <- abs(avg_mpg[3] - avg_mpg[1])

# Question 5
# If you run 'debug(ls)',what happens when you next call the 'ls' function?
# Execution of 'ls' will suspend at the beginning of the function and you will be in the browser.
