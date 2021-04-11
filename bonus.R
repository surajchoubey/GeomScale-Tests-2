library(volesti)

myfunction <- function(x,a=runif(1)) {
  y = exp(-a*(sum(x^2)))
  return(y)
}

n <- 100000 #number of sample points taken
cycles <- 20 

P = gen_rand_hpoly(100, 1000, generator = list(constants = "sphere"))
volm <- volume(P)

z <- inner_ball(P) # center of the sphere coordinates is stored into the variable
print(paste("Radius of the inscribed ball = ",z[101]))

# USING UNIFORM DISTRIBUTION

points <- sample_points(P, n, random_walk = list("walk" = "BaW", "walk_length" = 5))

# modifying points variable and shifting them according to x-x_0
for(p in 1:n){
  points[,p] <- points[,p]-z[-2]
}

accept_list<-c()

for(i in 1:cycles){
  accept <-0 
  for(j in 1:n)
  if( points[1,j] - myfunction(points[2:100,j]) < 0){
    accept <- accept + 1
  }
  accept_list <- append(accept_list,accept)
}

Mean <- mean(accept_list)/n * volm
Std_Dev <- sd(accept_list)/n * volm

print(paste("Average value of volume by uniform sampling = ", Mean ))
print(paste("Standard deviation of volume by uniform sampling = ", Std_Dev))

# USING GAUSSIAN DISTRIBUTION

points = sample_points(P, n, distribution = list("density" = "gaussian", "variance" = 2))

# modifying points variable and shifting them according to x-x_0
for(p in 1:n){
  points[,p] <- points[,p]-z[-2]
}

accept_list <- c()

for(i in 1:cycles){
  accept <-0 
  for(j in 1:n)
    if( points[1,j] - myfunction(points[2:100,j]) < 0){
      accept <- accept + 1
    }
  accept_list <- append(accept_list,accept)
}

Mean <- mean(accept_list)/n*volm
Std_Dev <- sd(accept_list)/n*volm

print(paste("Average value of volume by gaussian sampling = ", Mean ))
print(paste("Standard deviation of volume by gaussian sampling = ", Std_Dev))

