# [DESCRIPTION] R Script supporting Chapter 17 of the SAMS Book
# [AUTHOR] Richard Pugh


lmModel <- lm(mpg ~ wt * hp + factor(cyl), data = mtcars)   # Model fit with lm
lmModel

glmModel <- glm(mpg ~ wt * hp + factor(cyl), data = mtcars) # Model fit with glm
glmModel

summary(glmModel)

tiff("17fig01.tif")
par(mfrow = c(2, 2))
plot(glmModel)
dev.off()

par(mfrow = c(1, 1))
tiff("17fig02.tif")
coef(glmModel)    # Model Coefficients

res1 <- resid(glmModel)                        # Extract residuals
fit1 <- fitted(glmModel)                       # Extract fitted values
yRange <- c(-1, 1) * max(abs(res1))            # Calculate Y axis Range
xRange <- range(fit1)                          # Calculate X axis Range
xRange <- xRange + c(-1, 1) * diff(xRange)/5   # Extend X axis Range

plot(fit1, res1, type = "n",                   # Empty plot with axes specified
   ylim = yRange, xlim = xRange,
   xlab = "Fitted Values", ylab = "Residuals",
   main = "Residuals vs Fitted Values")
text(fit1, res1, row.names(mtcars), cex = 1.2) # Add text based on car names
abline(h = 0, lty = 2)                         # Add horizontal reference line at 0
dev.off()

### Logistic Regression

lrDf <- data.frame(Y = sample(c("Low", "High"), 10, T), X = rpois(10, 3))
lrObj <- glm(Y ~ X, data = lrDf, family = binomial)     # Logistic Model
levels(lrDf$Y)                                          # Ordering of levels

lrModel <- glm(am ~ wt - 1, data = mtcars, family = binomial)
summary(lrModel)

plot(mtcars$wt, mtcars$am)
lines(1:6, predict(lrModel, data.frame(wt = 1:6), type = "response"))


newDf <- data.frame(wt = 1:5)
round(predict(lrModel, newDf), 4) # Log Odds
round(predict(lrModel, newDf, type = "response"), 4)  # Probability

round(coef(lrModel), 3)        # Log-Odds
round(exp(coef(lrModel)), 3)   # Odds


examples<-data.frame(wt=0:6)
examples$logits<-predict(lrModel,examples)
examples$odds<-exp(examples$logits)
examples$probs<-examples$odds/(1+examples$odds)
# probability actually decreases as wt increases
knitr::kable(examples)




tiff("17fig03.tif")
head(InsectSprays)
plot(factor(InsectSprays$spray), InsectSprays$count,
     xlab = "Insecticide", ylab = "Insect Count",
     main = "Insect Count by Insecticide")
dev.off()

prModel <- glm(count ~ factor(spray) - 1, data = InsectSprays, family = poisson)
summary(prModel)

summary(glm(count ~ factor(spray), data = InsectSprays, family = poisson))$coef

round(exp(cbind(Est = coef(prModel), confint(prModel))), 2)



tiff("17fig04.tif")
linFun <- function(wt, a, b) a + b * wt
plot(mtcars$wt, mtcars$mpg, 
     main = "Miles per Gallon versus Weight",
     xlab = "Weight", ylab = "Miles per Gallon")
lines(1:6, linFun(1:6, a = 40, b = -6), col = "red")
lines(1:6, linFun(1:6, a = 35, b = -4.5), col = "blue")
legend("topright", paste("Model", 1:2), fill = c("red", "blue"))
dev.off()


nlsMpg <- nls(mpg ~ linFun(wt, a, b), data = mtcars)

nlsMpg <- nls(mpg ~ linFun(wt, a, b), data = mtcars,
              start = c(a = 40, b = -5))
nlsMpg


tiff("17fig05.tif")
head(Puromycin)      # A look at the data
plot(Puromycin$conc, Puromycin$rate, pch = 21, cex = 1.5, 
  xlab = "Instantaneous reaction rates (counts/min/min)",
  ylab = "Substrate Concentrations (ppm)", 
  main = "Instantaneous reaction rates vs Substrate Concentrations",
  bg = ifelse(Puromycin$state == "treated", "red", "blue"))
legend("bottomright", c("Treated", "Untreated"), fill = c("red", "blue"))
dev.off()



