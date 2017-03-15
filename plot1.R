## Acquire HPC Data into the local environment
setHPCData <- function() {
  require(data.table)
  require(dplyr)
  theData <- fread("household_power_consumption.txt", header=FALSE, sep=";", stringsAsFactors=FALSE, na.strings = "?", skip="1/2/2007")
  colnames(theData) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  theData <- theData[theData$Date == "1/2/2007" | theData$Date == "2/2/2007",]
  
  hpcData <<- theData
}

## Produce a histogram that displays a formatted histogram of Global Active Power
plot1 <- function() {
  
  ## Read "household_power_consumption.txt" into hpcData once, if not already in local environment
  if (!exists("hpcData")) {
    setHPCData()
  } 
  
  png(file = "plot1.png")
  
  hist(hpcData$Global_active_power, xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")
  dev.off()
  
}
