
createplot <- function()
{
# Load Required Libraries
library(sqldf)
library(tcltk)
#Read all data from File.
tbl1<-read.table("household_power_consumption.txt",header=TRUE,stringsAsFactors=FALSE,sep=';')
#Read data only for "1st and 2nd Feb 2007"
tbl2<-tbl1[(tbl1$Date=="1/2/2007" | tbl1$Date=="2/2/2007"),]
# free up memory
rm(tbl1)
#Convert some columns to numeric datatype.
tbl2[,3]<-as.numeric(tbl2[,3])
tbl2[,4]<-as.numeric(tbl2[,4])
tbl2[,5]<-as.numeric(tbl2[,5])
tbl2[,7]<-as.numeric(tbl2[,7])
tbl2[,8]<-as.numeric(tbl2[,8])

#Create Plot 1
png("plot1.png",width=480,height=480) # Open png file
hist(tbl2$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off() # Close File

#Create a date & time variable
dateTime   <- as.POSIXlt(paste(as.Date(tbl2$Date, format="%d/%m/%Y"), tbl2$Time, sep=" "))

# Create Plot 2
png("plot2.png",width=480,height=480) #Open png file
with(tbl2,plot(dateTime,tbl2$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))
dev.off() # Close File

# Create Plot 3 
png("plot3.png",width=480,height=480) # Open png file
with(tbl2,plot(dateTime,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering"))
with(tbl2,lines(dateTime,Sub_metering_1,col="black"))
with(tbl2,lines(dateTime,Sub_metering_2,col="red"))
with(tbl2,lines(dateTime,Sub_metering_3,col="blue"))
legend("topright",lty=c(1,1,1),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"))
dev.off() # Close File

# Create Plot 4
png("plot4.png",width=480,height=480) # Open png file
par(mfrow=c(2,2))
#Plot 4.1
with(tbl2,plot(dateTime,tbl2$Global_active_power,type="l",xlab="",ylab="Global Active Power"))
#Plot 4.2
with(tbl2,plot(dateTime,tbl2$Voltage,type="l",xlab="datetime",ylab="Voltage"))
#Plot 4.3
with(tbl2,plot(dateTime,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering"))
with(tbl2,lines(dateTime,Sub_metering_1,col="black"))
with(tbl2,lines(dateTime,Sub_metering_2,col="red"))
with(tbl2,lines(dateTime,Sub_metering_3,col="blue"))
legend("topright",lty=c(1,1,1),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"))
#Plot4.4
with(tbl2,plot(dateTime,tbl2$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power"))
dev.off() # Close File
}
