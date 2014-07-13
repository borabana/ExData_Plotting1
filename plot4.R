# Generate the composite plot.
png("plot4.png")
par(mfcol = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 0, 0))

suppress.export=TRUE
source("plot2.R")
source("plot3.R")
source("plot4a.R")
source("plot4b.R")

dev.off()

# Return to normal.
par(mfcol=c(1,1))
rm(suppress.export)