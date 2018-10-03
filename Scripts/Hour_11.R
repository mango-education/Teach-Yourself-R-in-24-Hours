# ------------------------------------------------------------------------------
# Hour 11 
# Data Manipulation and Transformation
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Sorting
sort(airquality$Wind)[1:10]

# Sorting Data Frames
myVec <- c(63, 31, 48, 82, 51, 20, 72, 99, 84, 53)
order(myVec)

# ------------------------------------------------------------------------------
# LISTING 11.1 Sorting Data Frames
sortedByWind <- airquality[order(airquality$Wind), ]
head(sortedByWind, 10)
# ------------------------------------------------------------------------------

# Descending Sorts

# ------------------------------------------------------------------------------
# LISTING 11.2 Descending Sorts
sortedByWindandDescTemp <- airquality[order(airquality$Wind, -airquality$Temp), ]
head(sortedByWindandDescTemp, 10)
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Appending

# New data arrives each month
jan <- data.frame(Month = "Jan", Value = 46.4)
feb <- data.frame(Month = "Feb", Value = 55.2)
rbind(jan, feb)

# ------------------------------------------------------------------------------
# Merging

# library(mangoTraining)   # If not already loaded

# A Merge Example
head(demoData, 3)
head(pkData, 7)

fullPk <- merge(x = demoData, y = pkData, by = "Subject")

fullPk <- merge(x = demoData, y = pkData)

# Missing Data
demo1and2 <- demoData[demoData$Subject %in% 1:2, ]
pk2and3 <- pkData[pkData$Subject %in% 2:3, ]

demo1and2
pk2and3

merge(demo1and2, pk2and3)

merge(demo1and2, pk2and3, all = TRUE)

# ------------------------------------------------------------------------------
# Duplicate Values
isMonthValueADuplicate <- duplicated(airquality$Month)
isMonthValueADuplicate[1:10]    # View first 10 records

airquality[!duplicated(airquality$Month), ]

# Create data with a duplicate record for ID==2
duplicateData <- data.frame(ID = c(1,2,2,3,4), Score = c(57, 45, 45, 63, 54))
duplicateData

# Remove the duplicate record
duplicateData[!duplicated(duplicateData),]

# See also: unique

# ------------------------------------------------------------------------------
# Restructuring

library(reshape)

# Melting

# ------------------------------------------------------------------------------
# LISTING 11.3 Melting the french_fries Data
# Let's begin by looking at the data
head(french_fries, 3)
tail(french_fries, 3)

# Now we 'melt' having identified the ID variables
fryMelt <- melt(french_fries, 
                id.vars = c("time", "treatment", "subject", "rep"))

# Our new data is long and thin
head(fryMelt, 3)
tail(fryMelt, 3)
# ------------------------------------------------------------------------------

# Casting

# ------------------------------------------------------------------------------
# LISTING 11.4 Casting the french_fries Data
# Create two new columns based on the rep variable
fryReCast <- cast(fryMelt, ... ~ rep)   # USing reshape
#fryReCast <- dcast(fryMelt, ... ~ rep)   # USing reshape2
head(fryReCast, 3)
# ------------------------------------------------------------------------------

recast(french_fries,
       id.var = c("time", "treatment", "subject", "rep"),
       formula = ... ~ rep)

# ------------------------------------------------------------------------------
# NOTE
# Aggregation Using reshape
# Mean across replicates 
replicateMeans <- 
  dcast(fryMelt, time + treatment + subject + variable ~ ., mean)
head(replicateMeans, 3)
# ------------------------------------------------------------------------------


# Restructuring with tidyr

library(tidyr)

djiHighLow <- djiData[, c("Date", "DJI.High", "DJI.Low")]
head(djiHighLow, 3)

# Gather
gatheredDJI <- gather(djiHighLow, key="DJI", value="Value", DJI.High, DJI.Low) 
head(gatheredDJI, 4)

# Spread
backToOriginal <- spread(gatheredDJI, key = DJI, value = Value)
head(backToOriginal, 3)

# Separate
Packages <- data.frame(Source=c("reshape_0.8.5", "tidyr_0.2.0"))
Packages
separate(Packages, Source, into = c("Package", "Version"), sep = "_")

# ------------------------------------------------------------------------------
# Data Aggregation

# Using an “apply” Function
head(airquality)   # Print airquality

windMedians <- tapply(airquality$Wind, airquality$Month, median)
windMedians

charMonths <- as.character(airquality$Month)     # Converted character values of Month
# Use character values to reference named elements
head(windMedians [ charMonths ])        


airquality$MedianWind <- windMedians [ charMonths ]             # Add Median Wind column
airquality$DiffWind <- airquality$Wind - airquality$MedianWind  # Calculate differences
head(airquality, 3)                                             # First few rows
tail(airquality, 3)                                             # Last few rows

# Using aggregate with a Formula
aggregate(Wind ~ Month, data = airquality, FUN = median)

# Summarizing by Multiple Variables
aggregate(Wind ~ Month + cut(Temp, 2), data = airquality, FUN = median)

#Summarizing Multiple Columns
aggregate(cbind(Wind, Ozone) ~ Month, data = airquality, FUN = median, na.rm = TRUE)

# Multiple Return Values

# Range of Wind values by Month
aggregate(Wind ~ Month, data = airquality, FUN = range, na.rm = TRUE)
# Range of Wind AND Ozone values by Month
aggregate(cbind(Wind, Ozone) ~ Month, data = airquality, FUN = range, na.rm = TRUE)
# Range of Wind AND Ozone values by Month AND grouped Temp
aggregate(cbind(Wind, Ozone) ~ Month + cut(Temp, 2), data = airquality, 
          FUN = range, na.rm = TRUE)

aggregate(Wind ~ Month, data = airquality,
  FUN = function(X) {
    c(MIN = min(X), MAX = max(X))
  })

# Using aggregate by Specifying Columns
aggregate(list(aveWind = airquality$Wind), list(Month = airquality$Month), median)

# Summarizing by Multiple Variables
aggregate(list(aveWind = airquality$Wind),
  list(Month = airquality$Month, TempGroup = cut(airquality$Temp, 2)), median)

# Summarizing Multiple Columns
aggregate(list(aveWind = airquality$Wind, aveOzone = airquality$Ozone),
          list(Month = airquality$Month), median, na.rm = TRUE)

# ------------------------------------------------------------------------------
# TIP
# Specifying Inputs as Data Frames
aggregate(airquality[,c("Wind", "Ozone")],
          list(Month = airquality$Month), median, na.rm = TRUE)
# ------------------------------------------------------------------------------

# Multiple Return Values
aggregate(list(Wind = airquality$Wind),
          list(Month = airquality$Month), range)

aggregate(list(Wind = airquality$Wind),
          list(Month = airquality$Month),
          function(X) {
            c(MIN = min(X), MAX = max(X))
          })

# Calculating Differences from Baseline
windMedians <- aggregate(list(MedianWind = airquality$Wind),
                         list(Month = airquality$Month), median)
windMedians

airquality <- merge(airquality, windMedians)
head(airquality)


