
#------------------------------------------------------------------------------#
# Profiling Code
#------------------------------------------------------------------------------#

## Profiling Code
tmp <- tempfile()
Rprof(filename = tmp, line.profiling = TRUE)
replicate(100, f1(100))
Rprof(NULL)
summaryRprof(filename = tmp, lines = "show")

#------------------------------------------------------------------------------#
# Benchmarking
#------------------------------------------------------------------------------#


## Benchmarking
f1 <- function(l){
  
  x <- NULL
  
  for(i in seq_len(l)){
    
    s <- runif(1)
    
    x[i] <- ifelse(s > 0.5, 1, 0)
    
  }
  
  x
  
}

library(microbenchmark)
microbenchmark(f1(100))


#------------------------------------------------------------------------------#
# Initialization
#------------------------------------------------------------------------------#

f2 <- function(l){
  
  x <- numeric(l)
  
  for(i in seq_len(l)){
    
    s <- runif(1)
    
    x[i] <- ifelse(s > 0.5, 1, 0)
    
  }
  
  x
  
}


microbenchmark(f1(100), f2(100))


#------------------------------------------------------------------------------#
# Vectorization
#------------------------------------------------------------------------------#


4 * (1:10)

fruits <- c("apples", "oranges", "pears")
nfruits <- c(5, 9, 2)
paste(fruits, nfruits, sep = " = ")

pmin(0, -1:1)
pmax(-1:1, 1:-1) 


f3 <- function(l){
  
  s <- runif(l)
  
  x <- ifelse(s > 0.5, 1, 0)
  
  x
  
}


f4 <- function(l){
  
  x <- numeric(l)
    
  s <- runif(l)
    
  x[s > 0.5] <- 1

  x
  
}


microbenchmark(f1(100), f2(100), f3(100))

microbenchmark(f3(100), f4(100))


#------------------------------------------------------------------------------#
# Using Alternative Functions
#------------------------------------------------------------------------------#


f5 <- function(l){
  
  sample(0:1, size = l, replace = TRUE)
  
}



microbenchmark( f1(100), f2(100), f3(100), f4(100), f5(100))



