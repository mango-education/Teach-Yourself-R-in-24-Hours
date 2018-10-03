# [DESCRIPTION] R Script supporting Chapter 15 of the SAMS Book
# [AUTHOR] Richard Pugh


# Load the lattice package
require(lattice)

tiff("15fig01.tif")
xyplot(mpg ~ wt, data = mtcars)
dev.off()

tiff("15fig02.tif")
histogram(~ mpg, data = mtcars)
dev.off()

tiff("15fig03.tif")
densityplot(~ wt, data = mtcars)
dev.off()

tiff("15fig04.tif")
dotplot( carb ~ mpg, data = mtcars )
dev.off()

tiff("15fig05.tif")
bwplot( mpg ~ carb, data = mtcars, horizontal = FALSE )
dev.off()

tiff("15fig06.tif")
cloud( mpg ~ wt * hp, data = mtcars)
dev.off()

tiff("15fig07.tif")
dim(volcano)  # Dimensions of the volcano matrix
wireframe( volcano, shade = TRUE )
dev.off()

tiff("15fig08.tif")
wireframe( volcano, shade = TRUE, 
           screen = list(x = -60, y = -40, z = -20))
dev.off()

tiff("15fig09.tif")
splom( ~ mtcars[,c("mpg", "wt", "cyl", "hp")])
dev.off()

#parallelplot( ~ mtcars[,c("mpg", "wt", "cyl", "hp")])

tiff("15fig10.tif")
xyplot( mpg ~ wt, data = mtcars, subset = am == 1 )
dev.off()

tiff("15fig11.tif")
xyplot(mpg ~ wt, data = mtcars, main = "Miles per Gallon vs Weight",
       xlab = "Weight (lb/1000)", ylab = "Miles/(US) Gallon",
       xlim = c(1, 6), ylim = c(10, 40))
dev.off()

library(devtools)
install_github("metacran/cranlogs")

library(cranlogs)
cranData <- cran_downloads(packages = c("lattice", "ggplot2"), when = "last-month")
head(cranData)

tiff("15fig12.tif")
xyplot(count ~ date, data = cranData, subset = package == "lattice",
       main = "Lattice package downloads over the last month",
       ylab = "Number of Downloads", xlab = "Date",
       type = "b", col = "red", lwd = 2, cex = 2, pch = 16)
dev.off()

tiff("15fig13.tif")
xyplot(mpg ~ disp + hp, data = mtcars, auto.key = TRUE, pch = 16, cex = 2)
dev.off()

tiff("15fig14.tif")
xyplot(mpg ~ disp + hp, data = mtcars, pch = 16, cex = 2, outer = T)
dev.off()

tiff("15fig15.tif")
xyplot(mpg ~ wt, data = mtcars, groups = cyl,
  pch = 16, cex = 2, auto.key = TRUE)
dev.off()

tiff("15fig16.tif")
xyplot(mpg ~ disp  + hp, data = mtcars, groups = cyl,
       pch = 16, cex = 2, auto.key = TRUE)
dev.off()

tiff("15fig17.tif")
xyplot(count ~ date | package, data = cranData, type = "b")
dev.off()

tiff("15fig18.tif")
xyplot( mpg ~ wt | cyl, data = mtcars,
        main = "Miles per Gallon vs Weight by Number of Cylinders", layout = c(3, 1))
dev.off()

tiff("15fig19.tif")
xyplot( mpg ~ wt | factor(cyl), data = mtcars,
        main = "Miles per Gallon vs Weight by Number of Cylinders", layout = c(3, 1))
dev.off()

tiff("15fig19.tif")
xyplot( mpg ~ wt | factor(cyl), data = mtcars,
        main = "Miles per Gallon vs Weight by Number of Cylinders", layout = c(3, 1))
dev.off()

tiff("15fig20.tif")
xyplot( mpg ~ wt | factor(cyl) * ifelse(am == 0, "Automatic", "Manual"), 
        data = mtcars, cex = 1.5, pch = 21, fill = "lightblue", 
        main = "Miles per Gallon vs Weight \nby Number of Cylinders and Transmission Type")
dev.off()

