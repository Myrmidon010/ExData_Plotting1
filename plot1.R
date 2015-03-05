# Original Source Data as Zip
https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Note: Unzip and place in your working directory.  All references below assume the present working directory is set, that
# the data has been unzipped and placed in that directory.

# Import Data
hpc_raw = read.table("hpc.txt", header = TRUE, sep= ";", na.strings = "?", stringsAsFactors=F)

# Exclude NULL records
hpc = na.omit(hpc_raw)

# Append Calculated Date/Time Field to hpc
hpc$DateTime = as.POSIXct(paste(hpc$Date, hpc$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

# Convert Date field to Date datatype
hpc$Date = as.Date(hpc$Date, format="%d/%m/%Y")

# Subset hpc
hpc_sub = hpc[hpc$Date >= "2007-02-01" & hpc$Date <= "2007-02-02", ]

# Histogram
png("plot1.png")
hist(hpc_sub$Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
dev.off()