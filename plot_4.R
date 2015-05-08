source("prep_data.R")

plot_4_filename = "plot_4.png"

png(filename=plot_4_filename, width=480, height=480)

par(mfrow = c(2,2))

with(data, {

  ## Plot 1
  plot(Date_time, Global_active_power, type="l", 
       xlab="", ylab="Global Active Power")
  
  ## Plot 2
  plot(Date_time, Voltage, type="l",
       xlab="datetime", ylab="Voltage")
  
  ## Plot 3
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

dev.off()