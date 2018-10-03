# [DESCRIPTION] R Script supporting Chapter 3 of the SAMS Book
# [AUTHOR] Richard Pugh

# ------------------------------------------------------------------------------
# The R Data Types
4 + 5     # numeric
"Hello"   # character
4 > 5     # logical (is 4 greater than 5)
3 + 4i    # complex

# ------------------------------------------------------------------------------
# The mode Function
X <- 4 + 5      # Assign a (numeric) value to X
X               # Print the value of X
mode(X)         # The mode of X

X < 10          # Logical statement: is X less than 10?
mode(X < 10)    # The mode of this data

# ------------------------------------------------------------------------------
# Vectors, Matrices and Arrays

# ------------------------------------------------------------------------------
# Creating Elements with the c Function
numericVector <- c(2, 6, 8, 4, 2, 9, 4, 0)  # Vector of numerics
numericVector              # Print the numeric vector
mode(numericVector)        # What is the mode of "numericVector"?

c("Hello", "There")        # Vector of characters
c(F, T, T, F, F, T, F, F)  # Vector of logicals
c(3+4i, 5+9i, 3+7i)        # Vector complex numbers

# ------------------------------------------------------------------------------
# NOTE: Logical Values
c(T, F, TRUE, FALSE)

# ------------------------------------------------------------------------------
# Creating vectors
X <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)   # Create a simple vector of numerics
X                                       # Print the vector
c(X, X, X, X, X)                        # Combine vectors

# ------------------------------------------------------------------------------
# TIP: Multi-Mode Structures
c(1, 2, 3, "Hello")                 # Multiple modes
c(1, 2, 3, TRUE, FALSE)             # Multiple modes
c(1, 2, 3, TRUE, FALSE, "Hello")    # Multiple modes

# ------------------------------------------------------------------------------
# Creating a Sequence of Integers
X <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)   # Create a simple vector of numerics
X                                       # Print the vector
1:100   # Series of values from 1 to 100

# Sequences
1:5
5:1
-1:1
1.3:5.3

# Combining Sequences
c(0:4, 5, 4:0)

# Multiplying Sequences
2*1:10

# ------------------------------------------------------------------------------
# Creating a Sequence of Numeric Values with the seq Function
1:10
seq(1, 10)

# The by argument
seq(1, 10, by = 0.5)   # Sequence from 1 to 10 by 0.5
seq(2, 20, by = 2)     # Sequence from 2 to 20 by 2
seq(5, -5, by = -2)    # Sequence from 5 to -5 by -2

# The length argument
seq(1.3, 8.4, by = 0.3)     # Sequence from 1.3 to 8.4 by 0.3
seq(1.3, 8.4, length = 10)  # Sequence of 10 values from 1.3 to 8.4

# ------------------------------------------------------------------------------
# Creating a Sequence of Repeated Values
rep("Hello", 5)  # Repeat "Hello" 5 times

X <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
rep(X, 5)        # Repeat the X vector 5 times

X <- 1:10
rep(X, 5)        # Repeat the X vector 5 times

rep(1:10, 5)      # Repeat 1:10 5 times

rep( c("A", "B", "C"), c(4, 1, 3))

# Repeated multiple sequences
rep( c("A", "B", "C"), c(3, 3, 3))
rep( c("A", "B", "C"), rep(3, 3))
rep( c("A", "B", "C"), each = 3)

# ------------------------------------------------------------------------------
# CAUTION: Nested Calls
rep( c("A", "B", "C"), rep(3, 3))
theVector <- c("A", "B", "C")  # Vector to repeat
repTimes <- rep(3, 3)          # Number of times to repeat the vector
rep(theVector, repTimes)       # Repeat the vector

rep( c("A", "B", "C"), 3)           # Repeat the vector 3 times
rep( c("A", "B", "C"), c(4, 1, 3))  # Repeat each value a specific number of times
rep( c("A", "B", "C"), each = 3)    # Repeat each value 3 times

# ------------------------------------------------------------------------------
# Vector Attributes
X <- c(6, 8, 3, 1, 7)  # Create a simple vector
X                      # Print the vector
mode(X)                # The mode of the vector

length(X)              # Number of elements

# ------------------------------------------------------------------------------
# NOTE: Missing Values
Y <- c(4, 5, NA, 1, NA, 0)
Y
length(Y)

# Element names
X <- c(6, 8, 3, 1, 7)  # Create a simple vector
X                      # Print the vector
names(X)               # Element names of X

# An example of element names to identify values
genderFreq <- c(165, 147)
genderFreq

genderFreq <- c(Female = 165, Male = 147)  # Create a vector with element names
genderFreq

