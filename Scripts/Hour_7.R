# [DESCRIPTION] R Script supporting Chapter 7 of the SAMS Book
# [AUTHOR] Richard Pugh

myMat <- matrix(rpois(9, 4), 3)
myMat                       # A sample matrix
upper.tri(myMat)            # Upper triangle
myMat [ upper.tri(myMat) ]  # Values from upper triangle
upper.tri                   # Print the upper.tri function

# Create a simple function

addOne <- function(x) {
  x + 1
}
addOne(1:5)

addOne <- function(x) x + 1
addOne(1:5)

result <- addOne(1:5)
result

rm(median)

X <- 1:5                            # Create a vector
median(X)                           # The median of the vector is 3
find("median")                      # Where is the "median" function?

median <- function(input) "Hello"   # Create a new "median" function
median(X)                           # The median of the vector is "Hello"
find("median")                      # Where is the "median" function?

rm(median)                          # Remove the "median" function from the workspace
median(X)                           # The median of the vector is 3


addOne <- function(x) {
  x + 1
}
addOne(1:5)

addNumber <- function(x, number) {
  x + number
}
addNumber(x = 1:5, number = 2)


addNumber()                     # Calling with no arguments
addNumber(x = 1:5)              # Calling with only the "x" argument
addNumber(number = 2)           # Calling with only the "number" argument
addNumber(x = 1:5, number = 2)  # Calling with both arguments

addNumber <- function(x, number = 0) {
  x + number
}
addNumber(x = 1:5)               # Call function with default (number = 0)
addNumber(x = 1:5, number = 1)   # Call function with number = 1


addNumber <- function(x, number = 0) {
  theAnswer <- x + number    # Create "theAnswer" by adding "x" and "Number"
  theAnswer                  # Return the value
}
addNumber(x = 1:5)               # Call function with default (number = 0)

output <- addNumber(x = 1:5, number = 1)     # Call the function creating "output" object
output                                       # Look at value of "output" 
theAnswer                                    # "theAnswer" object does not exist

plusAndMinus <- function(x, y) {
  PLUS <- x + y                 # Define "PLUS"
  MINUS <- x - y                # Define "MINUS"
  PLUS                          # Return "PLUS"
  MINUS                         # Return "MINUS"
}
plusAndMinus(x = 1:5, y = 1:5)  # Call function

plusAndMinus <- function(x, y) {
  PLUS <- x + y                 # Define "PLUS"
  MINUS <- x - y                # Define "MINUS"
  MINUS                         # Return "MINUS"
  PLUS                          # Return "PLUS"
}
plusAndMinus(x = 1:5, y = 1:5)  # Call function

plusAndMinus <- function(x, y) {
  PLUS <- x + y                 # Define "PLUS"
  MINUS <- x - y                # Define "MINUS"
  list(PLUS, MINUS)             # Return "PLUS" and "MINUS" in a list
}
plusAndMinus(x = 1:5, y = 1:5)  # Call function


plusAndMinus <- function(x, y) {
  PLUS <- x + y                    # Define "PLUS"
  MINUS <- x - y                   # Define "MINUS"
  list(plus = PLUS, minus = MINUS) # Return "PLUS" and "MINUS" in a list
}
output <- plusAndMinus(x = 1:5, y = 1:5)  # Call function, saving the output
output                                    # Print the output
output$plus                               # Print the "plus" element

summaryFun <- function(vec, digits = 3) {
  
  # Create some summary statistics
  theMean <- mean(vec)        
  theMedian <- median(vec)
  theMin <- min(vec)
  theMax <- max(vec)
  
  # Combine them into a single vector and round the values
  output <- c(Mean = theMean, Median = theMedian, Min = theMin, Max = theMax)
  round(output, digits = digits)
}

X <- rnorm(50)   # Generate 50 samples from a normal distribution
summaryFun(X)    # Produce summaries of the vector

if (something is true) {
  do this
}
else {
  do this instead
}

posOrNeg <- function(X) {
  if (X > 0) {
    cat("X is Positive")
  }
  else {
    cat("X is Negative")
  }
}
posOrNeg(1)    # is 1 positive or negative?
posOrNeg(-1)   # is -1 positive or negative?

posOrNeg(0)    # is 0 positive or negative?

posOrNeg <- function(X) {
  if (X > 0) {
    cat("X is Positive")
  }
  else {
    if (X == 0) cat("X is Zero")
    else cat("X is Negative")
  }
}
posOrNeg(1)    # is 1 positive or negative?
posOrNeg(0)    # is 0 positive or negative?

posOrNeg <- function(X) {
  if (X > 0) {
    cat("X is Positive")
  }
  else {
    cat("")
  }
}
posOrNeg(1)    # is 1 positive or negative?
posOrNeg(0)    # is 0 positive or negative?

posOrNeg <- function(X) {
  if (X > 0) {
    cat("X is Positive")
  }
}
posOrNeg(1)    # is 1 positive or negative?
posOrNeg(0)    # is 0 positive or negative?


X <- 1  # Set X to 1
X > 0   # Is X greater than 0?

X <- 0  # Set X to 0
X > 0   # Is X greater than 0?

posOrNeg <- function(X) {
  if (X > 0) cat("X is Positive")
  else cat("X is Negative")
}
posOrNeg(-2:2)    # is 1 positive or negative?

