## First load the power data from 2007-02-01 to 2007-02-02
pwr <- read.table("household_power_consumption.txt", stringsAsFactors = FALSE,
                  header = TRUE, sep=";", na.strings = "?")

## Convert dates to Date objects to for subsetting
pwr <- subset(pwr, as.Date(Date, "%d/%m/%Y") == "2007-02-01" |
                  as.Date(Date, "%d/%m/%Y") == "2007-02-02")

## Convert dates and times to DateTime col
pwr$DateTime <- paste(pwr$Date, pwr$Time)
pwr$DateTime <- strptime(pwr$DateTime, "%d/%m/%Y %H:%M:%S")

## We need to convert cols to numeric to plot them
pwr$Global_active_power <- as.numeric(pwr$Global_active_power)

## Set the format and name for the first plot and all lines
png(file = "plot3.png", width = 480, height = 480, units = "px")

with(pwr, plot(DateTime, Sub_metering_1, xlab = "",
               type = "n", ylab = "Energy sub metering"))
with(pwr, lines(DateTime, Sub_metering_1, col = "black"))

with(pwr, lines(DateTime, Sub_metering_2, col = "red"))

with(pwr, lines(DateTime, Sub_metering_3, col = "blue"))


## Set legend parameters
legend(x = "topright", col = c("black", "red", "blue"), lty = 1,
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"))

#Close png
dev.off()