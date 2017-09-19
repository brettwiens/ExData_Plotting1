if(!file.exists("household_power_consumption.txt")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","HPC.zip")
  unzip("HPC.zip", overwrite = TRUE)
}
  source <- "household_power_consumption.txt"
  
HouseHoldPower <- read.table(source, header = TRUE, sep=";", stringsAsFactors = FALSE)

## Convert the data to numeric (from character) and dates and times to appropriate
HouseHoldPower$Global_active_power <- as.numeric(HouseHoldPower$Global_active_power)
HouseHoldPower$Voltage <- as.numeric(HouseHoldPower$Voltage)
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