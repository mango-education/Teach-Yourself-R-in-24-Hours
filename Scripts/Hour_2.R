# ------------------------------------------------------------------------------
# Hour 2 
# The R Environment 
# ------------------------------------------------------------------------------

# The Console
4*5    # A simple command
4*     # An incomplete command

# ------------------------------------------------------------------------------
# LISTING 2.1 The Search Path 
search()
searchpaths()
# ------------------------------------------------------------------------------

# Listing Objects
objects(4)    # Assumes that graphics is 4th in the search path
objects("package:graphics")    # Assumes nothing about the search path

# The R Workspace
x <- 3*4
x

# ------------------------------------------------------------------------------
# TIP Removing Objects 
rm(x)
objects(1)      # character(0) represents an empty set of objects
rm(list=ls())   # Remove all objects
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# LISTING 2.2 The Working Directory  
# Print the current working directory
getwd()    
# Change the current working directory using an absolute path
setwd("C:/Users/username/Desktop")
getwd()
# Change the current working directory using a relative path
setwd("STY")
getwd()
# ------------------------------------------------------------------------------


