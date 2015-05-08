library(dplyr)
library(lubridate)

data_zip_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
data_zip_file <- "data/household_power_consumption.zip"
data_file <- "data/household_power_consumption.txt"


if (!file.exists("data")) {
  dir.create("data")
}

if (!file.exists(data_file)) {
  download.file(data_zip_url, destfile = data_zip_file, method="curl")
  unzip(data_zip_file)
}

data <- read.csv(data_file, 
                 sep=";", 
                 colClasses=c("Date"="character", "Time"="character"),
                 na.strings="?")

# Let's clean up

# Get just the required dates (with just the two it's easier just to do a string with AND)
data <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")

# Let's fix dates and times
dates <- data$Date
times <- data$Time
tmp <- paste(dates, times)
date_times <- strptime(tmp, "%d/%m/%Y %H:%M:%S")
data <- cbind(date_times, data)
names(data)[1] = "Date_time"
data$Date = NULL
data$Time = NULL
