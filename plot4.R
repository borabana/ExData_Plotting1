# Generate the composite plot.
par(mfcol = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 0, 0))
source("plot2.R")
source("plot3.R")
source("plot4a.R")
source("plot4b.R")

dev.copy(png, file = "plot4.png")
dev.off()