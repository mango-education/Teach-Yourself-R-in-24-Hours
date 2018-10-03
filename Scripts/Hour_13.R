
#------------------------------------------------------------------------------#
# Graphics devices & Colors
#------------------------------------------------------------------------------#

## Creating a pdf device
pdf("myFirstGraphic.pdf")
hist(rnorm(100))
dev.off()  # remember to close the device!

## Sample some of the colors
sample(colors(), 10)

## give a specific color value
rgb(0, 255, 0, maxColorValue = 255)


#------------------------------------------------------------------------------#
# High level graphics functions
#------------------------------------------------------------------------------#

## univariate data 
x <- rnorm(100)

## histogram
hist(x, col = "lightblue")

## QQ plot with overlaid line
qqnorm(x)
qqline(x)

## Simple boxplot and split by groups
boxplot(x)
gender <- sample(c("F", "M"), size = 100, replace = TRUE)
boxplot(x ~ gender)

## boxplot with data in a data frame
genderData <- data.frame(gender = gender, value = x)
boxplot(value~gender, data = genderData)

## simple barplot
barplot(c(3, 9, 5))

## barplot from a table
genderCount <- table(sex)
barplot(genderCount)

## plot function for univariate data
plot(x[1:10])

## plot function for two variables
plot(airquality$Wind, airquality$Ozone, pch = 4)
 

#------------------------------------------------------------------------------#
# Aesthetics
#------------------------------------------------------------------------------#

library(mangoTraining)

## Titles and axis labels
hist(x, main = "Histogram of Random Normal Data", xlab = "Simulated Normal Data")
plot(pkData$Time, pkData$Conc, 
           main = "Concentration against Time", xlab = "Time",
           ylab = "Concentration")

## special characters in text
plot(pkData$Time, pkData$Conc, 
     ylab = expression("Concetration ("*mu*"g/ml)"))

## axis limits
plot(pkData$Time, pkData$Conc, xlim = c(0, 50), ylim = c(0, 3000))
plot(pkData$Time[pkData$Dose == 25], pkData$Conc[pkData$Dose == 25], 
     ylim = range(pkData$Conc))


## plot symbols
plot(pkData$Time, pkData$Conc, 
       main = "Concentration against Time", xlab = "Time",
       ylab = "Concentration", pch = 24, col = "navyblue", 
       bg = "yellow", cex = 2) 



## plot types
x <- rnorm(10)
par(mfrow = c(2, 5))
plot(x, type = "p", main = 'type = "p"')
plot(x, type = "l", main = 'type = "l"')
plot(x, type = "b", main = 'type = "b"')
plot(x, type = "c", main = 'type = "c"')
plot(x, type = "o", main = 'type = "o"')
plot(x, type = "h", main = 'type = "h"')
plot(x, type = "s", main = 'type = "s"')
plot(x, type = "S", main = 'type = "S"')
plot(x, type = "n", main = 'type = "n"')


#------------------------------------------------------------------------------#
# Low level graphics functions
#------------------------------------------------------------------------------#

## Create the subsets and the basic plot
subject1 <- pkData[pkData$Subject == 1, ]
subject2 <- pkData[pkData$Subject == 2, ]
plot(pkData$Time, pkData$Conc, type = "n")

## add the low level features - points and lines
points(subject1$Time, subject1$Conc, pch = 16)
lines(subject2$Time, subject2$Conc)

## horizontal and vertical reference lines
abline(h = median(pkData$Conc), lty = 2)
abline(v = pkData$Time[pkData$Conc == max(pkData$Conc)], lty = 3)


## adding text
plot(pkData$Time, pkData$Conc, type = "n")
text(pkData$Time, pkData$Conc, pkData$Dose)

## Adding text as labels to specific points
library(dplyr)
maxData <- filter(group_by(pkData, Time), Conc == max(Conc), Time != 0)
plot(pkData$Time, pkData$Conc, pch = 16)
text(maxData$Time, 
     maxData$Conc,
     maxData$Subject,
     pos = 2, offset = 0.5)


## Adding a legend
subj1 <- pkData[pkData$Subject == 1, ]
subj2 <- pkData[pkData$Subject == 2, ]
plot(subj1$Time, subj1$Conc, pch = 16, col = "blue")
points(subj2$Time, subj2$Conc, pch = 0, col = "red")
legend("topright", legend = c("Subject 1", "Subject 2"), pch = c(16, 0), col = c("blue", "red"))       
         

#------------------------------------------------------------------------------#
# Graphics parameters
#------------------------------------------------------------------------------#

## 2 x 2 grid layout
par(mfrow = c(2, 2))
x <- rnorm(100)
hist(x)
boxplot(x)
qqnorm(x)
plot(x)


## define a layout as a matrix
mat <- rbind(1, 2:4)
mat

## finer control of the layout with the layout function
layout(mat)
x <- rnorm(100)
hist(x)
boxplot(x)
qqnorm(x)
plot(x)

