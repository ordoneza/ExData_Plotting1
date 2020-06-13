##Downloading data file
        url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        temp<-tempfile()
        download.file(url, temp)
        unzip(temp)
        unlink(temp)

## Reading data and adding variable names
        df<-read.csv("household_power_consumption.txt")
        names(df)<-c("Date", "Time", "Global_active_power", 
                     "Global_reactive_power", "Voltage", "Global_intensity", 
                     "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

##Subset specific dates: 1/2/2007-2/2/2007
        data<-subset(df, Date=="1/2/2007"|Date=="2/2/2007")

##Format Date and Time
        data$Date<-as.Date(data$Date, format="%d/%m/%Y")
        datetime<-paste(as.Date(data$Date), data$Time)
        data$Datetime<-as.POSIXct(datetime)

## Plotting the sub metering data
        with(data, plot(Sub_metering_1~Datetime, type="l", 
                        ylab="Energy sub metering", xlab="Day", 
                        main="Energy Sub Metering"))
        with(data, lines(Sub_metering_2~Datetime, type="l", col="red"))
        with(data, lines(Sub_metering_3~Datetime, type="l", col="blue"))
        legend("topright", lty = 1, col=c("black", "red","blue"), 
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
