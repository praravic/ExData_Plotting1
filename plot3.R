library(data.table)

## Download and unzip the source data
if(!file.exists("data")){dir.create("data")}
if(!file.exists("data/household_power_consumption.txt")) 
{
        fileurl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileurl,destfile = "data/source.zip",mode="wb")
        unzip("data/source.zip",exdir = "data")
}
source_file = "data/household_power_consumption.txt"
##Read the complete data and subset the data for 1/2/2007 & 2/2/2007
df <- read.table(source_file,header=TRUE,sep=";",na.strings = "?")
my_df <- subset(df,df$Date %in% c("1/2/2007","2/2/2007"))
##Create a DateTime column
my_df$Date <- as.Date(my_df$Date, format = "%d/%m/%Y")
my_df$DateTime <- strptime(paste(my_df$Date,my_df$Time),format="%Y-%m-%d %H:%M:%S")

##Make needed columns numeric and create the plot
my_df$Sub_metering_1 <- as.numeric(my_df$Sub_metering_1)
my_df$Sub_metering_2 <- as.numeric(my_df$Sub_metering_2)
my_df$Sub_metering_3 <- as.numeric(my_df$Sub_metering_3)

png("plot3.png",height=480, width = 480)
plot(my_df$DateTime,my_df$Sub_metering_1,type = "l", xlab = "", ylab = "Energy sub metering")
points(my_df$DateTime,my_df$Sub_metering_2, type= "l", col = "red")
points(my_df$DateTime,my_df$Sub_metering_3, type = "l", col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"), lty = 1)
dev.off()