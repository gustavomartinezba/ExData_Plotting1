## Unzip folder and read table
unzip("exdata_data_household_power_consumption.zip")
library(data.table)
hpc <- fread("household_power_consumption.txt")
library(dplyr)
hpc <- tbl_df(hpc)

## Filter dates we want
hpc$Date <- as.Date(hpc$Date, format = "%e/%m/%Y") 
hpc <- filter(hpc, Date == "2007-02-01" | Date == "2007-02-02")

## Make histogram
hpc$Global_active_power <- as.numeric(hpc$Global_active_power)
png("ExData_Plotting1/plot1.png")
hist(hpc$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()
