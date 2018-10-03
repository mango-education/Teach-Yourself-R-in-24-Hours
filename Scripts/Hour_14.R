# ------------------------------------------------------------------------------
# Hour 14
# The ggplot2 Package for Graphics
# ------------------------------------------------------------------------------
# NOTE: Since writing the book, ggplot2_2.0.0 has been updated and some features 
# described here have been depricated.

# ------------------------------------------------------------------------------
# Quick Plots and Basic Control

# Load package and create a simple plot
library(ggplot2)
theme_set(theme_bw(base_size= 14))   # Set the theme to a white background (more later)
qplot(x = wt, y = mpg, data = mtcars)

qplot(1:10, rnorm(10))

# Working with Layers

# ------------------------------------------------------------------------------
# LISTING 14.1 Optional Layering
# Version 1: Using a single call to qplot
qplot(x = wt, y = mpg, data = mtcars,
      main = "Miles per Gallon vs Weight\nAutomobiles (1973–74 models)",
      xlab = "Weight (lb/1000)",
      ylab = "Miles per US Gallon",
      xlim = c(1, 6),
      ylim = c(0, 40))

# Version 2: qplot with additional layers
qplot(x = wt, y = mpg, data = mtcars) +
      ggtitle("Miles per Gallon vs Weight\nAutomobiles (1973–74 models)") +
      xlab("Weight (lb/1000)") +
      ylab("Miles per US Gallon") +
      xlim(c(1, 6)) +
      ylim(c(0, 40))
# ------------------------------------------------------------------------------

# Plots as Objects
# Create a basic plot
basicCarPlot <- qplot(wt, mpg, data = mtcars)
# Modify the plot to include a title
basicCarPlot <- basicCarPlot + 
  ggtitle("Miles per Gallon vs Weight\nAutomobiles (1973–74 models)")
# Now print the plot
basicCarPlot    

# ------------------------------------------------------------------------------
# TIP
# Exporting ggplot2 Graphics
#carPlot <- qplot(x = wt, y = mpg, data = mtcars)    # Create ggplot object
#ggsave(file = "carPlot.png", carPlot)               # Save object as a png
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Changing Plot Types

# Ensure cyl variable is of the right type by fixing in the data
mtcars$cyl <- factor(mtcars$cyl)
qplot(cyl, mpg, data = mtcars, geom = "boxplot")

# Plot Types
grep("^geom", objects("package:ggplot2"), value = TRUE)

qplot(cyl, mpg, data = mtcars) + geom_boxplot()

# Combining Plot Types

qplot(wt, mpg, data = mtcars) + geom_smooth(method = "lm")

qplot(wt, mpg, data = mtcars, geom= c("point", "smooth"), method = "lm")

# ------------------------------------------------------------------------------
# Aesthetics

qplot(x = long, y = lat, data = quakes, size = mag, col = -depth) +
  ggtitle("Locations of Earthquakes off Fiji") +
  xlab("Longitude") + ylab("Latitude")

# ------------------------------------------------------------------------------
# CAUTION
# Make Everything Blue!
#qplot(wt, mpg, data = mtcars, colour = I("blue"))
# ------------------------------------------------------------------------------

# Control of Aesthetics

# Create a basic plot
carPlot <- qplot(x = wt, y = mpg, data = mtcars, shape = cyl, 
      main = "Miles per Gallon vs Weight\nAutomobiles (1973–74 models)",
      xlab = "Weight (lb/1000)",
      ylab = "Miles per US Gallon",
      xlim = c(1, 6),
      ylim = c(0, 40))

# Edit plotting symbols and print
carPlot + scale_shape_manual(values = c(3,5,2))


# Scales and the Legend

# Create a basic plot
carPlot <- qplot(x = wt, y = mpg, data = mtcars, 
                 shape = cyl, size = disp,
                 main = "Miles per Gallon vs Weight\nAutomobiles (1973–74 models)",
                 xlab = "Weight (lb/1000)",
                 ylab = "Miles per US Gallon",
                 xlim = c(1, 6),
                 ylim = c(0, 40))

# Adjust legend titles via scale layers
carPlot + 
  scale_shape_discrete("Number of cylinders") +
  scale_size_continuous("Displacement (cu.in.)") 

carPlot + scale_size_continuous("Displacement (cu.in.)", range = c(4,8))

carPlot + 
  scale_shape_discrete("Number of cylinders") +
  scale_size_continuous("Displacement (cu.in.)",
                        range = c(4,8), 
                        breaks = seq(100, 500, by = 100),
                        limits = c(0, 500)) 

grep("^scale", objects("package:ggplot2"), value = TRUE)

