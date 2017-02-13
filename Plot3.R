#Project Questions
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
#variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008?
#Use the ggplot2 plotting system to make a plot answer this question.

# Load NEI & SCC data 
setwd("C:/Users/61310358/Documents/ExploratoryData/Project/codes")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Manipulate data as needed for the graphs
BCMD <- subset(NEI, fips == 24510)
BCMD$year <- factor(BCMD$year, levels=c('2008', '2005', '2002', '1999'))

# Generate the png file

png(filename='Plot3.png')

ggplot(data=BCMD, aes(x=year, y=log(Emissions))) + 
  ggtitle('Emissions by type in Baltimore City, Maryland') +
  ylab(expression(paste('Log', ' (PM'[2.5], ' Emissions)'))) + 
  xlab('Year') + 
  facet_grid(. ~ type) + 
  guides(fill=F) +
  geom_boxplot(aes(fill=type)) + 
  stat_boxplot(geom ='errorbar') +
  geom_jitter(alpha=0.10)

dev.off()