tiff("17fig06.tif")
plot(Puromycin$conc, Puromycin$rate, pch = 21, cex = 1.5, 
     xlab = "Instantaneous reaction rates (counts/min/min)",
     ylab = "Substrate Concentrations (ppm)", 
     main = "Instantaneous reaction rates vs Subscrate Concentrations",
     bg = ifelse(Puromycin$state == "treated", "red", "blue"))

micmen <- function(conc, Vm, K) Vm * conc / (K + conc)  # Define function
X <- seq(0, 1.1, length = 25)                           # Set of Concentrations

lines(X, micmen(xConcs, 200, 0.1), col = "pink")        # Treated: Vm = 200, K = 0.1
lines(X, micmen(xConcs, 210, 0.03), col = "pink")       # Treated: Vm = 210, K = 0.03
lines(X, micmen(xConcs, 210, 0.05), col = "red")        # Treated: Vm = 210, K = 0.05

lines(X, micmen(xConcs, 150, 0.05), col = "lightblue")  # Untreated: Vm = 150, K = 0.05
lines(X, micmen(xConcs, 170, 0.1), col = "lightblue")   # Untreated: Vm = 170, K = 0.1
lines(X, micmen(xConcs, 165, 0.05), col = "blue")       # Untreated: Vm = 165, V = 0.05

dev.off()

# NLS Models to both treated and untreated data
mmTreat <- nls(rate ~ micmen(conc, Vm, K), data = Puromycin, 
  start = c(Vm = 210, K = 0.05), subset = state == "treated")
mmUntreat <- nls(rate ~ micmen(conc, Vm, K), data = Puromycin, 
  start = c(Vm = 165, K = 0.05), subset = state == "untreated")
round(coef(mmTreat), 3)    # Coefficients for Treated data
round(coef(mmUntreat), 3)  # Coefficients for Untreated data



tiff("17fig07.tif")
plot(Puromycin$conc, Puromycin$rate, pch = 21, cex = 1.5, 
     xlab = "Instantaneous reaction rates (counts/min/min)",
     ylab = "Substrate Concentrations (ppm)", 
     main = "Instantaneous reaction rates vs Substrate Concentrations",
     bg = ifelse(Puromycin$state == "treated", "red", "blue"))

predDf <- data.frame(conc = seq(0, 1.1, length = 25))         # Set of Concentrations
lines(predDf$conc, predict(mmTreat, predDf), col = "red")     # Model for Treated data
lines(predDf$conc, predict(mmUntreat, predDf), col = "blue")  # Model for Untreated data 
legend("bottomright", c("Treated", "Untreated"), fill = c("red", "blue"))
dev.off()


tiff("17fig08.tif")
# Add new parameter to out function (vTrt)
micmen <- function(conc, state, Vm, K, vTrt) {
  newVm <- Vm + vTrt * (state == "treated")
  newVm * conc / (K + conc)  # Define function
}
mmPuro <- nls(rate ~ micmen(conc, state, Vm, K, vTrt), data = Puromycin,
    start = c(Vm = 160, K = 0.05, vTrt = 50))
summary(mmPuro)

plot(Puromycin$conc, Puromycin$rate, pch = 21, cex = 1.5, 
     xlab = "Instantaneous reaction rates (counts/min/min)",
     ylab = "Substrate Concentrations (ppm)", 
     main = "Instantaneous reaction rates vs Substrate Concentrations",
     bg = ifelse(Puromycin$state == "treated", "red", "blue"))
xConc = seq(0, 1.1, length = 25)         # Set of Concentrations
trtPred <- data.frame(conc = xConc, state = "treated")
untrtPred <- data.frame(conc = xConc, state = "untreated")

lines(predDf$conc, predict(mmPuro, trtPred), col = "red")     # Model for Treated data
lines(predDf$conc, predict(mmPuro, untrtPred), col = "blue")  # Model for Untreated data 
legend("bottomright", c("Treated", "Untreated"), fill = c("red", "blue"))
dev.off()


library(survival)
head(ovarian)


aggregate(ovarian$futime, list(State = ovarian$fustat), 
  function(x) c(Min = min(x), Median = median(x), Max = max(x)))

ovSurv <- Surv(ovarian$futime, event = ovarian$fustat)
plot(ovSurv)

tiff("17fig09.tif")
xVals <- 1:90
yVals <- (1 - log(xVals))/6
yVals <- yVals + 1 - yVals[1]
plot(xVals, yVals, type = "l", xlab = "Time (t)", 
     ylab = "Survival Function S(t)", ylim = 0:1,
     main = "Example Survival Function")

