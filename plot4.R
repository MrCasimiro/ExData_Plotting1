library(dplyr)

if(!file.exists("elec.zip")) {
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, "elec.zip")
    unzip("elec.zip")
}
    
data2 <- read.table("household_power_consumption.txt", sep = ";", 
                    na.strings = "?", 
                    header = TRUE) %>% filter(Date == "1/2/2007" |
                                              Date == "2/2/2007")
data2$Date <- as.Date(data2$Date, format = "%d/%m/%Y")
full_data <- paste(data2$Date, data2$Time)
data2$Time <- strptime(full_data, format = "%Y-%m-%d %H:%M:%S")
    
    
    
png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2,2))
    ### Plot (1,1)
with(data2, plot(Time,Global_active_power, type = "l", xlab="",
                     ylab = "Global Active Power (kilowatts)"))
    
    ### Plot (2,1)
with(data2, plot(Time, Sub_metering_1, type = "l", xlab = "",
                 ylab = "Energy sub metering"))
lines(data2$Time, data2$Sub_metering_2, col = "red")
lines(data2$Time, data2$Sub_metering_3, col = "blue")
    
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2",                                   "Sub_metering_3"),
        lty = c(1,1,1), col = c("black", "red", "blue"), bty = "n")
    
    ### Plot (1,2)
with(data2, plot(Time, Voltage, type = "l", xlab = "datetime", yaxt = "n"))
axis(side = 2, c(234,236,238,240,242,244,246),
     labels = c(234,"",238,"",242,"",246))
    
    ### Plot (2,2)
with(data2, plot(Time, Global_reactive_power, type = "l",
                 xlab = "datetime", lty = 1))
dev.off()
    
