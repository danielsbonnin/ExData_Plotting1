## Acquire HPC Data into the local environment
setHPCData <- function() {
  require(data.table)
  theData <- fread("household_power_consumption.txt", header=FALSE, sep=";", stringsAsFactors=FALSE, na.strings = "?", skip="1/2/2007")
  colnames(theData) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  theData <- theData[theData$Date == "1/2/2007" | theData$Date == "2/2/2007",]
  
  hpcData <<- theData
}

plot3 <- function() {
  require(dplyr)
  require(grDevices)
  
  ## Read "household_power_consumption.txt" into hpcData once, if not already in local environment
  if (!exists("hpcData")) {
    setHPCData()
  }
  
  png("plot3.png", width=480, height=480)
  xVar <- strptime(paste(hpcData$Date, hpcData$Time), format="%d/%m/%Y %H:%M:%S")
  par(mar=c(4, 4, 4, 4))
  with(hpcData, plot(xVar, Sub_metering_1, type="l", ylab="Energy sub metering", xlab=""))
  lines(xVar, hpcData$Sub_metering_2, col="red")
  lines(xVar, hpcData$Sub_metering_3, col="blue")
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=c(1, 1, 1),col=c("black", "red", "blue"))
  dev.off()
}