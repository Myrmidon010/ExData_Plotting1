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

# Multiplot
png("plot4.png")

# Container
par(mfrow=c(2,2))

  # Upper Left
  plot(hpc_sub$DateTime, as.numeric(hpc_sub$Global_active_power) ,type="l", xlab="", ylab="Global Active Power (kilowatts)")
  
  # Upper Right
  plot(hpc_sub$DateTime, as.numeric(hpc_sub$Voltage) ,type="l", xlab="datetime", ylab="Voltage")
  
  # Lower Left
  plot(hpc_sub$DateTime, as.numeric(hpc_sub$Sub_metering_1), col="black", type="n", xlab="", ylab="Energy Sub metering")
  lines(hpc_sub$DateTime, as.numeric(hpc_sub$Sub_metering_1), col="black")
  lines(hpc_sub$DateTime, as.numeric(hpc_sub$Sub_metering_2), col="red")
  lines(hpc_sub$DateTime, as.numeric(hpc_sub$Sub_metering_3), col="blue")
  legend("topright", 
         legend = c("Sub_metering_1", 
                    "Sub_metering_2", 
                    "Sub_metering_3"), 
         col = c("black", "red", "blue"), 
         lwd = .75, 
         cex = .75
  )
  
  # Lower Right
  plot(hpc_sub$DateTime, as.numeric(hpc_sub$Global_reactive_power) ,type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()