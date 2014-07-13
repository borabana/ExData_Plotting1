# Import function to load a cleaned version of the data.
source("loadPowerConsumptionData.R")

# Load the data and subset to pull out the desired days.
powerConsumption <- loadPowerConsumptionData()
targetDates <- powerConsumption[Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")),]
targetDates[,Weekday := weekdays(Date, abbreviate=TRUE)]

png("plot3.png")

# Generate the plot of the sub meterings and save it to a .png as well.  Remeber to set ylim to be
# the max of all the y values in the subplots.
maxY = max(c(targetDates$Sub_metering_1,targetDates$Sub_metering_2,targetDates$Sub_metering_3))
plot(targetDates$Global_active_power, type="n", xaxt="n", xlab="", ylab="Energy sub metering", ylim=c(0,maxY))
with(targetDates, lines(targetDates$Sub_metering_1, col="black"))
with(targetDates, lines(targetDates$Sub_metering_2, col="red"))
with(targetDates, lines(targetDates$Sub_metering_3, col="blue"))

legend("topright", col = c("black", "red", "blue"), pch=c(NA, NA, NA), lwd=1, lty=c(1,1,1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Cannot figure out how to elegantly include "Sat" w/o BS hacks such as this.  Forum suggestions
# didn't help either.
firstFriday = min(which(targetDates$Weekday == "Fri"))
lastFriday = max(which(targetDates$Weekday == "Fri"))
axis(1, labels=c("Thur", "Fri", "Sat"), at=c(0,firstFriday,lastFriday))

#dev.copy(png, file = "plot3.png")
dev.off()