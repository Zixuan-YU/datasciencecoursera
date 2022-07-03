##plot3
power <- read.table('C:/REPO/datasciencecoursera/4.Exploratory_Data_Analysis/exdata_data_household_power_consumption/household_power_consumption.txt', sep = ";", header = T,na.strings="?")

library(lubridate)
power <- power %>% mutate(exact_time = paste(Date, Time, sep=" "))

library(dplyr)
library(tidyverse)
power$exact_time2 <- lubridate::ymd_hms(power$exact_time)
dat <- power %>% filter(Date %in% c(as.Date("2007-02-01"),as.Date("2007-02-02")))

png("plot3.png")
plot(dat$exact_time2,
     dat$Sub_metering_1,
     type="l",
     xlab="",
     ylab="Energy sub metering")
lines(dat$exact_time2,
      dat$Sub_metering_2,
      type="l",
      col = "red")
lines(dat$exact_time2,
      dat$Sub_metering_3,
      type="l",
      col = "blue")
legend(x = "topright",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = 1,
       lwd = 2.5,
       col = c("black","red","blue"))
dev.off()  