genderFreq <- c(165, 147)                  # Create a vector with no element names
genderFreq
names(genderFreq) <- c("Female", "Male")   # Assign element names
genderFreq

genderFreq           # Print the vector
names(genderFreq)    # Return the element names

# ------------------------------------------------------------------------------
# Subscripting Vectors

# ------------------------------------------------------------------------------
# CAUTION: Square versus Round Brackets
X     # A vector called X
X[]   # Using square brackets
X()   # Error when using round brackets

# ------------------------------------------------------------------------------
# Subscripting Vectors: Blank Inputs
X <- c(6, 8, 3, 1, 7)  # Create a simple vector
X                      # Print the values
X [ ]                  # Blank input

# ------------------------------------------------------------------------------
# Subscripting Vectors: Positive Integers
X                      # Print the values
X [ c(1, 3, 5) ]       # 1st, 3rd and 5th elements

index <- c(1, 3, 5)   # Create index vector 
X [ index ]           # 1st, 3rd and 5th elements

X [ c(1:2, 4:5) ]    # Return the 1st, 2nd, 4th and 5th elements

# ------------------------------------------------------------------------------
# Subscripting Vectors: Negative Integers
X [ c(1:2, 4:5) ]    # Omit 3rd value using positive integers
X [ -3 ]             # Omit 3rd value using negative integers

X [ c(-2, -4) ]   # Omit 2nd and 4th values
X [ -c(2, 4) ]    # Omit 2nd and 4th values

# Excluding "outliers"
Y <- c(6, 9, 4, 3, 6, 8, 1, 9, 0, 3, 4, 8, 7, 4, 5)
outliers <- c(4, 7, 9, 11, 15)
Y                 # Vector of values to subset
outliers          # Index of values to omit
Y [ -outliers ]   # Omit the values specified in outliers

# ------------------------------------------------------------------------------
# Subscripting Vectors: Logical Integers
X                       # Original vector
c(T, T, F, F, T)        # Vector of logical values
X [ c(T, T, F, F, T)]   # Return corresponding TRUE values only

X            # Original vector
X > 5        # Logical statement: where is X > 5?
X [ X > 5 ]  # Subset where values of X are greater than 5

# Range of logical values
X > 6            # Greater than 6
X >= 6           # Greater than or equal to 6
X < 6            # Less than 6
X <= 6           # Less than or equal to 6
X == 6           # X is equal to 6
X != 6           # X is not equal to 6
X > 2 & X <= 6   # Between 2 (exclusive) and 6 (inclusive)
X < 2 | X > 6    # Less than 2 or greater than 6

X                      # Original vector
X [ X <= 6 ]           # Values less than or equal to 6
X [ X != 6 ]           # Values that are not equal to 6
X [ X >= 3 & X <= 7 ]  # Values between 3 and 7

# Referencing Values
ID <- 1001:1005
AGE <- c(18, 35, 26, 42, 22)
GENDER <- c("M", "F", "M", "F", "F")

ID         # Vector of ID values
AGE        # Vector of ages
GENDER     # Vector of genders

AGE [ AGE > 25 ]                 # Vectors of AGE that are greater than 25
ID [ AGE > 25 ]                  # ID values corresponding to AGE greater than 25
ID [ AGE > 25 & GENDER == "F" ]  # ID values corresponding to AGE greater than 25 and GENDER is "F"

# ------------------------------------------------------------------------------
# Subscripting Vectors: Character References
names(X) <- c("A", "B", "C", "D", "E")   # Add element names
X                                        # Original vector
X[c("A", "C", "E")]                      # Reference based on names

# ------------------------------------------------------------------------------
# Subscripting Vectors: Summary
X [ ]                     # Blank: all values returned
X [ c(1, 3, 5) ]          # Positives: Positions to return
X [ -c(1, 3, 5) ]         # Negatives: Positions to omit
X [ X > 5 ]               # Logical: TRUE values returned
X [ c("A", "C", "E") ]    # Character: Named elements returned

# ------------------------------------------------------------------------------
# TIP: Sequence of Letters
letters
LETTERS
letters [ 1:5 ]  # First 5 (lower case) letters
LETTERS [ 1:5 ]  # First 5 (upper case) letters

# ------------------------------------------------------------------------------
# Matrices

# Combining Vectors to create a matrix
cbind(1:3, 3:1, c(2, 4, 6), rep(1, 3))

# ------------------------------------------------------------------------------
# NOTE: Recycling
cbind(1:3, 3:1, c(2, 4, 6), 1)
cbind(1:3, 3:1, c(2, 4), 1)

# Using rbind
rbind(1:3, 3:1, c(2, 4, 6), rep(1, 3))

