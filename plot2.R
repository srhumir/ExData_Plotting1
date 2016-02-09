##Download and unzip the data
###create the "data" directory
if (!dir.exists("./data")){
       dir.create("./data")     
} 
###Download zip file
if (!file.exists("./data/householdpowerconsumption.zip")){
       url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
       download.file(url, destfile = "./data/householdpowerconsumption.zip")
       unzip("./data/householdpowerconsumption.zip", exdir = "./data")
}
###unzip the file
if (!file.exists("./data/household_power_consumption.txt")){
       unzip("./data/householdpowerconsumption.zip", exdir = "./data")
}
##load data into memory
powercons <- read.table("./data/household_power_consumption.txt", header = TRUE,
                        sep = ";", na.strings = "?", colClasses = "character",
                        nrows = 70000, comment.char = "")
##convert date, time and numbers to appropriate classes
powercons$Time <- strptime(paste(powercons$Date,powercons$Time), format = "%d/%m/%Y %H:%M:%S", tz= "America/Los_Angeles")
powercons$Date <- as.Date(powercons$Date, "%d/%m/%Y")
powercons[3:9] <- as.data.frame(sapply(powercons[3:9], as.numeric))
##Subset just 2007-02-01 to 2007-02-02
powerconsFeb <- subset(powercons, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

######Till  here are prepring data and will be the same for all charts####

##Second plot
png("./assignment1/plot2.png", type = "cairo")
with(powerconsFeb,plot(Global_active_power ~ as.POSIXct(Time), type = "l", xlab="", ylab = ""))
title(ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()
