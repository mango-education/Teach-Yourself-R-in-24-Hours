
#------------------------------------------------------------------------------#
# Working with Dates and Times
#------------------------------------------------------------------------------#

## Creating date objects
myDates <- c("2015-06-21", "2015-09-11", "2015-12-31")
myDates <- as.Date(myDates, format = "%Y-%m-%d")
myDates
myDates[2:3]
class(myDates)

## Dates as numbers
as.numeric(myDates)

## Dates from an origin
as.Date(42174, origin = "1900-01-01")

## Numeric format dates
myDates <- c(20150621, 20150911, 20151231)
myDates <- as.character(myDates)
myDates <- as.Date(myDates, format = "%Y%m%d")


## Objects that include times
myTimes <- c("2015-06-21 14:22:00", "2015-09-11 10:23:32", "2015-12-31 23:59:59")
myTimes <- as.POSIXct(myTimes, format = "%Y-%m-%d %H:%M:%S")
myTimes
class(myTimes)

## Timezones
myTimes <- c("2015-06-21 14:22:00", "2015-09-11 10:23:32", "2015-12-31 23:59:59")
myTimes <- as.POSIXct(myTimes, format = "%Y-%m-%d %H:%M:%S", tz = "US/Pacific")
myTimes

## Manipulating Dates and Times

myDates + 1

## Extracting information from dates
weekdays(myDates)
months(myDates)
quarters(myDates)

## Differences between dates
diff(myDates)
difftime(myDates, as.Date("2015-07-04"))
difftime(myDates, as.Date("2015-07-04"), units = "weeks")

## Create a sequence of dates
seq(as.Date("2015-01-01"), as.Date("2015-12-01"), by = "week")


#------------------------------------------------------------------------------#
# The lubridate package
#------------------------------------------------------------------------------#

library(lubridate)

## Current system time
now()

## Creating date objects
myDates <- c("2015-06-21", "2015-09-11", "2015-12-31")
myDates <- ymd(myDates)
myDates

## Creating time objects
myTimes <- c("14:22:00", "10:23:32", "23:59:59")
myTimes <- hms(myTimes)
myTimes

## Adding amounts of time
newYearEve <- ymd_hms("2015-12-31 23:59:59")
newYearEve + seconds(2)
newYearEve + months(3)
newYearEve - years(1)

#------------------------------------------------------------------------------#
# Working with categorical data
#------------------------------------------------------------------------------#

## Creating factors
x <- c("B", "B", "C", "A", "A", "A", "B", "C", "C")
x
mode(x)
class(x)

y <- factor(x)
y

## Order of levels in a factor
ratings <- c("Poor", "Average", "Good")
myRatings <- sample(ratings, 20, replace = TRUE)
factorRatings <- factor(myRatings)
factorRatings

## Setting the order of levels 
factorRatings <- factor(myRatings, levels = ratings)
factorRatings


## Changing levels - note the line below will not work and will cause errors in the data
#factorRatings[factorRatings == "Poor"] <- "Negative"

levels(factorRatings) <- c("Negative", "Average", "Positive")

## Combining factor levels
levels(factorRatings) <- c("Negative", "Other", "Other")
factorRatings

#------------------------------------------------------------------------------#
# Creating Factors from Continuous Data
#------------------------------------------------------------------------------#

## cutting up a vector of continuous data 
ages <- c(19, 38, 33, 25, 21, 27, 27, 24, 25, 32)
cut(ages, breaks = 3)

## specifying the break points
cut(ages, breaks = c(18, 25, 30, Inf))

## specifying breaks and labels for groups
cut(ages, breaks = c(18, 25, 30, Inf), labels = c("18-25", "25-30", "30+"))


