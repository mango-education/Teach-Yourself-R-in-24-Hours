require(mangoTraining)


# dplyr
require(dplyr)

# Create a tbl_df object from mtcars
head(mtcars)

carData <- tbl_df(mtcars)
carData

class(carData)    # A dbl_df object is just an extension to a data.frame object

# Sorting
arrange(carData, carb, cyl)

arrange(carData, carb, desc(cyl))

arrange(carData, carb, -cyl)

# Subscripting
cyl4 <- filter(carData, cyl == 4)
cyl4

filter(carData, cyl == 4, gear == 5)    # equivalent to cyl == 4 & gear == 5

select(carData, mpg, wt, cyl)    # Keep these columns
select(carData, -vs, -am)    # Drop these columns

select(carData, mpg:wt)

fullCarData <- mutate(carData, type = rownames(mtcars), pwr2wt = hp/wt)
fullCarData

fullCarData <- mutate(carData, type = rownames(mtcars), 
                      drat = NULL, qsec = NULL,
                      pwr2wt = hp/wt, pwr2wt.Sq = pwr2wt^2)
head(fullCarData,3)

# summarize
summarize(carData, mean(mpg))

summarize(carData, min(mpg), median(mpg), max(mpg))

mpgSummary <- summarize(carData, Min = min(mpg), Median = median(mpg), Max = max(mpg))
mpgSummary

summarize(airquality, mean(Ozone, na.rm = TRUE))

# Grouped data
cylGrouping <- group_by(carData, cyl)
head(cylGrouping)
filter(cylGrouping, carb == 4)

mpgSummaryByCyl <- summarize(cylGrouping, min(mpg), median(mpg), max(mpg))
mpgSummaryByCyl

# Other uses of group_by
cylGrouping <- group_by(carData, cyl)
# Extract maximum mpg by for each cyl category 
filter(cylGrouping, mpg == max(mpg))

mutate(cylGrouping, meanMPGbyCyl = mean(mpg))

# Piping
# A standard workflow, mean mpg by cyl for manual cars
# The traditional way:
carsByCyl <- arrange(mtcars, cyl)
groupByCyl <- group_by(carsByCyl, cyl)
manualCars <- filter(groupByCyl, am == 1)
summarize(manualCars, Mean.MPG=mean(mpg))

# Using pipes
mtcars %>% 
  arrange(cyl) %>% 
  group_by(cyl) %>%
  filter(am == 1) %>%
  summarize(Mean.MPG=mean(mpg))

mtcars %>% 
  arrange(cyl) %>% 
  group_by(cyl) %>%
  filter(am == 1) %>%
  summarize(Mean.MPG=mean(mpg))



# ------------------------------------------------------------------------------
# data.table
require(data.table)

# fread
dji <- fread("djiData.csv")
dji

# Setting a key
# Create a data.table and define the key
demoDT <- data.table(demoData)
setkey(demoDT, Sex, Smokes)
head(demoDT)

# Subscripting
demoDT[Sex == "F",]
demoDT["F",]

key(demoDT)
demoDT[.("F", "Yes"),]
demoDT[J("F", "Yes"),]
demoDT[list("F", "Yes"),]


setkey(demoDT, Sex, Weight)
demoDT[J("M", c(76, 77)),]

setkey(demoDT, Weight)
demoDT[.(72),]

# Adding Columns or rows
demoDT[, HeightInM.sq := (Height^2)/10000]
head(demoDT)

demoDT[, c("SexNum", "SmokesNum") := list(as.numeric(Sex), as.numeric(Smokes))]
head(demoDT)

demoDT[, ':=' ("SexNum" = as.numeric(Sex), "SmokesNum" = as.numeric(Smokes))]
head(demoDT)

# Adding rows

# Create a list containing airquality data for each available month
airSplit <- split(airquality, airquality$Month)

# Bind these together into a single data table
airDT <- rbindlist(airSplit)
airDT

# Now assume two new records arrive but with missing columns
month10 <- data.table(Ozone = c(24, 28), Month = 10, Day = 1:2)

# Bind this to our original data
newAirDT <- rbindlist(list(airDT, month10), fill = TRUE)
tail(newAirDT)

# Merging
# Create data tables and define the keys accordingly
demoDT <- data.table(demoData)
setkey(demoDT, Subject)
pkDT <- data.table(pkData)
setkey(pkDT, Subject)
# Merge the two data tables together
allPKDT <- merge(demoDT, pkDT)
allPKDT

demoDT[pkDT]

# Aggregation
# Calculate the mean height
demoDT <- data.table(demoData)
demoDT[ , mean(Height)]

demoDT[ , mean(Height), by = Sex]

demoDT[ , mean(Height), by = list(Sex, Smokes)]

demoDT[ , list(Mean.Height = mean(Height), Mean.Weight = mean(Weight)), 
        by = list(Sex, Smokes)]


demoDT[, MeanWeightBySex := mean(Weight), by = Sex]
head(demoDT, 5)


demoDT[, list(MeanWeightBySex := mean(Weight), MeanHeightBySex := mean(Height)), by = Sex]
head(demoDT, 5)

