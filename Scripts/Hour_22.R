# ------------------------------------------------------------------------------
# Hour 22
# Formal Class Systems
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# S4

# Working with S4 Classes
showMethods("tail")

# Setting the Class
setClass("modInt4", slots=c(x = "integer", modulus = "integer"))

modInt4 <- function(x, modulus){
  # Create the object from the starting number, x and modulus, modulus
  # Divide by the modulus to get new number appropriate for that modulus
  x <- x %% modulus
  # Create a new instance
  new("modInt4", x = x, modulus = modulus)
}

# Try to create some objects of our class
#modInt4(pi, 12L)
#modInt4(4, 12)
modInt4(4L, 12L)


# Validity 
validModInt4Object <- function(object) {
  # Define checks 
  # Note that the class definition already ensures that x and mod are integer
  xNonNeg                 <- object@x >= 0 
  modulusPositive         <- object@modulus > 0
  xLessThanEqualToModulus <- object@x <= object@modulus
  # Combine checks
  isObjectValid <- xNonNeg & modulusPositive & xLessThanEqualToModulus
  # Return 
  isObjectValid
}

# Link the validity function with the modInt4 class
setValidity("modInt4", validModInt4Object)

# Methods 

showModInt4 <- function(object){
  # Extract the relevant components from the object
  theValue <- object@x
  theModulus <- object@modulus
  # Print the object in the desired form
  cat(theValue, " (mod ", theModulus, ")\n", sep = "")
}

# Link the previous function to the show generic and modInt4 class
setMethod("show", signature = "modInt4", showModInt4)

# Display an object 
modInt4(3L, 12L)

# Defining New Generics

square4 <- function(x){
  x^2
}
setGeneric("square4")

# Define a modInt4 method
squareModInt4 <- function(x) {
   # Standard square
   simpleSquare <- as.integer(x@x^2)   # Ensure value is valid
   # Use correct modulus
   modInt4(simpleSquare, x@modulus)
}

# Link the modInt4 method to the square4 generic and modInt4 class
setMethod("square4", signature = "modInt4", squareModInt4)

# Test the method
a <- modInt4(5L, 12L)
a
square4(a)

# Multiple Dispatch

add <- function(a, b){
  a + b
}
setGeneric("add")

# Define a function that adds modInt4 objects
addModInt4Objects <-  function(a, b){
  # Sometimes we still need to define checks within the method
  if(a@modulus != b@modulus){
    stop("Cannot add numbers of differing modulus")
  }
  # Add the numbers together
  totalNumber <- a@x + b@x
  # Return the correct class
  theResult <- modInt4(totalNumber, a@modulus)
  theResult
}

# Link the previous function to the add generic and modInt4 class
setMethod("add", signature = c(a = "modInt4", b = "modInt4"), 
          addModInt4Objects)

# Test the function
p <- modInt4(3L, 12L)
q <- modInt4(7L, 12L)
add(p, q)
add(q, q)

# Inheritance 

setClass("clockTime4", contains = "modInt4")

getSlots("clockTime4")
methods(class = "clockTime4")

# ------------------------------------------------------------------------------
# LISTING 22.1 Building a clockTime4 Class
# Define the class
setClass("clockTime4", contains = "modInt4")

# Define constructor
clockTime4 <- function(x){
  # Ensure that x is in mod 12
  x <- x %% 12L
  # Create a new instance
  new("clockTime4", x = x, modulus = 12L)
}

# Define validity
# Existing modInt4 validity is inherited
validclockTime4Object <- function(object) {
  isMod12 <- object@modulus == 12L
  isMod12
}

# Link the validity function with the clockTime4 class
setValidity("clockTime4", validclockTime4Object)

# Redefine show method
showclockTime4 <- function(object){
  # Print the object in the desired form
  cat(object@x, ":00\n", sep = "")
}
setMethod("show", signature = "clockTime4", showclockTime4)

# Test the class
clockTime4(5L)
clockTime4(13L)
# ------------------------------------------------------------------------------

# Documenting S4
#' An S4 Class that implements modular arithmetic
#' 
#' @slot x An integer value etc.
#' @slot modulus An integer value etc.
setClass("modInt4", slots=c(x = "integer", modulus = "integer"))

#' @describeIn add Adds two modInt4 objects of the same modulus
addModInt4Objects <-  function(a, b){
  # Sometimes we still need to define checks within the method
  if(a@modulus != b@modulus){
    stop("Cannot add numbers of differing modulus")
  }
  # Add the numbers together
  totalNumber <- a@x + b@x
  # Return the correct class
  theResult <- modInt4(totalNumber, a@modulus)
  theResult
}



# ------------------------------------------------------------------------------
# Reference Classes 

# Creating a New Reference Class
modIntRef <- setRefClass("modIntRef", 
                         fields=c(x = "integer", modulus = "integer"))

class(modIntRef)


a <- modIntRef(x = 3L, modulus = 12L)
a

b <- modIntRef$new(x = 4L, modulus = 6L)
b

# ------------------------------------------------------------------------------
# TIP
# What Does a Reference Class Contain?
objects(a)
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# LISTING 22.2 Defining an initialize Method

modIntRef$methods(list(initialize = function(x, modulus){
  # Create the object from the starting number, x and modulus, modulus
  # Divide by the modulus to get new number appropriate for that modulus
  # Assign fields *if* they are provided (ensures we can copy the object)
  if (!missing(x)) {
    x <<- x %% modulus
  }
  if (!missing(modulus)) {
    modulus <<- modulus
  }
}))
# ------------------------------------------------------------------------------

# Mutable Objects
x <- c(1, 3, 2)
sort(x)
x

x <- sort(x)
x

# ------------------------------------------------------------------------------
# LISTING 22.3 Defining Methods
modIntRef$methods(list(addNumber = function(aNumber){
  # Add aNumber to x locally
  x <<- x + aNumber
  # Ensure x is correct for the modulus
  x <<- x %% modulus
}))

a <- modIntRef$new(x = 3L, modulus = 12L)
a
a$addNumber(1L)
a
a$addNumber(10L)
a
# ------------------------------------------------------------------------------

# Copying Reference Class Objects
x <- 5
y <- x

x <- 6
x
y

# Remind ourselves of the value of a
a
# Create b as a copy of a in the traditional way
b <- a
b
# Add 1 to a
a$addNumber(1L)
a
b

# Traditional copy
rm(a)
rm(b)

a <- modIntRef$new(x = 3L, modulus = 12L)
b <- a$copy()

# ------------------------------------------------------------------------------
# R6 Classes

# An R6 Example

# ------------------------------------------------------------------------------
# LISTING 22.4 Defining an R6 Class
library(R6)
modInt6 <- R6Class("modInt6",
        # Define public elements
        public = list(
          # Fields
          x = NA, 
          modulus = NA, 
          # Methods
          initialize = function(x, modulus){
            if (!missing(x)) {
              self$x <- x %% modulus
            }
            if (!missing(modulus)) {
              self$modulus <- modulus
            }
          },
          show = function(){
            cat(self$x, " (mod ", self$modulus, ")", sep = "")
          },
          square = function(){
            self$x <- self$x^2
            # Use private method to ensure x < modulus
            private$adjustForModulus()
          }
        ),
        # Define private methods
        private = list(
          # Function to ensure correct modulus
          adjustForModulus = function(){
            self$x <- self$x %% self$modulus
          }
        )
)
a <- modInt6$new(3L, 12L)
a$show()
# Now square a
a$square()
a$show()
# ------------------------------------------------------------------------------








