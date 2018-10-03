# [DESCRIPTION] R Script supporting Chapter 16 of the SAMS Book
# [AUTHOR] Richard Pugh

tiff("16fig01.tif")
plot(mtcars$wt, mtcars$mpg, main = "Miles per Gallon vs Weight",
     xlab = "Weight (lb/1000)", ylab = "Miles per Gallon", pch = 16)
lines(loess.smooth(mtcars$wt, mtcars$mpg), col = "red")
dev.off()

model1 <- lm(mpg ~ wt, data = mtcars)  # Fit the model
model1

summary(model1)  # Summary of the lm model

summary(model1, correlation = TRUE)  # Summary of the lm model

tiff("16fig02.tif")
par(mfrow = c(2, 2))   # Set up a 2x2 Graph Page
plot(model1)           # Create diagnostic plots for model1
dev.off()

class(model1)   # The class of model1
is.list(model1) # Is model1 a list?
names(model1)   # The element names of model1

model1$coefficients               # Model Coefficients
quantile(model1$residuals,        # Specific quantiles of residuals
         probs = c(0.05, 0.5, 0.95))

coef(model1)           # Model coefficients
head(resid(model1))    # Fitted Values
head(fitted(model1))   # Residuals (observed - fitted)


tiff("16fig03.tif")
whichVars <- setdiff(names(mtcars), c("wt", "mpg")) # Other variables in mtcars
par(mfrow = c(3, 3))                                # Set plot layout
for (V in whichVars) {                              # Loop through create scatter plots
  plot(mtcars[[V]], resid(model1), main = V, xlab ="", pch = 16)
  lines(loess.smooth(mtcars[[V]], resid(model1)), col = "red")
}
dev.off()

sModel1 <- summary(model1)   # Summary of model1
class(sModel1)               # Class of summary object
is.list(sModel1)             # Is it a list?
names(sModel1)               # Element names
sModel1$adj.r.squared        # Adjusted R Squared
sModel1$sigma^2              # Estimate variance

tiff("16fig04.tif")
plot(mtcars$wt, mtcars$mpg, main = "Miles per Gallon vs Weight",
     xlab = "Weight (lb/1000)", ylab = "Miles per Gallon", pch = 16)
lines(loess.smooth(mtcars$wt, mtcars$mpg), col = "grey")
abline(model1, col = "red")
dev.off()

head(predict(model1))  # Model Predictions using model1
head(fitted(model1))   # Fitted Values of model1

wtDf <- data.frame(wt = 1:6)                         # Independant Variables
predVals <- predict(model1, newdata = wtDf)          # Make predictions using model1
data.frame(wt = wtDf$wt, Pred = round(predVals, 1))  # Form as data frame

model2 <- lm(mpg ~ wt + hp, data = mtcars)  # Fit new model
summary(model2)                             # Summary of model

model2 <- update(model1, mpg ~ wt + hp)      # Create model2 based on model1
model2

tiff("16fig05.tif")
resFitPlots <- function(..., smooth = TRUE, hRef = TRUE, 
  symm = TRUE, cols = c("red", "blue", "grey", sample(colors()))) 
{
  N <- length(inMods <- list(...))       # Capture list of model inputs
  resList <- lapply(inMods, resid)       # Extract residuals
  fitList <- lapply(inMods, fitted)      # Extract fitted values
  resRange <- do.call("range", resList)  # Calculate range of residuals
  fitRange <- do.call("range", fitList)  # Calculate range of fitted values
  modLabs <- sapply(match.call(expand.dots = F)$..., as.character)  # Model Labels
  if (symm) resRange <- c(-1, 1) * max(abs(resRange))               # Symmetric Y Axis
  
  # Create plot title
  modTitles <- paste0(modLabs, collapse=", ")
  theTitle <- paste0("Residuals vs Fitted Values for ", N, " models\n(", modTitles, ")")

  # Create empty plot with correct limits and labels
  plot(fitList[[1]], resList[[1]], xlim = fitRange, ylim = resRange, 
    xlab = "Fitted Values", ylab = "Residuals", type = "n", main = theTitle)
  if (hRef) abline(h = 0, lty = 2)       # Add reference line at zero
  
  # Iteratively add points to the plot
  for (i in 1:N) {
    points(fitList[[i]], resList[[i]], col = cols[i], pch = 16)      
    if (smooth) lines(loess.smooth(fitList[[i]], resList[[i]]), col = cols[i])
  }
  legend("bottomright", modLabs, fill = cols[1:N])  # Add a legend

  invisible(inMods)                      # Invisibly return list of models
}
resFitPlots(model1, model2)
dev.off()


tiff("16fig05.tif")

# Extract elements
res1 <- resid(model1); fit1 <- fitted(model1)
res2 <- resid(model2); fit2 <- fitted(model2)

# Calculate axis range
resRange <- c(-1, 1) * max(abs(res1), abs(res2))
fitRange <- range(fit1, fit2)

# Create plot for model1 > add points for model2
plot(fit1, res1, xlim = fitRange, ylim = resRange,
  col = "red", pch = 16, main = "Residuals vs Fitted Values",
  xlab = "Fitted Values", ylab = "Residuals")
points(fit2, res2, col = "blue", pch = 16)

# Add reference and smooth lines
abline(h = 0, lty = 2)
lines(loess.smooth(fit1, res1), col = "red")
lines(loess.smooth(fit2, res2), col = "blue")
legend("bottomleft", c("mpg ~ wt", "mpg ~ wt + hp"), fill = c("red", "blue"))
dev.off()

