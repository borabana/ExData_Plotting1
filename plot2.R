# Import function to load a cleaned version of the data.
source("loadPowerConsumptionData.R")

# Load the data and subset to pull out the desired days.
powerConsumption <- loadPowerConsumptionData()
targetDates <- powerConsumption[Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")),]
targetDates[,Weekday := weekdays(Date, abbreviate=TRUE)]

if (!exists("suppress.export")) {
  png("plot2.png")
}

# Generate the plot of the Global Active Power and save it to a .png as well.
plot(targetDates$Global_active_power, type="l", xaxt="n", xlab="", ylab="Global Active Power (kilowatts)")

# Cannot figure out how to elegantly include "Sat" w/o BS hacks such as this.  Forum suggestions
# didn't help either.
firstFriday = min(which(targetDates$Weekday == "Fri"))
lastFriday = max(which(targetDates$Weekday == "Fri"))
axis(1, labels=c("Thur", "Fri", "Sat"), at=c(0,firstFriday,lastFriday))

if (!exists("suppress.export")) {
  #dev.copy(png, file = "plot2.png")
  dev.off()
}