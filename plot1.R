# Import function to load a cleaned version of the data.
source("loadPowerConsumptionData.R")

# Load the data and subset to pull out the desired days.
powerConsumption <- loadPowerConsumptionData()
targetDates <- powerConsumption[Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")),]

# Generate the histogram of the Global Active Power and save it to a .png as well.
hist(targetDates$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png")
dev.off()