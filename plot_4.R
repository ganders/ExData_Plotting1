library(dplyr)

## Define utility vars
data_zip_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
data_zip_file <- "data/household_power_consumption.zip"
data_file <- "data/household_power_consumption.txt"
plot_filename = "plot_4.png"

## Make sure I have a data directory
if (!file.exists("data")) {
  dir.create("data")
}

## Make sure I have the data
if (!file.exists(data_file)) {
  download.file(data_zip_url, destfile = data_zip_file, method="curl")
  unzip(data_zip_file)
}

## Import data
data <- read.csv(data_file, 
                 sep=";", 
                 colClasses=c("Date"="character", "Time"="character"),
                 na.strings="?")

## Get just the required dates (with just the two it's easier just to do a string with OR)
data <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")

## Let's fix dates and times

### Put dates and times into vectors and paste them together
dates <- data$Date
times <- data$Time
tmp <- paste(dates, times)

### Turn them into date objects
date_times <- strptime(tmp, "%d/%m/%Y %H:%M:%S")

### Add them as the first column of the dataframe and set names
data <- cbind(date_times, data)
names(data)[1] = "Date_time"

### Remove original dates and times, no need to keep them around
data$Date = NULL
data$Time = NULL

#############
# PLOT CODE #
#############

# Open png file/device with appropriate params
png(filename=plot_filename, width=480, height=480)

# There will be 2 cols x 2 rows
par(mfrow = c(2,2))

# specify that my data will be coming from the 'data' dataframe
with(data, {

  ## Plot 1 (less "(kilowatts)")
  plot(Date_time, Global_active_power, type="l", 
       xlab="", ylab="Global Active Power")
  
  ## Plot 2
  plot(Date_time, Voltage, type="l",
       xlab="datetime", ylab="Voltage")
  
  ## Plot 3 (less border around legend)
  plot(Date_time, Sub_metering_1, col="black", type="l",
       xlab="", ylab="Energy sub metering")
  
  lines(Date_time, Sub_metering_2, col="red")
  lines(Date_time, Sub_metering_3, col="blue")
  
  legend("topright", lwd=1, bty="n",
         col=c("black", "red", "blue"),
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  ## Plot 4
  plot(Date_time, data$Global_reactive_power, type="l",
       xlab="datetime", ylab="Global_reactive_power")
  
})

# close device
dev.off()