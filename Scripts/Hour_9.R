# [DESCRIPTION] R Script supporting Chapter 9 of the SAMS Book
# [AUTHOR] Richard Pugh

performAction <- function(...) invisible()
performAction(df[1,])  # Perform action on first row
performAction(df[2,])  # Perform action on second row
performAction(df[3,])  # Perform action on third row
performAction(df[4,])  # Perform action on fourth row

for (variable in set_of_values) {
  do this
}

for (i in 1:10) {
  cat("\n Hello")  # Say Hello
}

for (i in 1:5) {
  cat("\n i has been set to the value of", i)  # Say Hello
}


for (let in LETTERS[1:5]) {
  cat("\n The Letter", let)  # Say Hello
}

head(airquality)
unique(airquality$Month)


# Perform summary for Month 5
ozoneValues <- airquality$Ozone [ airquality$Month == 5 ] # Subset the data
theMean <- round(mean(ozoneValues, na.rm = TRUE), 2)      # Calculate the mean
cat("\n Average Ozone for month 5 =", theMean)        # Print the message

# Perform summary for Month 6
ozoneValues <- airquality$Ozone [ airquality$Month == 6 ] # Subset the data
theMean <- round(mean(ozoneValues, na.rm = TRUE), 2)      # Calculate the mean
cat("\n Average Ozone for month 6 =", theMean)        # Print the message

# Perform summary for Month 7
ozoneValues <- airquality$Ozone [ airquality$Month == 7 ] # Subset the data
theMean <- round(mean(ozoneValues, na.rm = TRUE), 2)      # Calculate the mean
cat("\n Average Ozone for month 7 =", theMean)        # Print the message


for (M in unique(airquality$Month)) {
  ozoneValues <- airquality$Ozone [ airquality$Month == M ] # Subset the data
  theMean <- round(mean(ozoneValues, na.rm = TRUE), 2)      # Calculate the mean
  cat("\n Average Ozone for month", M, "=", theMean)        # Print the message
}

for (M in unique(airquality$Month)) {

  cat("\n\n Month =", M, "\n =========")                    # Write Month Number
  subData <- airquality [ airquality$Month == M, ]          # Subset the data

  theMean <- round(mean(subData$Ozone, na.rm = TRUE), 2)    # Calculate the mean
  cat("\n   Average Ozone =\t", theMean)                    # Print the message

  theMean <- round(mean(subData$Wind, na.rm = TRUE), 2)     # Calculate the mean
  cat("\n   Average Wind =\t", theMean)                     # Print the message
  
  theMean <- round(mean(subData$Solar.R, na.rm = TRUE), 2)  # Calculate the mean
  cat("\n   Average Solar.R =\t", theMean)                  # Print the message

}

for (M in unique(airquality$Month)) {
  
  cat("\n\n Month =", M, "\n =========")                    # Write Month Number
  subData <- airquality [ airquality$Month == M, ]          # Subset the data
  
  for (column in c("Ozone", "Wind", "Solar.R")) {             # Iterate over column names
    theMean <- round(mean(subData$column, na.rm = TRUE), 2)   # Calculate the mean
    cat("\n   Average", column, "=\t", theMean)                    # Print the message
  }

}


airquality$Wind[1:5]    # The Wind column
airquality$"Wind"[1:5]  # Also works

whichColumn <- "Wind"   # set value of whichColumn
airquality$whichColumn  # Reference using whichColumn

whichColumn <- "Wind"           # set value of whichColumn
airquality[[whichColumn]][1:5]  # Reference using whichColumn



for (M in unique(airquality$Month)) {
  
  cat("\n\n Month =", M, "\n =========")                         # Write Month Number
  subData <- airquality [ airquality$Month == M, ]               # Subset the data
  
  for (column in c("Ozone", "Wind", "Solar.R")) {                # Iterate over column names
    theMean <- round(mean(subData[[column]], na.rm = TRUE), 2)   # Calculate the mean
    cat("\n   Average", column, "=\t", theMean)                  # Print the message
  }
  
}

args(median)
median( airquality$Wind )  # Median of Wind column


index <- 0              # Set value of index to 0
while(index < 5) {
  cat("\n Hello")       # Write a message
  index <- index + 1    # Update the value of index
}



index <- 0              # Set value of index to 0
while(index < 5) {
  cat("\n Setting the value of index from", index)       # Write a message
  index <- index + 1                                     # Update the value of index
  cat(" to", index)                                      # Write a message
}



args(apply)

set.seed(125)
myMat <- matrix(rpois(20, 3), nrow = 4)  # Create a simple matrix
myMat                                    # Print myMat
dim(myMat)                               # Dimensions of myMat

apply(X, 2, max)   # Column Maxima
apply(myMat, 1, min)   # Row Minima


