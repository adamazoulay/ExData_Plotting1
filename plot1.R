## First load the power data from 2007-02-01 to 2007-02-02
pwr <- read.table("household_power_consumption.txt", stringsAsFactors = FALSE,
                  header = TRUE, sep=";", na.strings = "?")

## Convert dates to Date objects to for subsetting
pwr <- subset(pwr, as.Date(Date, "%d/%m/%Y") == "2007-02-01" |
                   as.Date(Date, "%d/%m/%Y") == "2007-02-02")

## We need to convert cols to numeric to plot them
pwr$Global_active_power <- as.numeric(pwr$Global_active_power)

## Set the format and name for the first plot
png(file = "plot1.png", width = 480, height = 480, units = "px")

with(pwr, hist(Global_active_power, col = "red",
               xlab = "Global Active Power (kilowatts)",
               main = "Global Active Power"))

dev.off()