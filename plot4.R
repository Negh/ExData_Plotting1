# Course project 1

# script to generate the fourth plot

# requires the following packages : dplyr, lubridate

# read the data from the text file stored in the Working Directory
householdPowerConsumption <- read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?",stringsAsFactors = FALSE)

# filter the data to keep only the rows from the dates 2007-02-01 and 2007-02-02
library(dplyr)
householdPowerConsumptionFiltered <- filter(householdPowerConsumption, Date == "1/2/2007" | Date == "2/2/2007" )

# remove householdPowerConsumption from the memory to save RAM
rm(householdPowerConsumption)

# concatenate and convert the Date and Time
library(lubridate)
householdPowerConsumptionFiltered <- mutate(householdPowerConsumptionFiltered, DateTime = dmy_hms(paste(Date,Time)))

# PNG Graphics Device connection
# the plot will be generated directly in the Working Directory, by default it is already 480px*480px
png("plot4.png")

# plot4 generation
par(mfrow=c(2,2))

with(householdPowerConsumptionFiltered, plot(DateTime, Global_active_power,type="l", ylab="Global Active Power", xlab = ""))

with(householdPowerConsumptionFiltered, plot(DateTime, Voltage,type="l", xlab = "datetime"))

with(householdPowerConsumptionFiltered, {
        plot(DateTime, Sub_metering_1,type="l", ylab="Energy sub metering", xlab = "")
        lines(DateTime, Sub_metering_2, type="l", col = "red")
        lines(DateTime, Sub_metering_3, type="l", col = "blue")
        legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lwd=1, lty=1, bty="n")
})

with(householdPowerConsumptionFiltered, plot(DateTime, Global_reactive_power,type="l", xlab = "datetime"))

# deconnection from the PNG graphics device
dev.off()