myMat
apply(myMat, c(1, 2), median)   # Median by row AND column


myArray <- array( rpois(18, 3), dim = c(3, 3, 2)) # Create array
myArray                                           # Print myArray
dim(myArray)                                      # Dimensions of myArray

apply(myArray, 3, min)
apply(myArray, c(1, 2), max)

myMat[2, 2] <- NA   # Add a missing value in cell 2, 2
myMat               # Print the matrix

apply(myMat, 2, max)  # Maximum of each column

max(myMat[,2])  # Maximum of 2nd column
max(myMat[,2], na.rm = TRUE)  # Maximum of 2nd column


args(apply)                          # Ellipses are 4th argument
apply(myMat, 2, max, na.rm = TRUE)   # Maximum of each column

set.seed(12345)
biggerMat <- matrix( rpois(300, 3), ncol = 3)   # Create a 100 x 3 matrix
head(biggerMat)                                 # First few rows
apply(biggerMat, 2, quantile)                   # Column quantiles

biggerMat [ sample( 1:300, 50) ] <- NA          # Randomly add some missings
head(biggerMat)                                 # First few rows
apply(biggerMat, 2, quantile, na.rm = TRUE)     # Column quantiles


apply(biggerMat, 2, quantile, 
  probs = c(0, .05, .5, .95, 1), na.rm = TRUE)     # Column quantiles

myMat[2,2] <- 7
myMat

above3 <- function(vec) {
  sum(vec > 3)
}
above3( c(1, 6, 5, 1, 2, 3) )  # Try out our function

apply(myMat, 2, above3)   # Number of values > 3 in each column

apply(myMat, 2, function(vec) {
  sum(vec > 3)
})

apply(myMat, 2, function(vec) sum(vec > 3))

aboveN <- function(vec, N) {
  sum(vec > N)
}
someValues <- c(1, 6, 5, 1, 2, 3)
aboveN( someValues, N = 3 )        # Number > 3
aboveN( someValues, N = 5 )        # Number > 4

myMat                             # Print the matrix
apply(myMat, 2, aboveN, N = 3)    # Number > 3
apply(myMat, 2, aboveN, N = 4)    # Number > 4


apply(myMat, 2, function(vec, N) {
  sum(vec > N)
}, N = 3)

head(airquality)                              # First few rows
apply(airquality, 2, median, na.rm = TRUE)    # Median of each column


head(iris)
apply(iris, 2, median, na.rm = TRUE)

# Apply median function over the first 4 columns of iris
apply(iris[,-5], 2, median, na.rm = TRUE)



set.seed(12345)
myList <- list(P1 = rpois(10, 1), P3 = rpois(10, 3), P5 = rpois(10, 5))
myList

lapply(myList, median)
       

spWind <- split(airquality$Wind, airquality$Month)
spWind[1:3]

lapply(spWind, median)


lapply(split(airquality$Wind, airquality$Month), median)

with(airquality, lapply(split(Wind, Month), median))

spAir <- split(airquality, airquality$Month)
head(spAir[[1]])
head(spAir[[2]])

split(airquality$Wind, list(airquality$Month, cut(airquality$Temp, 2)))


lapply(spAir, head, n = 3)


lapply(spAir, function(df) {
  apply(df[,1:4], 2, median, na.rm = TRUE)
})



lapply
as.list(1:5)


lapply(1:5, rnorm)

list(
  rnorm(1),
  rnorm(2),
  rnorm(3),
  rnorm(4),
  rnorm(5))

lapply(1:5, rnorm, mean = 10)

list(
  rnorm(1, mean = 10),
  rnorm(2, mean = 10),
  rnorm(3, mean = 10),
  rnorm(4, mean = 10),
  rnorm(5, mean = 10)
)

lapply(1:5, rnorm, mean = 10)

args(rnorm)

lapply(1:5, rnorm, n = 5)


list(
  rnorm(1, n = 5),
  rnorm(2, n = 5),
  rnorm(3, n = 5),
  rnorm(4, n = 5),
  rnorm(5, n = 5)
)

lapply(split(airquality$Wind, airquality$Month), median)
sapply(split(airquality$Wind, airquality$Month), median)

lapply(airquality, median, na.rm = TRUE)

apply(airquality, 2, class)
lapply(airquality, class)

apply(iris, 2, class)


# Range of values in each column
lapply(airquality, range, na.rm = TRUE)




set.seed(67)
myList <- list(P1 = rpois(5, 1), P3 = rpois(5, 3), P5 = rpois(5, 5))

# Function that (always) returns a single value > vector output
sapply(myList, median)

# Function that (always) returns 2 values > matrix output
sapply(myList, range)

# Function that (always) returns 5 values > matrix output
sapply(myList, quantile)

