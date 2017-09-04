library(lubridate)
library(dplyr)
library(sqldf)

## Read in the data from a file saved locally in your current working directory.  Since the file is large, only the necessary rows
## will be read in.  The file is subset using the sqldf package and the where clause in the sql statement.

power <- read.csv.sql('~/household_power_consumption.txt', sql = "select* from file where Date in ('1/2/2007','2/2/2007')", 
                      header = TRUE, sep = ";")

## The Date and Time columns are saved as strings.  They are converted to POSIXct using the mutate function from dplyr and the
## lubridate package

power <- tbl_df(power)
power = mutate(power, datetime = as.POSIXct(dmy(Date)+hms(Time)))

## For each plot a png device is opened, the plot is created and the device is closed.

##Plot #2 - line chart of global active power over time
par(mfrow = c(1,1))
png("Plot2.png")
with(power, plot(datetime,Global_active_power, type="l",ylab = "Global active power (killowatts)",xlab=""))
dev.off()