rm(list=ls())
getwd()

#unzip
zipfile<- "~/Downloads/extemp_temp_household_power_consumption.zip"
outDir<-"~/Desktop/programmingW1"
unzip(zipfile,exdir=outDir)

#load file
temp <- read.table("~/Desktop/programmingW1/household_power_consumption.txt", skip=1,sep=";")
View(temp)

#names taken from the programming assignment page 
#https://www.coursera.org/learn/exploratory-temp-analysis/peer/ylVFo/course-project-1
names(temp) <- c("Date","Time","Global_active_power","Global_reactive_power",
                  "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2",
                  "Sub_metering_3")
View(temp)
dim(temp)

#from https://www.coursera.org/learn/exploratory-temp-analysis/peer/ylVFo/course-project-1
#"We will only be using temp from the dates 2007-02-01 and 2007-02-02"
data <- subset(temp, temp$Date=="1/2/2007" | temp$Date =="2/2/2007")
View(data)
dim(data)

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$Time <- strptime(data$Time, format="%H:%M:%S")
#2880 entries
data[1:1440,"Time"] <- format(data[1:1440,"Time"],"2007-02-01 %H:%M:%S")
data[1441:2880,"Time"] <- format(data[1441:2880,"Time"],"2007-02-02 %H:%M:%S")
View(data)

#third plot
png("~/Desktop/programmingW1/plot3.png", width=480, height=480)

plot(data$Time,data$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
with(data,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(data,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(data,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
title(main="Energy sub-metering")

dev.off()
