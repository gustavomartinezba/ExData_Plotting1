## Unzip folder and read table
unzip("exdata_data_household_power_consumption.zip")
library(data.table)
hpc <- fread("household_power_consumption.txt")
library(dplyr)
hpc <- tbl_df(hpc)

## Filter dates we want
hpc$Date <- as.Date(hpc$Date, format = "%e/%m/%Y") 
hpc <- filter(hpc, Date == "2007-02-01" | Date == "2007-02-02")

## Create datetime column
hpc <- mutate(hpc, datetime = paste(Date, Time))
hpc <- hpc[, c(10, 3:9)]
hpc$datetime <- strptime(hpc$datetime, format = "%Y-%m-%d %H:%M:%S")

## Make plot
png("ExData_Plotting1/plot3.png")
with(hpc, plot(datetime, Sub_metering_1, type = "n", xlab = "", 
               ylab = "Energy sub metering"))
with(hpc, lines(datetime, Sub_metering_1))
with(hpc, lines(datetime, Sub_metering_2, col = "red"))
with(hpc, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = "solid")
dev.off()
