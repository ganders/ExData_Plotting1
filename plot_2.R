source("prep_data.R")

plot_2_filename = "plot_2.png"

png(filename=plot_2_filename, width=480, height=480)

plot(data$Date_time, data$Global_active_power, type="line", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()