xPoint <- 40
yPoint <- approx(xVals, yVals, xPoint)$y
lines( rep(xPoint, 2), c(-2, yPoint), lty = 2, col = "blue" )
lines( c(-2, xPoint), rep(yPoint, 2), lty = 2, col = "blue" )
theLabel <- paste0("S(", xPoint, ") = ", round(yPoint, 2))
points(xPoint, yPoint, pch = 16, cex = .75, col = "blue")
text(xPoint + .5, yPoint + .015, theLabel, adj = 0, cex = .8, col = "blue")
dev.off()

kmOv  <- survfit(ovSurv ~ 1)
kmOv 

summary(kmOv)

tiff("17fig10.tif")
plot(kmOv, col = "blue", 
  main = "Kaplan-Meier Plot of Ovarian Data",
  xlab = "Time (t)", ylab = "Survival Function S(t)")
dev.off()

wbOv <- survreg(ovSurv ~ 1, dist = "weibull")
summary(wbOv)


plot(kmOv, col = "blue", 
     main = "Kaplan-Meier Plot of Ovarian Data",
     xlab = "Time (t)", ylab = "Survival Function S(t)")

sFun <- function(t, obj) {
  lambda <- 1 / obj$scale
  alpha <- exp( - coef(obj) * lambda)
  exp( -alpha * t ^ lambda)
}

pct <- seq(.0,.99,by=.01)                      # Quantiles at which to predict
dummyDf <- data.frame(1)                       # Dummy dataset
predOv <- predict(wbOv, newdata = dummyDf,     # Make Quantile predictions
  type = "quantile", p = pct)
names(predOv)
head(predOv$fit)

tiff("17fig11.tif")
plot(kmOv, col = "blue", 
     main = "Kaplan-Meier Plot of Ovarian Data",
     xlab = "Time (t)", ylab = "Survival Function S(t)")
lines(predOv, 1 - pct, col = "red")
legend("bottomleft", c("Kaplan-Meier", "Weibull"), fill = c("blue", "red"))
dev.off()

head(ovarian)

wbOv2 <- survreg(ovSurv ~ age, dist = "weibull", data = ovarian)
summary(wbOv2)


tiff("17fig12.tif")
ageDf <- data.frame(age = 10*4:6)             # Set of ages for which to created predictions
theCols <- c("red", "blue", "green")             # Colors to use
predOv <- predict(wbOv2, newdata = ageDf,     # Make Quantile predictions
  type = "quantile", p = pct)
matplot(t(predOv), 1-pct, xlim = c(0, 1200),  # Matrix plot of the predicted survival curves
  type = "l", lty = 1, col = theCols,
  main = "Parametric Estimation of Survival Curve by Age",
  xlab = "Time (t)", ylab = "Survival Function S(t)")
legend("bottomleft", paste("Age =", ageDf$age), fill = theCols) 
dev.off()

coxModel <- coxph(ovSurv ~ age + rx + ecog.ps + resid.ds, data = ovarian)
summary(coxModel)

coxModel1 <- coxph(ovSurv ~ age + factor(rx), data = ovarian)
summary(coxModel1)

cox.zph(coxModel1)

plot(coxModel1)

coxModel <- coxph(ovSurv ~ age, data = ovarian)
coxSurv <- survfit(coxModel)
summary(coxSurv)

tiff("17fig13.tif")
plot(coxSurv, col = "blue", xlab = "Time (t)",
     ylab = "Survival Function S(t)",
     main = "Proportional Hazards Model")
dev.off()

tiff("17fig14.tif")
coxSurv <- survfit(coxModel, newdata = ageDf)
plot(coxSurv, col = theCols, xlab = "Time (t)",
     ylab = "Survival Function S(t)",
     main = "Proportional Hazards Model")
legend("bottomleft", paste("Age =", ageDf$age), fill = theCols) 
matlines(t(predOv), 1-pct,  # Matrix plot of the predicted survival curves
  type = "l", lty = 2, col = theCols) 
dev.off()

# TIME SERIES ANALYSIS

plot(stl(USAccDeaths))

gross <- scan(file = "clipboard")
paste0(gross, collapse=", ")

ultron <- c(84.4, 56.5, 50.3, 13.2, 13.1, 9.4, 8.6, 21.2, 33.8, 22.7, 
  5.4, 6, 4.3, 4, 10, 17.2, 11.6, 3.4, 3, 2.3, 2.4, 5.4, 8.3, 8, 6.5, 
  1.9, 1.4, 1.4, 2.9, 4.9, 3.6)

