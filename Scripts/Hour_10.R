# ------------------------------------------------------------------------------
# Hour 10 - Importing and Exporting

# Reading in Text Files

# ------------------------------------------------------------------------------
# LISTING 10.1 Reading in Text Files
djiData <- read.table("djiData.csv", header= TRUE, sep = ",") 
head(djiData,3)
# ------------------------------------------------------------------------------

# if file located in a "data" directory
djiData <- read.table("data/djiData.csv", header= TRUE, sep = ",") 

# ------------------------------------------------------------------------------
# TIP Package Data
system.file(package = "mangoTraining", "extdata/djiData.csv")

# Reading in CSV Files
djiData <- read.csv("djiData.csv")    # CORRECTION

# Exporting Text Files
write.csv(airquality, "airquality.csv", row.names = FALSE)

# Faster Imports and Exports
# See fread in data.table, read_csv in readr

# ------------------------------------------------------------------------------
# Efficient Data Storage
longData <- data.frame(ID = 1:10000000, Value = rnorm(10000000))
write.csv(longData, "longData.csv", row.names = FALSE)
save(longData, file = "longData.RData")

# In addition we use gc to "clear garbage" and return memory to OS
rm(longData)
gc()
system.time(longData <- read.csv("longData.csv"))


rm(longData)
gc()
require(readr)
system.time(longData <- read_csv("longData.csv"))

rm(longData)
gc()
require(data.table)
system.time(longData <- fread("longData.csv"))

rm(longData)
gc()
system.time(load("longData.RData"))

# ------------------------------------------------------------------------------
# Proprietary and Other Formats
# see packages: foreign, sas7bdat, haven


# ------------------------------------------------------------------------------
# RODBC
# Location of file
#system.file(package = "mangoTraining", "extdata/Northwind.mbd")
# Move to current working directory

library(RODBC)
nWind <- odbcConnectAccess("Northwind.mdb")

nwTableData <- sqlTables(nWind)
nwTableData[1:3, c("TABLE_NAME", "TABLE_TYPE")]    # Preview main information

sqlColumns(nWind, "Orders")

#orders <- sqlFetch(nWind, "Orders")
orderQuery <- "SELECT OrderID, EmployeeID, OrderDate, ShipCountry FROM Orders"
keyOrderInfo <- sqlQuery(nWind, orderQuery)
head(keyOrderInfo, 3)

odbcClose(nWind)

# ------------------------------------------------------------------------------
# DBI
library(DBI)
library(RSQLite)
# Create a new SQLite database in-memory
dbiCon <- dbConnect(RSQLite::SQLite(), dbname = ":memory:")

# Write airquality to the DB as a new table
dbWriteTable(dbiCon, "airquality", airquality)

# Check what columns (fields) are in the arquality table
dbListFields(dbiCon, "airquality")

# Send a query and return the result
aQuery <- "SELECT * FROM airquality WHERE Month = 5 AND Wind > 15"
dbiQuery <- dbSendQuery(dbiCon, aQuery)
dbFetch(dbiQuery)
dbClearResult(dbiQuery) # Be tidy!

# Close the connection
dbDisconnect(dbiCon)


# ------------------------------------------------------------------------------
# Reading Structured Data from Excel

# Location of file
#system.file(package = "mangoTraining", "extdata/airquality.xlsx")
# Move to current working directory

library(readxl)

# What sheets does the workbook contain?
excel_sheets("airquality.xlsx")

# Read in the "data" sheet
air <- read_excel("airquality.xlsx", sheet = "data")
head(air, 3)

# ------------------------------------------------------------------------------
# The XLConnect Package

library(XLConnect)

# Load the workbook and see what sheets it contains
airWB <- loadWorkbook("airquality.xlsx")
getSheets(airWB)

# Read in the data from the XXX sheet
air <- readWorksheet(airWB, "data")

# Summary Data
averageOzone <- aggregate(data = air, Ozone ~ Month, mean, na.rm = T)

# Graphic as png
png("Ozone_Levels.png")
hist(air$Ozone, col = "lightblue",
     main = "Histogram of Ozone Levels in New York\nMay to September 1973",
     xlab = "Ozone (ppb)")
dev.off()

# New tab
createSheet(airWB, "Summary")

# Write summary data
writeWorksheet(airWB, averageOzone, "Summary", startRow = 2, startCol = 2)

# Add graphic
createName(airWB, "PlotGoesHere", "Summary!$E$2")
addImage(airWB, filename = "Ozone_Levels.png", name = "PlotGoesHere", 
         originalSize = TRUE)

# Set active sheet and close
setActiveSheet(airWB, "Summary")
saveWorkbook(airWB, "air_summary.xlsx")




