library(volesti)

myfunction <- function(x) {
  y = exp(-0.5*sum(x^2))
  return(y)
}

accept <-0
n <- 10000 # number of sample points taken
dimensions <- 100

# SIMPLE MONTE CARLO USING UNIFORM DISTRIBUTION
for(i in 2:dimensions){
  P <- gen_cube(i,"H")
  
  points = sample_points(P, n, random_walk = list("walk" = "BaW", "walk_length" = 1))
  
  accept <-0
  
  for(j in 1:n){
    if( points[1,j] - myfunction(points[2:i,j]) < 0){
      accept <- accept + 1
    } 
  }
  
  print(paste("Integral value over [-1,1]^",i, " = ", accept/n*volume(P)))
}


