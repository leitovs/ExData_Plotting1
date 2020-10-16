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

#Create png file with the plot
png("plot1.png", height = 480, width = 480)
hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()