tiff("15fig21.tif")
myPanel <- function(x, y, ...) {
  cat("Panel Function Called!\n")
}
xyplot( mpg ~ wt | factor(cyl), data = mtcars, panel = myPanel)
dev.off()

tiff("15fig22.tif")
myPanel <- function(x, y, ...) {
  panel.xyplot(x, y, ...)
}
xyplot( mpg ~ wt | factor(cyl), data = mtcars, panel = myPanel)
dev.off()

apropos("^panel")

tiff("15fig23.tif")
myPanel <- function(x, y, ...) {
  medX <- median(x, na.rm = TRUE)                        # Median of X values
  medY <- median(y, na.rm = TRUE)                        # Median of Y values
  panel.abline(v = medX, h = medY, lwd = 2, col = "red") # Add reference lines
  panel.xyplot(x, y, ...)                                # Draw the points
}
xyplot( mpg ~ wt | factor(cyl), data = mtcars, panel = myPanel, pch = 16)
dev.off()

tiff("15fig24.tif")
myPanel <- function(x, y, ...) {
  myLm <- lm(y ~ x)                                # Fit a linear regression line
  panel.abline(myLm, col = "red")                  # Add the regression line
  panel.xyplot(x, y, ...)                          # Draw the points
  params <- paste(c("Intercept:", "Slope:"),       # Parameters
    signif(coef(myLm), 3), collapse="\n")
  ltext(max(x), max(y), params, adj = 1, cex = .8) # Add text to plot
}
xyplot( mpg ~ wt | factor(cyl), data = mtcars, panel = myPanel, pch = 16, layout = c(3, 1))
dev.off()

tiff("15fig25.tif")
myPanel <- function(x, y, xPos, yPos, ...) {
  myLm <- lm(y ~ x)                                # Fit a linear regression line
  panel.abline(myLm, col = "red")                  # Add the regression line
  panel.xyplot(x, y, ...)                          # Draw the points
  params <- paste(c("Intercept:", "Slope:"),       # Parameters
                  signif(coef(myLm), 3), collapse="\n")
  ltext(xPos, yPos, params, adj = 1, cex = .8) # Add text to plot
}
xyplot( mpg ~ wt | factor(cyl), data = mtcars, panel = myPanel, pch = 16,
  xPos = max(mtcars$wt), yPos = max(mtcars$mpg), layout = c(3, 1))
dev.off()

tiff("15fig26.tif")
xyplot( mpg ~ wt | factor(cyl), data = mtcars, 
  pch = c(15, 16), col = c("navy", "orange"), 
  groups = ifelse(am == 0, "Auto", "Manual"), auto.key = TRUE)
dev.off()

tiff("15fig27.tif")
show.settings()
dev.off()

myTheme <- trellis.par.get()  # Get the list of styles
names(myTheme)                # Look at the element names 
myTheme$superpose.symbol      # Look at the superpose.symbol element

ss <- myTheme$superpose.symbol  # Extract the superpose.symbol element
names(ss)                       # Names of the superpose.symbol element
ss$col                          # Current colors
ss$col <- c("orange", "navy", "green", "red", "grey") # Update plot colors
ss$pch <- c(16, 15, 17, 18, 19) # Updated plot symbols
myTheme$superpose.symbol <- ss  # Update the syles

myTheme$strip.background$col    # Current strip header color
myTheme$strip.background$col <- c("lightgrey", "lightblue", "lightgreen")

grep("^light", colors(), value = T)

tiff("15fig28.tif")
show.settings(myTheme)
dev.off()

tiff("15fig29.tif")
xyplot( mpg ~ wt | factor(cyl), data = mtcars, par.settings = myTheme,
        groups = ifelse(am == 0, "Auto", "Manual"), auto.key = TRUE, layout = c(3, 1))
dev.off()

trellis.par.set(theme = myTheme)
xyplot( mpg ~ wt | factor(cyl), data = mtcars, 
        groups = ifelse(am == 0, "Auto", "Manual"), auto.key = TRUE, layout = c(3, 1))

###############################
histogram( ~ Wind, data = airquality )
xyplot(Ozone ~ Wind, data = airquality, groups = Month, auto.key = list(space = "right") )
xyplot(Ozone ~ Wind | Month, data = airquality)
