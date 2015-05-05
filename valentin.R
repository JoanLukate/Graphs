setwd("C:/statistic/valentin/")

mycomoda <- read.csv("deployment_zeitpunkte.txt", header = TRUE, sep = ";")

#explore dataset 
str(mycomoda)

format(as.character(as.factor(mycomoda[,2])))
str(mycomoda)
head(mycomoda)
colnames(mycomoda) <- c('date')

#create new variable 'DateTime'
mycomoda$DateTime <- strptime(mycomoda$date, "%Y-%m-%d %H:%M:%S")
class(mycomoda$DateTime)
class(mycomoda$Date)

mycomoda$Date <- as.Date(mycomoda$date, format = "%Y-%m-%d")

library(ggplot2)
library(scales)

png(file = "deployment_numbers.png", width = 480, height = 480, units = "px")
qplot(DateTime, data=mycomoda, geom="histogram",binwidth=7*24*60*60,fill=I('steelblue'),col=I('black')) +
        ggtitle("Number of Deployments for MyComoda \nby month")
        ylab("Number of Deployments") + xlab("Month/Year")
dev.off()

png(file = "deployment_numbers.png", width = 960, height = 480, units = "px")
ggplot(mycomoda, aes(x=Date)) + geom_histogram(binwidth=7, colour="white") +
  scale_x_date(labels = date_format("%Y-%b"),
               breaks = seq(min(mycomoda$Date)-5, max(mycomoda$Date)+5, 30),
               limits = c(as.Date("2014-06-18"), as.Date("2015-04-08"))) +
  ggtitle("Number of Deployments for MyComoda \nbetween June 2014 and April 2015") +
  ylab("Count (Deployments)") + xlab("Year and Month") +
  theme_bw() + 
  theme(plot.title = element_text(lineheight=.8), 
        axis.text.x = element_text(angle = 90, hjust = 1),
        axis.line = element_line(colour = "black"), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), panel.border = element_blank(),
        panel.background = element_blank())
dev.off()

318/mycomoda$Date


for i in 