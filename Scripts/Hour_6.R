
#------------------------------------------------------------------------------#
# Using R Functions
#------------------------------------------------------------------------------#

args(sample)

## The following are all valid ways of performing the same action
sample(x = c("red", "yellow", "green", "blue"), size = 2, replace = FALSE, prob = NULL)
sample(x = c("red", "yellow", "green", "blue"), size = 2)
sample(size = 2, x = c("red", "yellow", "green", "blue"))
sample(c("red", "yellow", "green", "blue"), 2)

## Programmers tend to mix postion and naming
sample(c("red", "yellow", "green", "blue"), size = 2, replace = TRUE)


#------------------------------------------------------------------------------#
# Functions for numeric data
#------------------------------------------------------------------------------#

## Basic mathematical operations
3^2
5 %% 3

## Mathematical functions
x <- seq(1, 4, by = 0.5)
x
sqrt(x)
log(x)
sin(x)

## Statistical summary functions
age <- age <- c(38, 20, 44, 41, 46, 49, 43, 23, 28, 32)
median(age)
mad(age)
range(age)

## Summaries with missing data
age[3] <- NA
median(age) # returns NA
median(age, na.rm = TRUE)

## Statistical Distributions

rnorm(5)
rpois(5, lambda = 3)
rexp(5)

## sampling 

sample(age, size = 5)
sample(age, size = 5, replace = TRUE)


#------------------------------------------------------------------------------#
# Logical data
#------------------------------------------------------------------------------#

## logical values as numbers
as.numeric(c(TRUE, FALSE))

## Working with logicals
age
age < 30
sum(age < 30, na.rm = TRUE)

table(age < 30)
table(age < 30, useNA = "ifany")


#------------------------------------------------------------------------------#
# Missing data
#------------------------------------------------------------------------------#

age

# We can't find missing values by testing equality
age == NA

# we need to use is.na
is.na(age)

## Total number of missings
sum(is.na(age))
table(is.na(age))

## Replacing missing values
meanAge <- mean(age, na.rm = TRUE)
missingObs <- is.na(age)
age <- replace(age, missingObs, meanAge)
age

## Returning only non-missing values
age[!is.na(age)]

#------------------------------------------------------------------------------#
# Character data
#------------------------------------------------------------------------------#

## Number of character 
fruits <- "apples, oranges, pears"
nchar(fruits)

## Extracting substrings
substring(fruits, 1, 6)
fruits <- substring(fruits, c(1, 9, 18), c(6, 15, 22))

## Creating strings - combining strings and numeric objects
paste(5, "apples")
nfruits <- c(5, 9, 2)
paste(nfruits, fruits)

# Changing the separator
paste(fruits, nfruits, sep = " = ")

## Searching in strings
colourStrings <- c("green", "blue", "orange", "red", "yellow", 
                   "lightblue", "navyblue", "indianred")

## Using regular expressions
grep("red", colourStrings, value = TRUE)

## red at the start of a string
grep("^red", colourStrings, value = TRUE)

## red at the end of a string
grep("red$", colourStrings, value = TRUE)

## at least one r
grep("r+", colourStrings, value = TRUE)

## 2 occurances of the letter e
grep("e{2}", colourStrings, value = TRUE)

## Search and replace - replace red with brown
gsub("red", "brown", colourStrings)


