#Project Question
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
#for each of the years 1999, 2002, 2005, and 2008.

# Load NEI & SCC data 
setwd("C:/Users/61310358/Documents/ExploratoryData/Project/codes")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Manipulate data as needed for the graphs
Em <- aggregate(NEI[, 'Emissions'], by=list(NEI$year), FUN=sum)
Em$PM <- round(Em[,2]/1000,2)

# Generate the png file

png(filename='Plot1.png')

barplot(Em$PM, names.arg=Em$Group.1, 
        main=expression('Total Emissions of PM'[2.5]),
        col= 'blue',
        xlab='Year', 
        ylab=expression(paste('PM', ''[2.5], ' , kilotons')))

dev.off()