X <- -2:2  # Set X to -2:2
X > 0      # Is X greater than 0?

X <- -2:2  # Set X to -2:2
X > 0      # Is X greater than 0?
all(X > 0) # Are all values of X greater than 0?
any(X > 0) # Are any values of X greater than 0?

X <- -2:2  # Set X to -2:2
X > 0      # Is X greater than 0?
!X > 0     # Reverse logical values

posOrNeg <- function(X) {
  if (all(X > 0)) cat("\nAll values of X are greater than 0")
  if (!all(X > 0)) cat("\nNot all values of X are greater than 0")
  if (any(X > 0)) cat("\nAt least 1 value of X is greater than 0")
  if (!any(X > 0)) cat("\nNo values of X are greater than 0")
}
posOrNeg(1:5)       # All > 0
posOrNeg(-2:2)      # Some > 0, Some <= 0
posOrNeg(-(1:5))    # All <= 0

cat("Hello\nthere")

posOrNeg <- function(X) {
  if (all(X > 0)) cat("All values of X are > 0")
  else {
    if (any(X > 0)) cat("At least 1 value of X is > 0")
    else cat("No values are > 0")
  }
}
posOrNeg(-2:2)
posOrNeg(1:5)
posOrNeg(-(1:5))


logVector <- function(vec, logIt = FALSE) {
  if (logIt == TRUE) vec <- log(vec)
  else vec <- vec
  vec
}
logVector(1:5)
logVector(1:5, logIt = TRUE)  # Call the function with logIt = TRUE


logVector <- function(vec, logIt = FALSE) {
  if (logIt == TRUE) vec <- log(vec)
  vec
}
logVector(1:5)
logVector(1:5, logIt = TRUE)  # Call the function with logIt = TRUE


logVector <- function(vec, logIt = FALSE) {
  if (logIt) vec <- log(vec)
  vec
}
logVector(1:5)
logVector(1:5, logIt = TRUE)  # Call the function with logIt = TRUE

betweenValues <- function(X, Min = 1, Max = 10) {
  if (X >= Min & X <= Max) cat(paste("X is between", Min, "and", Max))
  if (X < Min | X > Max) cat(paste("X is NOT between", Min, "and", Max))
}
betweenValues(5)
betweenValues(5, -2, 2)


logVector <- function(vec, logIt = FALSE) {
  if (all(vec > 0) & logIt) vec <- log(vec)
  vec
}
logVector(1:5, logIt = TRUE)  # Logs the data
logVector(-5:5, logIt = TRUE) # Doesn't log the data because first condition not met


logVector <- function(vec) {
  if (all(vec > 0) & all(log(vec) <= 2)) cat("Numbers in range")
  else cat("Numbers not in range")
}
logVector(1:10)
logVector(1:5)

logVector(-2:2)

logVector <- function(vec) {
  if (all(vec > 0) && all(log(vec) <= 2)) cat("Numbers in range")
  else cat("Numbers not in range")
}
logVector(-2:2)

verboseFunction <- function(X) {
  if (all(X > 0)) output <- X
  else {
    X [ X <= 0 ] <- 0.1
    output <- log(X)
  }
  output
}
verboseFunction(-2:2)

verboseFunction <- function(X) {
  if (all(X > 0)) return(X)   # Return early

  # Carry on if not returned already
  X [ X <= 0 ] <- 0.1
  log(X)
}
verboseFunction(-2:2)


summaryFun <- function(vec, digits = 3) {
  N <- length(vec)                     # Calculate the number of values in "vec"
  if (N == 0) return(NULL)             # Return NULL if "vec" is empty
  
  testMissing <- is.na(vec)            # Look for missing values
  if (all(testMissing)) {
    output <- c( N = N, nMissing = N, pMissing = 100)  
    return(output)                     # Return simple summary if all missing values
  }

  nMiss <- sum(testMissing)            # Calculate the number of missing values
  pMiss <- 100 * nMiss / N             # Calculate the percentage of missing values
  vec <- vec [ !testMissing ]          # Remove missings from the vector
  someStats <- c(Mean = mean(vec), Median = median(vec), SD = sd(vec),
      Min = min(vec), Max = max(vec))  # Calculate a number of statistics
  
  output <- c(someStats, N = N, nMissing = nMiss, pMissing = pMiss)
  round(output, digits = digits)
}
summaryFun(c())                        # Empty Vector
summaryFun(rep(NA, 10))                # Vector of missing values
summaryFun(1:10)                       # Basic numeric vector
summaryFun(airquality$Ozone)           # Vector containing missings

addOne <- function(X) {
  doubleMe <- function(Y) Y * 2
  doubleMe(X + 1)
}
addOne(1:5)


addOne <- function(X) {
  doubleMe <- function() X * 2
  X <- doubleMe(X)
  X
}
addOne(1:5)


allMissings <- rep(NA, 5)
all(allMissings > 0)
any(allMissings > 0)

someMissings <- c(NA, 1:4)
all(someMissings > 0)
any(someMissings > 0)



testMissing <- function(X) {
  if (X > 0) cat("Success")
}
testMissing(NA)

  oneMissing <- NA
oneMissing > 0


qaFun <- function(X) {
  addOne <- X + 1
  minusOne <- X - 1
  c(ADD = addOne, MINUS = minusOne)
}
result <- qaFun(1)
result

X <- -(1:5)
!all(X > 0)
  