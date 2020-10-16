#Create temp variable for zip read
temp <- tempfile()

#download and read the data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";",  header=TRUE, na.strings = "?", 
                   colClasses = c('character',
                                  'character',
                                  'numeric',
                                  'numeric',
                                  'numeric',
                                  'numeric',
                                  'numeric',
                                  'numeric',
                                  'numeric'))

unlink(temp)

#convert date column
data$Date = as.Date(data$Date, "%d/%m/%Y")

#filter data by dates
data = subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

#create new column with 
data$dateTime = paste(data$Date, data$Time)
data$dateTime = strptime(data$dateTime,"%Y-%m-%d %H:%M:%S")

#Create png file with the plot
png("plot4.png", height = 480, width = 480)
par(mfrow = c(2, 2))
plot(data$dateTime, data$Global_active_power, xlab = '', ylab = 'Global Active Power', type = 'l')
plot(data$dateTime, data$Voltage, xlab = 'datetime', ylab = 'Voltage', type = 'l')
plot(data$dateTime, data$Sub_metering_1, xlab = '', ylab = 'Energy sub metering', type = 'l')
lines(data$dateTime, data$Sub_metering_2, col = 'red')
lines(data$dateTime, data$Sub_metering_3, col = 'blue')
legend('topright', col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd = 1)
plot(data$dateTime, data$Global_reactive_power, xlab = 'datetime', ylab = 'Global_reactive_power', type = 'l')
dev.off()