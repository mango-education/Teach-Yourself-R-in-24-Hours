# ------------------------------------------------------------------------------
# Hour 21
# Writing R Classes
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# What Is a Class?

# Creating a New S3 Class
x <- 5
class(x)

class(x) <- "superNumber"
x

attributes(x)

# ------------------------------------------------------------------------------
# TIP
# Removing a Class
#set.seed(789)
aDF <- data.frame(X = 1:3, Y = rnorm(3))
aDF
unclass(aDF)
# ------------------------------------------------------------------------------

# A More Formal Approach to Creating Classes

# ------------------------------------------------------------------------------
# LISTING 21.1 Writing a Function to Generate a New Class
modInt <- function(x, modulus) {
  # Create the object from the starting number and modulus, "mod"
  # Divide by the modulus to get new number appropriate for that modulus
  object <- x %% modulus
  # Assign a class attribute to the object
  class(object) <- "modInt"
  # Store the modulus as an attribute
  attr(object, "modulus") <- modulus
  # Return the new object
  object
}
# Examples
modInt(3, 12)
modInt(13, 12)

# ------------------------------------------------------------------------------
# Generic Functions and Methods

print

print.modInt <- function(aModIntObject){
  # Extract the relevant components from the object
  theValue <- as.numeric(aModIntObject)
  theModulus <- attr(aModIntObject, "modulus")
  # Print the object in the desired form
  cat(theValue, " (mod ", theModulus, ")\n", sep = "")
}
x <- modInt(3, 12)
x

methods(class = "modInt")

methods("plot")

# Defining Methods for Arithmetic Operators

# ------------------------------------------------------------------------------
# LISTING 21.2
# Define a new method 'add' method for the modInt class
`+.modInt` <- function (x, y){
  # We can only add objects that are of the same modulus
  if(attr(x, "mod") != attr(y, "mod")){
    stop("Cannot add numbers of differing modulus")
  }
  # Add the numbers together
  totalNumber <- as.numeric(x) + as.numeric(y)
  # Ensure a number in the correct modulus is returned
  theResult <- modInt(totalNumber, attr(x, "mod"))
  # Next step useful for inheritance (later)
  class(theResult) <- class(x)
  theResult
}
# Examples
a <- modInt(7, 12)
b <- modInt(9, 12)
a + b
c <- modInt(3, 4)
#a + c
# ------------------------------------------------------------------------------

# List vs Attributes

# Define a new modIntList class using a list structure
modIntList <- function(x, modulus) {
  # Defne a list with two elements containing the number and modulus  
  object <- list(number = x %% modulus,
                 modulus = modulus)
  # Assign a class attribute to the object
  class(object) <- "modIntList"
  # Return the new object
  object
}

# Now define the print method
print.modIntList <- function(aModIntListObject){
  # Extract the relevant components from the object
  theValue <- aModIntListObject$number
  theModulus <- aModIntListObject$modulus
  # Print the object in the desired form
  cat(theValue, " (mod ", theModulus, ")\n", sep = "")
}

# Examples
modIntList(14, 6)

# Creating New Generics

# ------------------------------------------------------------------------------
# LISTING 21.3 Creating a New Generic
# Define a new generic
square <- function(x) { UseMethod("square", x) }

# Define new methods
# Start with the default method
square.default <- function(x) x^2

square.character <- function(x) paste(x, x, sep = "")

square.modInt <- function(x) {
  # Standard square
  simpleSquare <- as.numeric(x)^2 
  # Use correct modulus
  modInt(simpleSquare, attr(x, "mod"))
}

# Check functionality
square(2)
square("A")
x <- modInt(3, 4)
square(x)
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# Inheritance in S3

# library(data.table)   # If not already loaded
airDT <- data.table(airquality)
class(airDT)


clockTime <- function(x){
  # Fix x as mod 12
  x <- modInt(x, 12)
  # Define inheritance
  class(x) <- c("clockTime", class(x))
  x
}
theTime <- clockTime(13)
class(theTime)

# ------------------------------------------------------------------------------
# LISTING 21.4 Inheritance in Action

# Define a new print method for the clockTime class
print.clockTime <- function(aClockTimeObject){
  cat(as.numeric(aClockTimeObject), ":00\n", sep = "")
}

# Examples
time1 <- clockTime(5)
time2 <- clockTime(42)
time1
time2

# Add together to demonstrate inheritance
time1 + time2
# ------------------------------------------------------------------------------














