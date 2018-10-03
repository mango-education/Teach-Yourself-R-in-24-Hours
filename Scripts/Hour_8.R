# [DESCRIPTION] R Script supporting Chapter 8 of the SAMS Book
# [AUTHOR] Richard Pugh

logRange <- function(X) {
  logX <- log(X)           # Takes logs of X
  round(range(logX), 2)    # Return (rounded) range of values
}
logRange(1:5)  # Only positive integers
logRange(-5:5) # Positive and negative integers

logRange <- function(X) {
  logX <- log(X)           # Takes logs of X
  round(range(logX), 2)    # Return (rounded) range of values
}
logRange(1:5)  # Only positive integers
logRange(-5:5) # Positive and negative integers

logRange <- function(X) {
  if (any(X <= 0))  stop("Negative Values found!")
  logX <- log(X)                  # Takes logs of X
  round(range(logX), 2)           # Return (rounded) range of values
}
logRange(1:5)  # Only positive integers
logRange(-5:5) # Positive and negative integers

logRange <- function(X) {
  if (any(X <= 0))  stop("Negative Values found!")
  cat("Made it this far!!\n")
  logX <- log(X)                  # Takes logs of X
  round(range(logX), 2)           # Return (rounded) range of values
}
logRange(1:5)  # Only positive integers
logRange(-5:5) # Positive and negative integers


logRange <- function(X) {
  if (any(X <= 0)) { 
    warning("Some values were <= 0. We will remove them")  
    X <- X [ X > 0 ]
  }
  logX <- log(X)                  # Takes logs of X
  round(range(logX), 2)           # Return (rounded) range of values
}
logRange(1:5)  # Only positive integers
logRange(-2:2) # Positive and negative integers


logRange <- function(X) {
  lessTest <- X <= 0              # Test for values <= 0
  if (any(lessTest)) { 
    nLess <- sum(lessTest)        # How many values
    outMessage <- paste(nLess, "values were <= 0. We will remove them")
    warning(outMessage)
    X <- X [ X > 0 ]
  }
  logX <- log(X)                  # Takes logs of X
  round(range(logX), 2)           # Return (rounded) range of values
}
logRange(1:5)  # Only positive integers
logRange(-2:2) # Positive and negative integers



logRange <- function(X) {
  lessTest <- X <= 0                              # Test for values <= 0
  if (all(lessTest)) stop("All values are <= 0")  # Stop if all <= 0
  if (any(lessTest)) {
    nLess <- sum(lessTest)        # How many values
    outMessage <- paste(nLess, "values were <= 0. We will remove them")
    warning(outMessage)
    X <- X [ X > 0 ]
  }
  logX <- log(X)                  # Takes logs of X
  round(range(logX), 2)           # Return (rounded) range of values
}
logRange(1:5)    # Only positive integers
logRange(-2:2)   # Positive and negative integers
logRange(-(1:5)) # All negative integers


logRange <- function(X) {
  if (any(X <= 0))  stop("Negative Values found!")
  logX <- log(X)                  # Takes logs of X
  round(range(logX), 2)           # Return (rounded) range of values
}
logRange(LETTERS)  # A Character vector

apropos("^is\\.")

letters        # The letters vector
mode(letters)  # It's a character vector

is.vector(letters)     # Is it a vector?
is.character(letters)  # Is it character?
is.matrix(letters)     # Is it a matrix?
is.numeric(letters)    # Is it numeric?





logRange <- function(X) {
  if (!is.numeric(X) | !is.vector(X)) stop("Need a numeric vector!")
  if (any(X <= 0)) stop("Negative Values found!")
  logX <- log(X)                  # Takes logs of X
  round(range(logX), 2)           # Return (rounded) range of values
}
logRange(1:10)        # A Numeric vector
logRange(LETTERS)     # A Character vector
logRange(airquality)  # A Data Frame



charNums <- c("1.65", "2.03", "9.88", "3.51")  # Create character vector
charNums
is.numeric(charNums)                           # Is it numeric?
convertNums <- as.numeric(charNums)            # Convert to numeric
is.numeric(convertNums)                        # Is it numeric now?
is.matrix(convertNums)                         # Is it a matrix?
matNums <- as.matrix(convertNums)              # Convert to matrix
is.matrix(matNums)                             # Is it a matrix now?
matNums                                        # Print the matrix

args(runif)                          # Arguments of runif
runif(n = 10, min = 1, max = 100)    # Call runif
hist(runif(n = 10, min = 1, max = 100))

allFuns <- apropos("*", mode = "function")
funArgs <- sapply(allFuns, function(X) {
  getFormals <- formals(get(X))
  any(names(getFormals) == "...")
})
allFuns <- allFuns [ funArgs ]
nArgs <- sapply(allFuns, function(X) {
  length(formals(get(X)))
})
allFuns <- allFuns [ nArgs >1 & nArgs < 5]
isMethod <- sapply(allFuns, function(X) {
  length(grep("UseMethod", body(get(X)))) > 0
})
allFuns <- allFuns [ !isMethod ]
allFuns <- allFuns [ -grep("^print", allFuns) ]
allFuns <- allFuns [ -grep("^summary", allFuns) ]
allFuns <- allFuns [ -grep("^Summary", allFuns) ]
allFuns