# ------------------------------------------------------------------------------
# TIP: Transposing Matrices
cbind(1:3, 3:1, c(2, 4, 6), rep(1, 3))
t(rbind(1:3, 3:1, c(2, 4, 6), rep(1, 3)))

# ------------------------------------------------------------------------------
# Creating a Matrix with a Single Vector
matrix(1:12)
matrix(1:12, nrow = 3, ncol = 4)
matrix(1:12, nrow = 3)

matrix(1:12, nrow = 3, byrow = FALSE)
matrix(1:12, nrow = 3, byrow = TRUE)

# ------------------------------------------------------------------------------
# Matrix Attributes
aVector <- c(4, 5, 2, 7, 6, 1, 5, 5, 0, 4, 6, 9)  # Create a vector
X <- matrix(aVector, nrow = 3)                    # Create a matrix
X                                                 # Print the matrix
mode(X)                                           # The mode of the matrix

length(X)   # Number of elements

dim(X)     # Dimension of the matrix
dim(X)[1]  # Number of rows
dim(X)[2]  # Number of columns

nrow(X)  # Number of rows
ncol(X)  # Number of columns

freqMatrix <- cbind( c(75, 52, 38), c(68, 49, 30))
freqMatrix
dimnames(freqMatrix) <- list(c("18-35", "26-35", "36+"), c("Female", "Male"))
freqMatrix

dimnames(freqMatrix) 

# ------------------------------------------------------------------------------
# Subscripting Matrices: Blanks, Positives, and Negatives
X [ , ]  # Blank for rows, blank for columns
X [ 1:2 , c(1, 3, 4) ]  # +ives for rows, +ives for columns
X [  , -2 ]  # Blank for rows, -ives for columns

# ------------------------------------------------------------------------------
# Dropping Dimensions
X [ , 1:2 ]   # First 2 columns - returns a matrix

X [ , 1 ]                # Returns a vector
X [ , 1, drop = FALSE ]  # Use drop to maintain dimensions

# ------------------------------------------------------------------------------
# Subscripting Matrices: Logical Values
X                     # Original Matrix
X [ c(T, F, T), ]     # Logicals for rows, blank for columns

X [ , 1 ]               # 1st column
X [ , 1 ] != 5          # Where is the 1st column not 5
X [ X [ , 1 ] != 5 , ]  # Use to subscript the data

# ------------------------------------------------------------------------------
# Subscripting Matrices: Character Values
dimnames(X) <- list( letters[1:3], LETTERS[1:4] )
X

X [ c("a", "c"), ]   # Characters for rows, blank for columns


X [ , c("A", "C", "D") ]   # Blank for rows, Characters for columns

# ------------------------------------------------------------------------------
# Arrays

# ------------------------------------------------------------------------------
# Creating Arrays
aVector <- c(4, 5, 2, 7, 6, 1, 5, 5, 0, 4, 6, 9)  # Create a vector
X <- array(aVector, dim = c(3, 4))                # Create a matrix using the array function
X                                                 # Print the matrix

aVector
X <- array(rep(aVector, 3), dim = c(3, 4, 3))     # Create a 3D array
X                                                 # Print the array

# ------------------------------------------------------------------------------
# Array Attributes
mode(X)    # Mode of array
length(X)  # Number of elements in array
dim(X)     # Dimension of array

dimnames(X) <- list(letters[1:3], LETTERS[1:4], c("X1", "X2", "X3"))
X

# ------------------------------------------------------------------------------
# Subscripting Arrays
X [ , , 1 ]         # Blank / Blank / Positive
X [ -1, 1:2, 1:2 ]  # Negative / Positive / Positive

# ------------------------------------------------------------------------------
# Relationship Between Single-Mode Data Objects
X <- c(2, 6, 5, 1, 2, 8, 9, 4, 3, 1, 9, 4)   # Create a vector
X                                            # Print the vector
length(X)                                    # Vector has 12 elements
dim(X)                                       # Vectors have no "dimension"

dim(X) <- c(3, 4)                            # Assign a dimension (3 x 4)
X                                            # Print X - it is now a matrix

dim(X) <- c(2, 3, 2)                         # Assign a new dimension (2 x 3 x 2)
X                                            # Print X - it is now a 3D array

dim(X)     # X is an array
median(X)  # Median of X

# ------------------------------------------------------------------------------
# Q&A

X <- c(A = 1, B = 2, C = 3)
X
X[2:5]
X[c("A", "C", "E")]

ID <- 1:5
AGE <- c(18, 35, 25, NA, 23)
ID
AGE
AGE >= 25
ID [ AGE >= 25 ]
