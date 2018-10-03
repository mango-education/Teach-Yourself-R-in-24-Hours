# [DESCRIPTION] R Script supporting Chapter 4 of the SAMS Book
# [AUTHOR] Richard Pugh

# -----------------------------------------------------------------------
# Multi-Mode Structures

# Attempting to create a multi-mode vector
c(1, 2, 3, "Hello")                 # Multiple modes
c(1, 2, 3, TRUE, FALSE)             # Multiple modes
c(1, 2, 3, TRUE, FALSE, "Hello")    # Multiple modes

# Attempting to create a multi-mode vector
weather <- cbind(
  Day   = c("Saturday", "Sunday", "Monday", "Tuesday", "Wednesday"),
  Date  = c("Jul 4", "Jul 5", "Jul 6", "Jul 7", "Jul 8"), 
  TempF = c(75, 86, 83, 83, 87)
)
weather
mode(weather)

# -----------------------------------------------------------------------
# Lists

# Create an empty list
emptyList <- list()   
emptyList

# Create an unnamed list
aVector <- c(5, 7, 8, 2, 4, 3, 9, 0, 1, 2)
aMatrix <- matrix( LETTERS[1:6], nrow = 3)
unnamedList <- list(aVector, aMatrix)
unnamedList

# Create an unnamed list
unnamedList <- list(c(5, 7, 8, 2, 4, 3, 9, 0, 1, 2), 
                    matrix( LETTERS[1:6], nrow = 3))
unnamedList

# Create a named list
namedList <- list(VEC = aVector, MAT = aMatrix)
namedList

# Create an unnamed list
namedList <- list(VEC = c(5, 7, 8, 2, 4, 3, 9, 0, 1, 2), 
                    MAT = matrix( LETTERS[1:6], nrow = 3))
namedList

# Create an empty list
emptyList <- list()                     

# -----------------------------------------------------------------------
# Summary of creating

# 2 Ways of Creating an unnamed list containing a vector and a matrix
unnamedList <- list(aVector, aMatrix)   
unnamedList <- list(c(5, 7, 8, 2, 4, 3, 9, 0, 1, 2), 
                    matrix( LETTERS[1:6], nrow = 3))

# 2 Ways of Creating a named list containing a vector and a matrix
namedList <- list(VEC = aVector, MAT = aMatrix)
namedList <- list(VEC = c(5, 7, 8, 2, 4, 3, 9, 0, 1, 2), 
                  MAT = matrix( LETTERS[1:6], nrow = 3))

# Printing the Lists
emptyList         # An empty list
unnamedList       # A list with unnamed elements
namedList         # A list with element names

# -----------------------------------------------------------------------
# List Attributes

# Length of the list
length(emptyList)
length(unnamedList)
length(namedList)

names(emptyList)
names(unnamedList)
names(namedList)

mode(emptyList)
mode(unnamedList)
mode(namedList)

# -----------------------------------------------------------------------
# Subscripting Lists
namedList[]  # Blank subscript

# -----------------------------------------------------------------------
# Positive Integer Subscripts
subList <- namedList [ 1 ]   # Return first element
subList                      # Print the new object
length(subList)              # Number of elements in the list
class(subList)               # Check the "class" of the object

# -----------------------------------------------------------------------
# NOTE: An Objects Class
aMatrix <- matrix(1:6, nrow = 2)      # Create a numeric matrix
aMatrix                               # Print the matrix
mode(aMatrix)                         # Mode of data held in this object
class(aMatrix)                        # Type of object

# -----------------------------------------------------------------------
# Negative Integer Subscripts
namedList [ -1 ]   # Return all but the first element
namedList

# -----------------------------------------------------------------------
# Logical Subscripts
namedList
namedList [ c(T, F) ]  # Vector of logical values

# -----------------------------------------------------------------------
# Character Subscripts
namedList
namedList [ "MAT" ]  # Vector of Character values

# -----------------------------------------------------------------------
# Double Square Bracket Referencing
namedList              # The original list
namedList [[1]]        # The first element
namedList [[2]]        # The second element
mode(namedList [[2]])  # The mode of the second element

namedList [1]          # Return a list containing 1 element
namedList [[1]]        # Return the first element of the list (a vector)

# -----------------------------------------------------------------------
# Referencing Named Elements with $
namedList              # Print the original list
namedList[[1]]         # Return the first element
namedList$VEC          # Return the "VEC" element

# -----------------------------------------------------------------------
# Double Square Brackets versus $
unnamedList        # List with no element names
unnamedList[[1]]   # First element
namedList          # List with element names
namedList$VEC      # The "VEC" element

# -----------------------------------------------------------------------
# TIP: Shortened $ Referencing
aList <- list( first = 1, second = 2, third = 3, fourth = 4 )
aList$s   # Returns the second
aList$fi  # Returns the first
aList$fo  # Returns the fourth

# -----------------------------------------------------------------------
# Adding List Elements
emptyList                          # Empty list
emptyList[[1]] <- LETTERS[1:5]     # Add an element
emptyList                          # Updated (non)empty list