fruits <- c("apples", "bananas", "pears", "peaches")
paste("I like", fruits[1])
paste("I like", fruits[1], "and", fruits[2])
paste("I like", fruits[1], "and", fruits[2], "and", fruits[3])
paste("I like", fruits[1], "and", fruits[2], "and", fruits[3], "and", fruits[4])

args(paste)

hist(rnorm(1000), main = "Nice Red Histogram", col = "red")
args(hist)

genRandoms <- function(N, dist, mean = 0, sd = 1, lambda, min, max) {
  switch(dist, 
    "norm" = rnorm(N, mean = mean, sd = sd),
    "pois" = rpois(N, lambda = lambda),
    "unif" = runif(N, min = min, max = max))
}
genRandoms(10, "norm", mean = 5)
genRandoms(10, "unif", min = 1, max = 10)


genRandoms <- function(N, dist, ...) {
  switch(dist, 
         "norm" = rnorm(N, ...),
         "pois" = rpois(N, ...),
         "unif" = runif(N, ...))
}
genRandoms(10, "norm", mean = 5)
genRandoms(10, "unif", min = 1, max = 10)


histFun <- function(X, addLine = TRUE, col = "lightblue", main = "Histogram") {
  hist(X, col = col, main = main)
  if (addLine) abline(v = median(X), lwd = 2)
}
histFun(rnorm(1000), main = "New Title")


histFun <- function(X, addLine = TRUE, ...) {
  hist(X, ...)
  if (addLine) abline(v = median(X), lwd = 2)
}
histFun(rnorm(1000), col = "plum", xlab = "X AXIS LABEL")



genRandoms <- function(N, dist, ...) {
  switch(dist, 
         "norm" = rnorm(N, ...),
         "pois" = rpois(N, ...),
         "unif" = runif(N, ...))
}
genRandoms(10, "norm", mean = 5)
genRandoms(10, "Normal", mean = 5)


genRandoms <- function(N, dist, ...) {
  switch(dist, 
         "norm" = rnorm(N, ...),
         "pois" = rpois(N, ...),
         "unif" = runif(N, ...),
         stop(paste0("Distribution \"", dist, "\" not recognised")))
}
genRandoms(10, "norm", mean = 5)
genRandoms(10, "Normal", mean = 5)

genRandoms <- function(N, dist, ...) {
  dist <- match.arg(dist, choices = c("norm", "pois", "unif"))
  switch(dist, 
         "norm" = rnorm(N, ...),
         "pois" = rpois(N, ...),
         "unif" = runif(N, ...))
}
genRandoms(10, "norm", mean = 5)
genRandoms(10, "Normal", mean = 5)


genRandoms <- function(N, dist = c("norm", "pois", "unif"), ...) {
  dist <- match.arg(dist)  # Check validity if "dist" input
  switch(dist, 
         "norm" = rnorm(N, ...),
         "pois" = rpois(N, ...),
         "unif" = runif(N, ...))
}
genRandoms(10, "norm", mean = 5)
genRandoms(10, "Normal", mean = 5)



genRandoms <- function(N, dist = c("norm", "pois", "unif"), ...) {
  dist <- match.arg(dist)            # Check validity if "dist" input
  randFun <- get(paste0("r", dist))  # Get the function
  randFun(N, ...)                    # Run the function
}
genRandoms(10, "norm", mean = 5)
genRandoms(10, "pois", lambda = 3)

Day <- 1:7
Sales <- c(100, 120, 150, 130, 160, 210, 120)
plot(Day, Sales, type = "o")

plot(Day - 1, log(Sales), type = "o")

nicePlot <- function(X, Y) {
  plot(X, Y, type = "o")
}
nicePlot(Day, Sales)

x <- 1 + 2                        # Add 2 numbers
substitute(x <- 1 + 2)            # Capture the call
deparse(substitute(x <- 1 + 2))   # Convert this to character

nicePlot <- function(X, Y) {
  xLab <- deparse(substitute(X))   # Capture X input
  yLab <- deparse(substitute(Y))   # Capture Y input
  plot(X, Y, type = "o", xlab = xLab, ylab = yLab)
}
nicePlot(Day, Sales)


logFun <- function(X) stop("Your Error Message here!")
logFun(-2:2)

logFun <- function(X) stop("Your Error Message here!", call.=F)
logFun(-2:2)

addFun <- function(x, y) {
  warning("This is a warning!")
  x + y
}
addFun(1, 2)

addFun <- function(x, y) {
  warning("This is a warning!", immediate. = T)
  x + y
}
addFun(1, 2)

getDots <- function(...) {
  deparse(substitute(...))
}
getDots(1, 2)
getDots(x = 1, y = 2)

aFunction <- function(x, inputWithLongName, ...) {
  x + inputWithLongName
}
aFunction(x = 1, i = 2)

aFunction <- function(..., x, inputWithLongName) {
  x + inputWithLongName
}
aFunction(x = 1, i = 2)

theCall <- function(x) {
  deparse(substitute(x))
}
theCall(x = mean(Sales))
?match.arg