tsUltron <- ts(ultron, frequency = 7)
tsUltron

tiff("17fig15.tif")
plot(tsUltron, main = "Daily Box Office Daily for Avengers: Age of Ultron",
     xlab = "Week during May 2015", ylab = "Daily Gross ($m)")
points(tsUltron, pch = 21, bg = "red")
dev.off()


tiff("17fig16.tif")
plot(log(tsUltron), main = "Daily Box Office Daily for Avengers: Age of Ultron",
     xlab = "Week during May 2015", ylab = "Log Daily Gross ($m)")
points(log(tsUltron), pch = 21, bg = "red")
dev.off()

tiff("17fig17.tif")
stlUltron <- stl(log(tsUltron), s.window = "periodic")
plot(stlUltron, main = "Decomposition of the Ultron Time Series")
window(stlUltron$time.series, end = c(1, 7))
dev.off()

tiff("17fig18.tif")
seUltron <- log(tsUltron) - stlUltron$time.series[,"seasonal"]
plot(seUltron, 
  main = "Logged Daily Box Office Gross\n(Weekly seasonality removed)",
  xlab = "Weeks in May 2015", ylab = "Logged Daily Box Office Gross ($m)")
dev.off()

tiff("17fig19.tif")
hwUltron <- HoltWinters(log(tsUltron))
plot(hwUltron)
dev.off()

predActuals <- cbind(predUltron, Actuals = log(c(1.08, 1.26, .97, .95, 1.84, 2.66, 1.84)))

tiff("17fig20.tif")
predUltron <- predict(hwUltron, n.ahead = 7,              # Predict next 7 days with H-W method
  prediction.interval = TRUE)  
plot(hwUltron, predUltron, col = "red",                   # Plot data and predictions
  col.predicted = "blue", col.intervals = "blue", 
  lty.intervals = 2)

actuals <- c(1.08, 1.26, .97, .95, 1.84, 2.66, 1.84)     # Actual values
tsActuals <- ts(actuals, frequency = 7, start = c(5, 4)) # Create time series
lines(log(tsActuals), col = "darkgreen")                      # Add line
points(log(tsActuals), pch = 4, col = "darkgreen")                      # Add line

legend("bottomleft", c("Original Data", "Holt-Winters Filter", "Actual Data"), 
  fill = c("red", "blue", "grey"))
dev.off()


tiff("17fig21.tif")
par(mfrow = c(1, 2))
acf(log(tsUltron), main = "Autocorrelation")
pacf(log(tsUltron), main = "Partial Autocorrelation")
dev.off()

tiff("17fig22.tif")
arimaUltron <- arima(log(tsUltron), 
  order = c(1, 0, 1))
arimaUltron
tsdiag(arimaUltron)
dev.off()

tiff("17fig23.tif")
sarimaUltron <- arima(log(tsUltron), order = c(1, 0, 1),
  seasonal = list(order = c(1, 0, 1)))
tsdiag(sarimaUltron)
dev.off()

tiff("17fig24.tif")
predUltron <- predict(sarimaUltron, n.ahead = 7,              # Predict next 7 days with H-W method
                      prediction.interval = TRUE)
plot(log(tsUltron), type = "n",
     main = "Predictions from ARIMA(1,0,1) Model",
     ylab = "Logged Daily Box Office Takings",
     xlab = "Day", xlim = c(1, 6.3), ylim = c(-1, 5))
lines(log(tsUltron), col = "red")
lines(predUltron$pred, col = "blue")
lines(predUltron$pred - 2 * predUltron$se, col = "blue", lty = 2)
lines(predUltron$pred + 2 * predUltron$se, col = "blue", lty = 2)
lines(log(tsActuals), col = "darkgreen")              # Add line
points(log(tsActuals), pch = 4, col = "darkgreen")    # Add line

legend("bottomleft", 
  c("Original Data", "ARIMA Predictions", "Actual Data"), 
  fill = c("red", "blue", "grey"))
dev.off()






micmen <- function(conc, Vm, K) Vm * conc / (K + conc)
nls(rate ~ micmen(conc, Vm, K), data = Puromycin, 
  start = c(Vm = 210, K = 0.05), subset = state == "treated")

nls(rate ~ SSmicmen(conc, Vm, K), data = Puromycin, 
   subset = state == "treated")

