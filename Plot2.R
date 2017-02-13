#Project Questions
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
#from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# Load NEI & SCC data 
setwd("C:/Users/61310358/Documents/ExploratoryData/Project/codes")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Manipulate data as needed for the graphs
BCMD <- subset(NEI, fips=='24510')

# Generate the png file
png(filename='Plot2.png')

barplot(tapply(X=BCMD$Emissions, INDEX=BCMD$year, FUN=sum), 
        main='Total Emissions, Baltimore City, Maryland', 
        col = 'blue',
        xlab='Year', 
        ylab=expression('PM'[2.5]))

dev.off()
