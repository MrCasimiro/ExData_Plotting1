plot2 <- function() {
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
    
    png(filename = "plot2.png", width = 480, height = 480)
    with(data2, plot(Time,Global_active_power, type = "l", xlab="",
                        ylab = "Global Active Power (kilowatts)"))
    dev.off()
}