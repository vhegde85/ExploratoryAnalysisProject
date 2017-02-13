#Project Questions
#Compare emissions from motor vehicle sources in Baltimore City with emissions from 
#motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

# Load NEI & SCC data 
setwd("C:/Users/61310358/Documents/ExploratoryData/Project/codes")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Manipulate data as needed for the graphs
BCMD_onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
LACA_onroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

BCMD_DF <- aggregate(BCMD_onroad[, 'Emissions'], by=list(BCMD_onroad$year), sum)
colnames(BCMD_DF) <- c('year','Emissions')
BCMD_DF$City <- paste(rep('BC',4))

LACA_DF <- aggregate(LACA_onroad[, 'Emissions'], by=list(LACA_onroad$year), sum)
colnames(LACA_DF) <- c('year','Emissions')
LACA_DF$City <- paste(rep('LA',4))

BCLA_DF <- as.data.frame(rbind(BCMD_DF, LACA_DF))

# Generate the png file
png(filename='Plot6.png')

ggplot(data=BCLA_DF, aes(x=year, y=Emissions)) + 
  ggtitle('Total Emissions from Motor Vehicles in Los Angeles vs. Baltimore City') + 
  geom_bar(stat="identity", aes(fill=year)) + 
  ylab(expression('PM'[2.5])) + 
  xlab('Year') + 
  theme(legend.position='none') + 
  facet_grid(. ~ City) + 
  geom_text(aes(label=round(Emissions,0), size=2, hjust=0.5, vjust=-0.1))

dev.off()

