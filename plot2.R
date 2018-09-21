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

## Set the format and name for the first plot
png(file = "plot2.png", width = 480, height = 480, units = "px")

with(pwr, plot(DateTime, Global_active_power, xlab = "",
               type = "n", ylab = "Global Active Power (kilowatts)"))
with(pwr, lines(DateTime, Global_active_power))

dev.off()