# This is the code to generate plot 3
# Plot 3 is an xy plot of Energy Sub Metering throughout the day

# Download the dataset “Individual household electric power 
# consumption Data Set” from the UC Irvine Machine Learning Repository
# This link is stored on the Coursera homepage for the EDA course
data_file = "exdata_household_power_consumption.zip"
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = data_file)
# Read the data specifying the appropriate column types and NA code
power <- read.table(unz(data_file, filename = "household_power_consumption.txt"),
                    sep=";", header=TRUE, as.is= TRUE, na.strings = "?",
                    colClasses = c("character", "character", "numeric",
                                   "numeric", "numeric", "numeric",
                                   "numeric", "numeric", "numeric"))
# Convert Date and Time
power$datetime <- strptime(paste(power$Date, power$Time), 
                           format = "%d/%m/%Y %H:%M:%S")
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
# View summary to check the results
summary(power)
# Select only observations from the first two days of Feb 2007
power2 <- subset(power, Date == "2007-02-01" | Date == "2007-02-02")

# Open the png device
png(filename = "plot3.png")
# Create plot of energy sub metering
with(power2, plot(datetime, Sub_metering_1, 
                  ylab = "Energy sub metering",
                  xlab="", type = "n"))
with(power2, lines(datetime, Sub_metering_1))
with(power2, lines(datetime, Sub_metering_2, col="red"))
with(power2, lines(datetime, Sub_metering_3, col="blue"))
legend("topright", col=c("black","red","blue"), lty = 1,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()


