## Acquire HPC Data into the local environment
setHPCData <- function() {
  require(data.table)
  theData <- fread("household_power_consumption.txt", header=FALSE, sep=";", stringsAsFactors=FALSE, na.strings = "?", skip="1/2/2007")
  colnames(theData) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  theData <- theData[theData$Date == "1/2/2007" | theData$Date == "2/2/2007",]
  
  hpcData <<- theData
}

plot2 <- function() {
  
  ## Read "household_power_consumption.txt" into hpcData once, if not already in local environment
  if (!exists("hpcData")) {
    setHPCData()
  }
  
  png("plot2.png", width=480, height=480)
  par(mar=c(4, 4, 4, 4))
  with(hpcData, plot(strptime(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"), Global_active_power, xlab="", type="l", ylab="Global Active Power (kilowatts)"))
  dev.off()
  
}