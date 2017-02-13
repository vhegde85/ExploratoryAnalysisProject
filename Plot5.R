#Project Questions
#How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Load NEI & SCC data 
setwd("C:/Users/61310358/Documents/ExploratoryData/Project/codes")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Manipulate data as needed for the graphs
NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))
BCMD_onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')
BCMD_DF <- aggregate(BCMD_onroad[, 'Emissions'], by=list(BCMD_onroad$year), sum)
colnames(BCMD_DF) <- c('year', 'Emissions')

# Generate the png file
png(filename='Plot5.png')

ggplot(data=BCMD_DF, aes(x=year, y=Emissions)) +  
  ggtitle('Total Emissions from Motor Vehicles in Baltimore City, Maryland') + 
  geom_bar(stat="identity", aes(fill=year)) +
  ylab(expression('PM'[2.5])) + xlab('Year') + 
  geom_text(aes(label=round(Emissions,0), size=2, hjust=0.5, vjust=-0.1)) +
  theme(legend.position='none') 

dev.off()

