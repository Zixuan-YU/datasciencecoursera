---
title: "Coursera R programming week2 notes2"
output: html_notebook
editor_options: 
  chunk_output_type: inline
---
2021/06/19 SAT

```r
y <-10
f <- function(x){
    y <- 2
    y^2 + g(x)
}
g <- function(x) {
    x*y
}
f(3)
```

```
## [1] 34
```

This shows the difference between Lexical Scoping and Dynamic Scopping.



Consequences of Lexical Scoping
1) In R, all objects must be stored in memory.
2) All functions must carry a pointer to their respective defining environments, which could be anywhere.
3) In S-PLUS, free variables are always looked up in the global workspace, so everything can be stored on the disk because the "defining environment" of all functions is the same.

Maximizing a Normal Likelihood

```r
make.NegLogLik <- function(data, fixed = c(FALSE, FALSE)){
        params <- fixed
        function(p){
              params[!fixed] <- p
              mu <- params[1]
              sigma <- params[2]
              a <- -0.5*length(data)*log(2*pi*sigma^2)
              b <- -0.5*sum((data-mu)^2 / (sigma^2))
              -(a+b)
        }
}
set.seed(1); normals <- rnorm(100, 1, 2)
nLL <- make.NegLogLik(normals)
View(nLL)
ls(environment(nLL))
```

```
## [1] "data"   "fixed"  "params"
```
看不懂，真不知道在讲啥 TAT
mark 一下网址： https://www.coursera.org/learn/r-programming/lecture/Jm1s1/scoping-rules-optimization-example-optional
文字版本：https://bookdown.org/rdpeng/rprogdatascience/scoping-rules-of-r.html#application-optimization

Coding Standards
1) Always use text files/ text editor
2) Indenting is IMPORTANT -> imporves readability
    Fixing line length(80 columns) prevents lots of nesting and vering long functions
    Suggested: Indents of 4 spaces at minimun; 8 spaces ideal

3)Limit

Dates and times
1) Date class
2) POSIXct or POSIXlt class
3) since 1970-01-01

```r
x <- as.Date("1970-01-01")
x
```

```
## [1] "1970-01-01"
```

```r
unclass(x)
```

```
## [1] 0
```

```r
unclass(as.Date("1970-01-01"))
```

```
## [1] 0
```
Current Time

```r
Sys.time()
```

```
## [1] "2021-06-19 14:28:48 CST"
```


```r
p <- as.POSIXlt(x)
names(unclass(p))
```

```
## [1] "sec"   "min"   "hour"  "mday"  "mon"   "year"  "wday"  "yday" 
## [9] "isdst"
```

```r
x$sec
```

```
## Error in x$sec: $ operator is invalid for atomic vectors
```

```r
p$sec
```

```
## [1] 0
```
Use strptime function in case your dates are written in a different format

```r
datestring <- c("January 10, 2012 10:40", "December 9, 2011 9:10")
x <- strptime(datestring, "%B %d, %Y %H:%M")
x
```

```
## [1] "2012-01-10 10:40:00 CST" "2011-12-09 09:10:00 CST"
```

if you can not remember formatting strings

```r
?strptime
```

Operations on Dates and Times

```r
x <- as.Date("2012-01-01")
y <- strptime("9 Jan 2011 11:34:21", "%d %b %Y %H:%M:%S")
y
```

```
## [1] "2011-01-09 11:34:21 CST"
```
Showing the difference betwen x and y

```r
x <- as.POSIXlt(x)
x-y
```

```
## Time difference of 356.8511 days
```
Different Time Zones

```r
x <- as.Date("2012-03-01")
y <- as.Date("2012-02-28")
x- y
```

```
## Time difference of 2 days
```

```r
m <- as.POSIXct("2012-10-25 01:00:00")
n <- as.POSIXct("2012-10-25 06:00:00", tz = "GMT")
n - m
```

```
## Time difference of 13 hours
```
? What are free variables

```r
f <- function(){
    x+1
}
f()
```

```
## [1] "2012-03-02"
```
Here x is a free variable since its value is not defined within function f.
references: https://bookdown.org/rdpeng/rprogdatascience/scoping-rules-of-r.html


```r
 f <- function(x, y) {
         x^2 + y / z
 }
f(2,3)
```

```
## [1] 7
```

```r
z <- 1
f(2,3)
```

```
## [1] 7
```
This function has 2 formal arguments x and y. In the body of the function there is another symbol z. In this case z is called a free variable.

The scoping rules of a language determine how values are assigned to free variables. Free variables are not formal arguments and are not local variables (assigned insided the function body).

Lexical scoping in R has consequences beyond how free variables are looked up. In particular, it’s the reason that all objects must be stored in memory in R. This is because all functions must carry a pointer to their respective defining environments, which could be anywhere. In the S language (R’s close cousin), free variables are always looked up in the global workspace, so everything can be stored on the disk because the “defining environment” of all functions is the same.

批量读取文件时， 文件名通常为“001.csv”，“002.csv”，如何补齐0？
参考资料：R语言数字格式 https://blog.csdn.net/weixin_40628687/article/details/88866178


```r
setwd("/Users/zixuanyu/R_Projects/datasciencecoursera/specdata")
cal_vec <- c()
pollutant <- "nitrate"  #or "sulfate"
for (i in 1:100){
        idx = sprintf("%03d",i)  #此处如果改成%04d 就会补全成0001，0002，etc
        filenmae <- paste(idx,".csv", sep = "")
        df <- read.csv(filenmae) %>% data.frame()
        cal_vec <- c(cal_vec, df[,pollutant])
}
output_mean <- mean(cal_vec, na.rm = TRUE)
```


