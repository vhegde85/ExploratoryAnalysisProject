#Project Questions
#Across the United States, how have emissions from coal combustion-related sources 
#changed from 1999-2008?

# Load NEI & SCC data 
setwd("C:/Users/61310358/Documents/ExploratoryData/Project/codes")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Manipulate data as needed for the graphs
SCC_coal = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]
merge <- merge(x=NEI, y=SCC_coal, by='SCC')
merge_agg <- aggregate(merge[, 'Emissions'], by=list(merge$year), sum)
colnames(merge_agg) <- c('Year', 'Emissions')

# Generate the png file
png(filename='Plot4.png')

ggplot(data=merge_agg, aes(x=Year, y=Emissions/1000)) + 
  ggtitle(expression('Total Emissions of PM'[2.5])) + 
  geom_line(aes(group=1, col=Emissions)) + 
  geom_point(aes(size=3, col=Emissions)) + 
  ylab(expression(paste('PM', ''[2.5], ' , kilotons'))) + 
  geom_text(aes(label=round(Emissions/1000,digits=2), size=3, hjust=-0.1, vjust=2)) + 
  theme(legend.position='none') + 
  scale_colour_gradient(low='red', high='green')

dev.off()
