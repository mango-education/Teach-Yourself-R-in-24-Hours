#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
IntegerVector sampleInC(int len){
  
  // Initialize x to create output
  IntegerVector x(len);
  
  // Initialize and create s by using the Rcpp runif function
  NumericVector s = runif(len);
  
  // Loop to do sampling, using if...else...
  for(int i = 0; i < len; ++i) {
    
    if(s[i] > 0.5) 
      x[i] = 1;
     else 
       x[i] = 0;
  }
  
  // Explicitly return x
  return x;

}


