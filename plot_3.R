source("prep_data.R")

plot_3_filename = "plot_3.png"

png(filename=plot_3_filename, width=480, height=480)

plot(data$Date_time, data$Sub_metering_1, col="black", type="l",
     xlab="", ylab="Energy sub metering")

lines(data$Date_time, data$Sub_metering_2, col="red")
lines(data$Date_time, data$Sub_metering_3, col="blue")

legend("topright", lwd=1, col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()