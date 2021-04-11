library(volesti)

myfunction <- function(x) {
  y = exp(-0.5*sum(x^2))
  return(y)
}

#Below can be changed as per used 
# n is the number of sample points taken
# dimensions: till what dimension you want to calculate

n <- 10000 
dimensions <- 50 

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
  
  print(paste("Integral value over [-1,1]^",i,"using uniform distribution = ", accept/n*volume(P)))
}

# SIMPLE MONTE CARLO USING GAUSSIAN DISTRIBUTION
for(i in 2:dimensions){
  P <- gen_cube(i,"H")
  
  points = sample_points(P, n , distribution = list("density" = "gaussian", "variance" = 1))
  
  accept <-0
  
  for(j in 1:n){
    if( points[1,j] - myfunction(points[2:i,j]) < 0){
      accept <- accept + 1
    } 
  }

  print(paste("Integral value over [-1,1]^",i, "using gaussian distribution = ", accept/n*volume(P)))
}