emptyList <- list()                # Recreate the empty list
emptyList                          # Empty list
emptyList$ABC <- LETTERS[1:5]      # Add an element
emptyList                          # Updated (non)empty list

# -----------------------------------------------------------------------
# NOTE: Adding Non-Consecutive Elements
emptyList <- list()                # Recreate the empty list
emptyList                          # Empty list
emptyList[[3]] <- "Hello"          # Assign to third element
emptyList

# -----------------------------------------------------------------------
# Combining Lists
list1 <- list(A = 1, B = 2)   # Create list1
list2 <- list(C = 3, D = 4)   # Create list2
c(list1, list2)               # Combine the lists

# -----------------------------------------------------------------------
# Unnamed List Summary
unnamedList <- list(aVector, aMatrix)   # Create the list
unnamedList                             # Print the list
length(unnamedList)                     # Number of elements
names(unnamedList)                      # No element names

unnamedList[1]                          # Subset the list
unnamedList[[1]]                        # Return the first element
unnamedList[[3]] <- 1:5                 # Add a new element
unnamedList

# -----------------------------------------------------------------------
# Overview of Named Lists
namedList <- list(VEC = aVector, MAT = aMatrix)   # Create the list
namedList                             # Print the list
length(namedList)                     # Number of elements
names(namedList)                      # Element names

namedList[1]                          # Subset the list
namedList$VEC                         # Return the first element
namedList$NEW <- 1:5                  # Add a new element
namedList

set.seed(109)
nExtremes <- rpois(100, 3)                # Simulate number of extreme values by day from a Poisson distribution
nExtremes[1:5]                            # First 5 numbers

# Define function that simulates "N" extreme values
exFun <- function(N) round(rweibull(N, shape = 5, scale = 1000))
extremeValues <- lapply(nExtremes, exFun) # Apply the function to our simulated numbers
extremeValues[1:5]                        # First 5 simulated outputs

median(sapply(extremeValues, length))     # Average number of simulated extremes
median(sapply(extremeValues, sum))        # Average extreme value

theTest <- t.test(1:10, y = c(7:20))      # Perform a T-Test 
theTest
names(theTest)        # Names of list elements
theTest$p.value       # Reference the p-value

# DATA FRAMES
print.default(theTest)

weather <- data.frame(
  Day   = c("Saturday", "Sunday", "Monday", "Tuesday", "Wednesday"),
  Date  = c("Jul 4", "Jul 5", "Jul 6", "Jul 7", "Jul 8"), 
  TempF = c(75, 86, 83, 83, 87)
)
weather

print.default(weather)

data.frame(X = 1:5, Y = 1:2)  # throws an error

length(weather)           # Number of columns
names(weather)            # Column names

weather         # The whole data frame 
weather[[3]]    # The "third" column
weather$TempF   # The "TempF" column

weather$TempC <- round((weather$TempF - 32) * 5/9)
weather

weather$TempF [ ]  # All values of TempF column

weather$TempF [ 1:3 ]  # First 3 values of the TempF column
weather$TempF [ -(1:3) ]  # Omit the first 3 values of the TempF column


weather$TempF
weather$TempF [ c(F, T, F, F, T) ]    # Logical subscript

weather$TempF [ weather$TempF > 85 ]  # Logical subscript

weather$Day [ weather$TempF > 85 ]    # Logical subscript


nrow(weather)   # Number of rows
ncol(weather)   # Number of columns

weather[ , ]           # Blank, Blank
weather[ 1:4, 1:3 ]    # +ive, +ive
weather[ -1, -3 ]      # -ive, -ive
weather[ 1:4, ]        # +ive, Blank

weather
weather[ c(F, T, F, F, T), ]  # Logical, Blank
weather[ weather$TempF > 85, ]  # Logical, Blank

weather[ weather$Day != "Sunday", ]  # Logical, Blank

weather[ weather$TempF > 85, c("Day", "TempC")]  # Logical, Character

weather$Day [ weather$TempF > 85 ]                  # Days where TempF > 85
weather [ weather$TempF > 85 , ]                    # All data where TempF > 85
weather [ weather$TempF > 85 , c("Day", "TempF") ]  # 2 columns where TempF > 85

nrow(iris)
head(iris)

head(iris, 2)   # Return only the first 3 rows

tail(iris)      # Return only the last 6 rows
tail(iris, 2)   # Return only the last 2 rows

View(iris)      # Open the iris data in the data grid viewer

summary(iris)   # Produce a textual summary

pairs(iris)   # Scattermatrix Plot of iris

nestedList <- list(A = 1, B = list(C = 3, D = 4))
nestedList        # A nested list
nestedList$B$C    # Extract the C element within the B element


weather           # The full dataset
col <- "TempC"    # The column we want to select
weather[[col]]    # Return the TempC column

weather [ , c("Day", "TempC") ]   # All rows, 2 columns
weather [ c("Day", "TempC") ]     # 2 vector elements


weather [ , c("Day", "TempC") ]   # 2 columns - returns a data frame
weather [ , "TempC" ]             # 1 column - returns a vector
weather [ , "TempC", drop = F ]   # 1 column - retain dimensions





