library(data.table)

## Download and unzip the source data
if(!file.exists("data")){dir.create("data")}
fileurl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,destfile = "data/source.zip",mode="wb")
unzip("data/source.zip",exdir = "data")
source_file = "data/household_power_consumption.txt"
##Read the complete data and subset the data for 1/2/2007 & 2/2/2007
df <- read.table(source_file,header=TRUE,sep=";",na.strings = "?")
my_df <- subset(df,df$Date %in% c("1/2/2007","2/2/2007"))
##Create a DateTime column
my_df$Date <- as.Date(my_df$Date, format = "%d/%m/%Y")
my_df$DateTime <- strptime(paste(my_df$Date,my_df$Time),format="%Y-%m-%d %H:%M:%S")

##Make needed columns numeric and create the plot
my_df$Global_active_power<-as.numeric(my_df$Global_active_power)
png("plot2.png", height = 480, width = 480)
plot(my_df$DateTime,my_df$Global_active_power,type = "l",xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()