# Working with Grouped Data
library(mangoTraining)
head(pkData)

qplot(data = pkData, x = Time, y = Conc, geom = "path")    # Not the desired result!
qplot(data = pkData, x = Time, y = Conc, geom = "line")    # Not the desired result!


qplot(data = pkData, x = Time, y = Conc, geom = "path", group = Subject, 
      ylab = "Concentration")

# ------------------------------------------------------------------------------
# Paneling (a.k.a Faceting)

carPlot + facet_grid(. ~ gear)

carPlot + facet_grid(gear ~ .)

#carPlot + facet_grid(cyl ~ gear)

carPlot + facet_grid(. ~ gear + cyl)



# Using facet_wrap
#carPlot + facet_grid(. ~ carb)   # Comparison with facet_grid
carPlot + facet_wrap( ~ carb)

# ------------------------------------------------------------------------------
# Custom Plots

# Working with ggplot

ggplot() + geom_point(data = mtcars, aes(x = wt, y = mpg))

ggplot() + geom_point(data = mtcars, aes(x = wt, y = mpg, shape = cyl))

ggplot() + geom_point(data = mtcars, aes(x = wt, y = mpg), shape = 17, size = 3)

# Where to Specify Aesthetics

ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point(shape = 17, size = 3) +
  geom_smooth(method = "lm", se = FALSE, col = "red")

ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point(aes(shape = cyl), size = 3) +
  geom_smooth(method = "lm", se = FALSE, col = "red")

qplot(data = mtcars, x = wt, y = mpg, shape = cyl, size = I(3)) +
  geom_smooth(method = "lm", se = FALSE, col = "red", aes(shape = NULL))

# Alternatively
#qplot(data = mtcars, x = wt, y = mpg, geom = "smooth",
#      method = "lm", se = FALSE, col = I("red"))+
#  geom_point(aes(shape = cyl), size = 3)

# Working with Multiple Data Frames

# Create a copy of the mtcars data to be used as a "shadow"
require(dplyr)    # To use select function
carCopy <- mtcars %>% select(-cyl)

# Use layers to control the color of points
ggplot() + 
  geom_point(data = carCopy, aes(x = wt, y = mpg), color = "lightgrey") +
  geom_point(data = mtcars, aes(x = wt, y = mpg)) +
  facet_grid( ~ cyl) +  # Note that cyl only exists in mtcars not carCopy
  ggtitle("MPG vs Weight Automobiles (1973–74 models)\nBy Number of Cylinders") +
  xlab("Weight (lb/1000)") +
  ylab("Miles per US Gallon")


# Coordinate Systems
library(maps)
library(mapproj)

nz <- map_data("nz")          # Extract map coordinates for New Zealand
nzmap <- ggplot(nz, aes(x=long, y=lat, group=group)) +
  geom_polygon(fill="white", colour="black")

# Now let's add a projection
nzmap + coord_map("cylindrical")

# ------------------------------------------------------------------------------
# Themes and Layout

# Tweaking Individual Plots

carPlot + 
  facet_grid(~ cyl) +
  theme(
    strip.background = element_rect(colour = "grey50", fill = NA),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank() 
    
  )

# Global Themes
theme_set(theme_gray())
# carPlot    # example
theme_set(theme_bw(base_size = 14)) 

#theme_update(strip.background = element_rect(colour = "grey50", fill = NA),
#             panel.grid.minor = element_blank(),
#             panel.grid.major = element_blank() 
#)
# carPlot    # example

# See also ggthemes

states <- map_data("state") 

mapOfUSA <- qplot(long, lat, data = states, geom = "polygon", 
                  group = group,
                  fill = region, col = I("black")) 

# Split the legend into 3 columns, move to the bottom of the plot
mapOfUSA <- mapOfUSA + theme(legend.position = "bottom") 

mapOfUSA + guides(fill = guide_legend(title = "State",
                                      nrow =10, title.position = "top"))

# ------------------------------------------------------------------------------
# TIP
# Removing the Legend
# mapOfUSA + scale_fill_discrete(guide = FALSE) 
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# The ggvis Evolution

# ------------------------------------------------------------------------------
# LISTING 14.2 A Simple Example Using ggvis
# Load the package
library(ggvis)

# Vary the colour by the factor variable: cyl
ggvis(mtcars, x = ~wt, y = ~mpg, fill = ~cyl) %>%
  layer_points()
# ------------------------------------------------------------------------------

# (Slightly) more advanced example
#ggvis(mtcars, ~wt, ~mpg) %>% 
#  layer_points() %>% 
#  add_tooltip(function(df) df$wt)