tiff("16fig06.tif")
# Create plot for model1 > add points for model2
plot(mtcars$hp, res1, ylim = resRange,
     col = "red", pch = 16, main = "Residuals vs Fitted Values",
     xlab = "Fitted Values", ylab = "Residuals")
points(mtcars$hp, res2, col = "blue", pch = 16)

# Add reference and smooth lines
abline(h = 0, lty = 2)
lines(loess.smooth(mtcars$hp, res1, span = .8), col = "red")
lines(loess.smooth(mtcars$hp, res2, span = .8), col = "blue")
legend("bottomleft", c("mpg ~ wt", "mpg ~ wt + hp"), fill = c("red", "blue"))
dev.off()

anova(model1, model2)

model3 <- update(model2,. ~ . + wt:hp)
summary(model3)

tiff("16fig07.tif")

# Extract elements for model 3
res3 <- resid(model3)
fit3 <- fitted(model3)

# Calculate axis range
resRange <- c(-1, 1) * max(resRange, abs(res3))
fitRange <- range(fitRange, fit3)

# Create plot for model1 > add points for model2
plot(fit1, res1, xlim = fitRange, ylim = resRange,
     col = "red", pch = 16, main = "Residuals vs Fitted Values",
     xlab = "Fitted Values", ylab = "Residuals")
points(fit2, res2, col = "blue", pch = 16)
points(fit3, res3, col = "black", pch = 16)

# Add reference and smooth lines
abline(h = 0, lty = 2)
lines(loess.smooth(fit1, res1), col = "red")
lines(loess.smooth(fit2, res2), col = "blue")
lines(loess.smooth(fit3, res3), col = "black")

# Add 5% and 95% refernence lines for each model
refFun <- function(res, col) abline(h = quantile(res, c(.05, .95)), col = col, lty = 3)
refFun(res1, "red"); refFun(res2, "blue"); refFun(res3, "black")
legend("bottomleft", c("mpg ~ wt", "mpg ~ wt + hp", "mpg ~ wt + hp + wt:hp"), 
  fill = c("red", "blue", "black"))
dev.off()


tiff("16fig08.tif")

par(mfrow = c(1, 3))
plot(factor(mtcars$vs), resid(model3),  col = "red",
  xlab = "0 = Straight Engine \ 1 = 'V Engine'", ylab = "Residuals", 
  main = "Residuals versus\n'V Engine' Flag")
plot(factor(mtcars$am), resid(model3), col = "red",
  xlab = "0 = Automatic \ 1 = Manual", ylab = "Residuals", 
  main = "Residuals versus\nTransmission Type")
plot(factor(mtcars$cyl), resid(model3), col = "red",
  xlab = "Number of Cylinders", ylab = "Residuals", 
  main = "Residuals versus\nNumber of Cylinders")

dev.off()

model4 <- update(model3, . ~ . + factor(cyl))
summary(model4)

tiff("16fig09.tif")

plot(factor(mtcars$cyl), mtcars$hp, col = "red",
     xlab = "Number of Cylinders", ylab = "Gross Horsepower",
     main = "Gross Horsepower vs Number of Cylinders")
dev.off()

graphics.off()


summary(mtcars$mpg)           # Summary of a numeric vector
summary(factor(mtcars$cyl))   # Summary of a factor vector
summary(mtcars[,1:4])         # Summary of a factor vector
summary(model3)               # Summary of a linear model

cylFactor <- factor(mtcars$cyl)
class(cylFactor)
summary(cylFactor)
summary.factor(cylFactor)


class(model1)
class(model2)
class(model3)
class(model4)

tiff("16fig10.tif")

par(mfrow = c(1, 2))
plot(mtcars$wt, mtcars$mpg, pch = 16, xlab = "Weight (lb/1000)",
     ylab = "Miles per Gallon", main = "MPG Gallon versus Weight")
lines(loess.smooth(mtcars$wt, mtcars$mpg), col = "red")
plot(mtcars$wt, log(mtcars$mpg), pch = 16, xlab = "Weight (lb/1000)",
     ylab = "log(Miles per Gallon)", main = "Logged MPG versus Weight")
lines(loess.smooth(mtcars$wt, log(mtcars$mpg)), col = "red")
dev.off()

tiff("16fig11.tif")
lmodel1 <- lm(log(mpg) ~ wt, data = mtcars)
summary(lmodel1)
par(mfrow = c(2, 2))
plot(lmodel1)
dev.off()


tiff("16fig12.tif")

plot(mtcars$wt, mtcars$mpg, pch = 16, xlab = "Weight (lb/1000)",
     ylab = "Miles per Gallon", main = "MPG Gallon versus Weight")
abline(model1, col = "red")   # Add (straight) model line
wtVals <- seq(min(mtcars$wt), max(mtcars$wt), length = 50)
predVals <- predict(lmodel1, newdata = data.frame(wt = wtVals))
lines( wtVals, exp(predVals), col = "blue")
legend("topright", c("mpg ~ wt", "log(mpg) ~ wt"), fill = c("red", "blue"))
dev.off()

contr.treatment(3) # Treatment contrasts: Baseline is first level
contr.SAS(3)       # SAS contrasts: Baseline is last level
contr.sum(3)       # Sum contrasts: Sum to zero
