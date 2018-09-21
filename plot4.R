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
png(file = "plot4.png", width = 480, height = 480, units = "px")

## Set the 2x2 subplot layout
par(mfrow = c(2,2))

## First plot, GAP vs. datetime
with(pwr, plot(DateTime, Global_active_power, xlab = "",
               type = "n", ylab = "Global Active Power (kilowatts)"))
with(pwr, lines(DateTime, Global_active_power))

## Second plot, Voltage vs. datetime
with(pwr, plot(DateTime, Voltage, xlab = "datetime",
               type = "n", ylab = "Voltage"))
with(pwr, lines(DateTime, Voltage))

## Third plot, with all 3 sub metering vectors
with(pwr, plot(DateTime, Sub_metering_1, xlab = "",
               type = "n", ylab = "Energy sub metering"))
with(pwr, lines(DateTime, Sub_metering_1, col = "black"))

with(pwr, lines(DateTime, Sub_metering_2, col = "red"))

with(pwr, lines(DateTime, Sub_metering_3, col = "blue"))

## Set legend parameters
legend(x = "topright", col = c("black", "red", "blue"), lty = 1, bty = "n",
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"))

## Fourth plot, GRP vs. datetime
with(pwr, plot(DateTime, Global_reactive_power, xlab = "datetime",
               type = "n", ylab = "Global_reactive_power"))
with(pwr, lines(DateTime, Global_reactive_power))

# Close png
dev.off()