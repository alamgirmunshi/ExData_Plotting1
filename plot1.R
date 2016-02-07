## plot1.R
##
## Generate the first plot required for Project 1. The plot is a histogram
## of global active power in kilowatts.
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
## create plot1.png file
png(plotFilePath("plot1.png"),
    width=480,
    height=480)

hist(dta$Global_active_power,
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     col="red")
dev.off()