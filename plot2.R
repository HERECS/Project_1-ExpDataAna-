##extract the household_power_consumption.txt into a file named "Data"
##and set the directory to the place that contains the file "Data"

library(lubridate)

##read and assign data frame into R and substitute "?" with "NA"
Data <- read.table("./Data/household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")
TheNames <- names(Data)

##find 01/02/2007 & 02/02/2007
C <- which(dmy(Data$Date)==dmy("01/02/2007"))
D <- which(dmy(Data$Date)==dmy("02/02/2007"))

##reread data within time
Data <- read.table("./Data/household_power_consumption.txt", sep=";", header=FALSE, skip=66637, nrows=2880)

##rename them
names(Data) <- TheNames

##combine date and time in format of POSIXct and add as a column into DataTime
Data$DateTime <- dmy_hms(paste(Data$Date, Data$Time))

##start the second plot
with(Data, plot(Global_active_power~DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab=""))

##save to png
dev.copy(png, "plot2.png", width=480, height=480)
dev.off()
