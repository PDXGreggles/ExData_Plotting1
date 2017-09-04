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

##Plot #3 - line chart of the 3 sub-metered appliances over time
par(mfrow = c(1,1))
png("Plot3.png")
with(power, plot(datetime,Sub_metering_1, type="l", xlab= " ", ylab="Energy sub metering"))
with(power, lines(datetime,Sub_metering_2, type="l",col='red'))
with(power, lines(datetime,Sub_metering_3, type="l",col='blue'))
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c(1,"red","blue"), lty=c(1,1,1))
dev.off()