##plot2
power <- read.table('C:/REPO/datasciencecoursera/4.Exploratory_Data_Analysis/exdata_data_household_power_consumption/household_power_consumption.txt', sep = ";", header = T,na.strings="?")

library(lubridate)
power <- power %>% mutate(exact_time = paste(Date, Time, sep=" "))

library(dplyr)
library(tidyverse)
power$exact_time2 <- lubridate::ymd_hms(power$exact_time)
dat <- power %>% filter(Date %in% c(as.Date("2007-02-01"),as.Date("2007-02-02")))

png("plot2.png")
plot(dat$exact_time2,
     dat$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kW)")
dev.off()