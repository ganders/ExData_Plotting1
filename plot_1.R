source("prep_data.R")

plot_1_filename = "plot_1.png"

png(filename=plot_1_filename, width=480, height=480)

hist(data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", col="red")

dev.off()