# Function that can return a variable number of values > list output
sapply(myList, function(X) X [ X > 2 ])

# Function that can return a variable number of values
# BUT it happens that the return values are of the same
# length > simplification occurs
sapply(myList, function(X) min(X):max(X))





lapply(split(airquality$Wind, airquality$Month), median)
sapply(split(airquality$Wind, airquality$Month), median)

lapply(split(airquality$Wind, airquality$Month), range)
sapply(split(airquality$Wind, airquality$Month), range)

matList <- list(
  P3 = matrix( rpois(8, 3), nrow = 2),
  P5 = matrix( rpois(8, 5), nrow = 2)
)
matList
lapply(matList, head, 1)
sapply(matList, head, 1)

args(tapply)

tapply(airquality$Wind, airquality$Month, median)
sapply(split(airquality$Wind, airquality$Month), median)


tapply(airquality$Wind, airquality$Month, quantile)

head(airquality)


tapply(airquality$Wind, 
       list(airquality$Month, cut(airquality$Temp, 3)), median)

with(airquality, tapply(Wind, list(Month, cut(Temp, 3)), median))


tapply(airquality$Wind, 
       list(airquality$Month, cut(airquality$Temp, 3), cut(airquality$Solar.R, 2)),
       median)

tapply(airquality$Wind, airquality$Month, quantile)
lapply(split(airquality$Wind, airquality$Month), quantile)


X <- tapply(airquality$Wind, 
       list(airquality$Month, cut(airquality$Temp, 3)), quantile)
class(X)
X
X[1,1]


head(airquality)   # Print airquality
windMedians <- tapply(airquality$Wind, airquality$Month, median)
windMedians

charMonths <- as.character(airquality$Month)   # Converted character values of Month
head()                 # Use character values to reference named elements

airquality$MedianWind <- windMedians [ charMonths ]             # Add Median Wind column
airquality$DiffWind <- airquality$Wind - airquality$MedianWind  # Calculate differences
head(airquality, 3)                                             # First few rows
tail(airquality, 3)                                             # Last few rows


aggregate(Wind ~ Month, data = airquality, FUN = median)
aggregate(Wind ~ Month + cut(Temp, 2), data = airquality, FUN = median)
aggregate(cbind(Wind, Ozone) ~ Month, data = airquality, FUN = median, na.rm = TRUE)


# Range of Wind values by Month
aggregate(Wind ~ Month, data = airquality, FUN = range, na.rm = TRUE)

# Range of Wind AND Ozone values by Month
aggregate(cbind(Wind, Ozone) ~ Month, data = airquality, FUN = range, na.rm = TRUE)

# Range of Wind AND Ozone values by Month AND grouped Temp
aggregate(cbind(Wind, Ozone) ~ Month + cut(Temp, 2), data = airquality, FUN = range, na.rm = TRUE)


aggregate(Wind ~ Month, data = airquality, 
  FUN = function(X) {
    c(MIN = min(X), MAX = max(X))    
  })


aggregate(list(aveWind = airquality$Wind), list(Month = airquality$Month), median)

aggregate(list(aveWind = airquality$Wind), 
  list(Month = airquality$Month, TempGroup = cut(airquality$Temp, 2)), median)


aggregate(list(aveWind = airquality$Wind, aveOzone = airquality$Ozone), 
          list(Month = airquality$Month), median, na.rm = TRUE)

aggregate(airquality[,c("Wind", "Ozone")], 
          list(Month = airquality$Month), median, na.rm = TRUE)

aggregate(list(Wind = airquality$Wind), 
  list(Month = airquality$Month), range)

aggregate(list(Wind = airquality$Wind), 
          list(Month = airquality$Month), 
          function(X) {
            c(MIN = min(X), MAX = max(X))
          })

windMedians <- aggregate(list(MedianWind = airquality$Wind),
                         list(Month = airquality$Month), median)

airquality <- merge(airquality, windMedians)
head(airquality)
airquality$DiffWind <- airquality$Wind - airquality$MedianWind
head(airquality)



for (col in c("Ozone", "Wind", "Temp")) {
  theMean <- mean(airquality$col, na.rm = TRUE)
  cat("\n The mean", col, "is", theMean)
}


for (col in c("Ozone", "Wind", "Temp")) {
  theMean <- mean(airquality[[col]], na.rm = TRUE)
  cat("\n The mean", col, "is", theMean)
}


for (i in 1:100) {
  cat("\n Hello")           # Writing a message
  if (runif(1) > .9) {
    cat(" - STOP!!")
    break  # 90% chance of stopping each time
  }
}


mapply(rpois, n = 1:5, lambda = 5:1)


objects(7) [ sapply(objects(7), function(X) class(get(X)) == "list") ]


