## plot3.R
##
## Generate the third plot required for Project 1. The plot is a line plot
## of sub-metering data, one line per submeter type.
 
## Load common declarations and functions
## Set data directory
dataDir <- "./data"
## Set plot directory
plotsDir <- "./plots"
## Unzipped file location setup
unzippedDataFile <- file.path(dataDir, "household_power_consumption.txt")
## Read data from flat file
dta <- read.delim(unzippedDataFile, sep = ";", na.strings="?",  stringsAsFactors = FALSE)
## Create a formatted date column
dta$DateObj  <- as.Date(dta$Date, format="%d/%m/%Y")
## Get only the subset for 2 days
dta <- subset(dta, "2007-02-01" <= DateObj & DateObj <= "2007-02-02")
# Combine date and time into one column.
dta$DateTime <- strptime(paste(dta$Date, dta$Time), format="%d/%m/%Y %H:%M:%S")

dta$DateTime <- as.POSIXct(dta$DateTime)
dta <- dta[order(dta$DateTime),]

prepareForPlots <- function() {
  if (!file.exists(plotsDir)) {
    writeLines(paste("Creating", plotsDir))
    dir.create(plotsDir)
    
  }
}
prepareForPlots()

plotFilePath <- function(plotName) {
  file.path(plotsDir, plotName)
}
# Open PNG file
png(plotFilePath("plot3.png"),
    width=480,
    height=480)

# Generate sub_metering plots.
with(dta, {
  # Initial line plot with Sub_metering_1 data
  plot(DateTime, Sub_metering_1, type="l", 
       xlab="", ylab="Energy sub metering") 
  
  # Now add the other sub-metering data with more lines
  lines(DateTime, Sub_metering_2, col="red")
  lines(DateTime, Sub_metering_3, col="blue")
  
  # Create the legend in the upper right, setting line width (required)
  # and the colors appropriately for the legend labels.
  legend("topright",
         legend=c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"),
         lwd=1,
         col=c("black", "red", "blue")
  )
})

# Close PNG file
dev.off()