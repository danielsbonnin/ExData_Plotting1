## Acquire HPC Data into the local environment
setHPCData <- function() {
  require(data.table)
  theData <- fread("household_power_consumption.txt", header=FALSE, sep=";", stringsAsFactors=FALSE, na.strings = "?", skip="1/2/2007")
  colnames(theData) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  theData <- theData[theData$Date == "1/2/2007" | theData$Date == "2/2/2007",]
  
  hpcData <<- theData
}

## Produce a grid of four graphs
plot4 <- function() {
  require(dplyr)
  require(grDevices)
  
  ## Read "household_power_consumption.txt" into hpcData once, if not already in local environment
  if (!exists("hpcData")) {
    setHPCData()
  }
  
  png("plot4.png", width=480, height=480)
  xVar <- strptime(paste(hpcData$Date, hpcData$Time), format="%d/%m/%Y %H:%M:%S")
  par(mfrow = c(2, 2))
  plot(xVar, hpcData$Global_active_power, type="l", ylab="Global Active Power", xlab="")
  plot(xVar, hpcData$Voltage, ylab="Voltage", xlab="datetime", type="l")
  plot(xVar, hpcData$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
  lines(xVar, hpcData$Sub_metering_2, col="red")
  lines(xVar, hpcData$Sub_metering_3, col="blue")
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=c(1, 1, 1),col=c("black", "red", "blue"))
  plot(xVar, hpcData$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
  dev.off()
}