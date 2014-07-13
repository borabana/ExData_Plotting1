# Load the "Individual household electric power consumption Data Set" (originally sourced from the
# UC Irvine Machine Learning Repository) and clear it up a bit.  Unknown values are given by "NA"
# and the Date and Time columns are combined into a datetimes using strptime.
#
# The URL used here is from with the Data Science Coursera class Exploratory Data Analysis taught
# in July 2014.
#
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# This ZIP should contain a single file named "household_power_consumption.txt".  The function
# will download and unzip this file if it's not found in the working folder.  Otherwise it will
# process and return the "cached" copy of the file.
#
# The format of the file is here:
# https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
#
require(data.table)

loadPowerConsumptionData <- function() {
  zipName <- "household_power_consumption.zip"
  fileName <- "household_power_consumption.txt"
  
  if (!file.exists(zipName)) {
    # No cached .zip so fetch it from the web; use binary (wb) mode. 
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, zipName, mode="wb")
  }
  
  if (!file.exists(fileName)) {
    # No cached .txt so extract it from the ZIP.
    unzip(zipName)
  }
  
  if (!file.exists(fileName)) {
    # Stop if we still don't have a copy of the .txt file.  Maybe the ZIP content has changed
    # since this code was written.
    stop("Data cannot be loaded.")
  }
  
  # fread is much faster than read.csv or read.csv3.
  data <- fread(fileName, header=TRUE, sep=";", na.strings=c("?", "NA", "N/A", ""))
  
  #data[,Date := {temp <- paste(Date, Time); strptime(temp, "%d/%m/%Y %T")}]
  data[, Date := as.Date(Date, "%d/%m/%Y")]
  data[, Global_active_power := as.numeric(Global_active_power)]
  data[, Global_reactive_power := as.numeric(Global_reactive_power)]
  data[, Voltage := as.numeric(Voltage)]
  data[, Global_intensity := as.numeric(Global_intensity)]
  data[, Sub_metering_1 := as.numeric(Sub_metering_1)]
  data[, Sub_metering_2 := as.numeric(Sub_metering_2)]
  data[, Sub_metering_3 := as.numeric(Sub_metering_3)]
    
  
  return(data)
}