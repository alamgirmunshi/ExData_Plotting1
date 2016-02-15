## Question 2: 
## Exploratory Data Analysis - Project 2
## Alamgir Munshi

## Loading downloaded data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Creating Sample
## NEI_sample <- NEI[sample(nrow(NEI), size=2000, replace=F), ]

## Subset data and append two years in one data frame
MD <- subset(NEI, fips=='24510')

## Question 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
## from 1999 to 2008? Use the base plotting system to make a plot answering this question.

## Generate the graph
png(filename='plot2.png')

barplot(tapply(X=MD$Emissions, INDEX=MD$year, FUN=sum), 
        main='Total Emission in Baltimore City, MD (fips == "24510")', 
        xlab='Year', ylab=expression('PM'[2.5]))
## Close graphic device
dev.off()