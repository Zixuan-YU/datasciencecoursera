## plot1
power <- read.table('C:/REPO/datasciencecoursera/4.Exploratory_Data_Analysis/exdata_data_household_power_consumption/household_power_consumption.txt', sep = ";", header = T,na.strings="?")
str(power)

library(lubridate)
power <- power %>% mutate(exact_time = paste(Date, Time, sep=" "))
head(power$exact_time)

library(dplyr)
library(tidyverse)
power$exact_time2 <- lubridate::ymd_hms(power$exact_time)
dat <- power %>% filter(Date %in% c(as.Date("2007-02-01"),as.Date("2007-02-02")))
head(dat)


png("plot1.png")
hist(as.numeric(dat$Global_active_power),
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     xlim = c(0,6),
     col = "red")
dev.off()
