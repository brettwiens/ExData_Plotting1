if(!file.exists("household_power_consumption.txt")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","HPC.zip")
  unzip("HPC.zip", overwrite = TRUE)
}
source <- "household_power_consumption.txt"

HouseHoldPower <- read.table(source, header = TRUE, sep=";", stringsAsFactors = FALSE)

## Convert the data to numeric (from character) and dates and times to appropriate
HouseHoldPower$Global_active_power <- as.numeric(HouseHoldPower$Global_active_power)
HouseHoldPower$Voltage <- as.numeric(HouseHoldPower$Global_Voltage)
HouseHoldPower$Global_reactive_power <- as.numeric(HouseHoldPower$Global_reactive_power)
HouseHoldPower$Global_intensity <- as.numeric(HouseHoldPower$Global_intensity)
HouseHoldPower$Sub_metering_1 <- as.numeric(HouseHoldPower$Sub_metering_1)
HouseHoldPower$Sub_metering_2 <- as.numeric(HouseHoldPower$Sub_metering_2)
HouseHoldPower$Sub_metering_3 <- as.numeric(HouseHoldPower$Sub_metering_3)

## Subset the data to only include February 1 and February 2, 2007
subHHP <- subset(HouseHoldPower, Date %in% c("1/2/2007","2/2/2007"))

subHHP <- cbind(strptime(paste(subHHP$Date, subHHP$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S"), subHHP)
names(subHHP)[1] <- "dateTime"

par(mfrow = c(1,1)) # Just in case the parameter of RStudio was set to something else, this cleans it up.

## Plot 1
png("plot1.png", width = 480, height = 480)
with(subHHP, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power"))
dev.off()

## Plot 2
png("plot2.png", width = 480, height = 480)
with(subHHP, plot(dateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()

## Plot 3
png("plot3.png", width = 480, height = 480)
with(subHHP, plot(dateTime, Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering"))
with(subHHP,lines(dateTime, Sub_metering_2, type = "l", col = "red"))
with(subHHP,lines(dateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),lty=1, lwd=2.5, col=c("black","red","blue"))
dev.off()

## Plot 4
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
with(subHHP, plot(dateTime, Global_active_power, type = "l", xlab = "",ylab = "Global Active Power"))

with(subHHP, plot(dateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))

with(subHHP, plot(dateTime, Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering"))
with(subHHP,lines(dateTime, Sub_metering_2, type = "l", col = "red"))
with(subHHP,lines(dateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),lty=1, lwd=2.5, col=c("black","red","blue"))

with(subHHP, plot(dateTime, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))
dev.off()
