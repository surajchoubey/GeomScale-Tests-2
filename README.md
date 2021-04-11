# MONTE CARLO INTEGRATION TESTS
## (README.MD UNDER MAINTENANCE)
## 1. Easy

Task: Easy: compile and run ```volesti```. Read the CRAN package documentation, generate a random H-polytope and compute its volume.

* Compiled and ran volesti tests in C++ interface using ```cmake```, ```make ``` and ```ctest```.
* Created a random H-polytope using ```gen_rand_hpoly()``` and computed its volume using ```volume()```.

Code:

```ruby
library(volesti)
P = gen_rand_hpoly(10, 50, generator = list(constants = "sphere"))
volm = volume(P)
print(volm)
```
Output: 

```
// Output goes here
```

## 2. Medium

Task: Use the R package cubature to compute the integral of ```f(x) = exp^{-a||x||^2}``` over the cube ```[-1,1]^n```, for various values of ```a``` and dimension ```n``` until it crashes.

* Used library ```cubature``` to compute volume of ```f(x) = exp^{-a||x||^2}``` over the cube ```[-1,1]^n```, at the value of ```n=23```, the program crashed.
* Conclusion attained is the program was really slow and crashed at smaller value of ```n```, way less the ```volesti```.

Code:

```ruby
// Code goes here
```
Output: 

```
// Output goes here
```

## 3. Hard

Task: Use ```volesti``` to approximate the same integrals as in previous test by simple Monte Carlo based on uniform sampling and by Importance Sampling using multivariate spherical Gaussian. Comment on the accuracy and run-time.

* Used library ```volesti``` to compute integral ```f(x) = exp^{-a||x||^2}``` till 100th dimension using uniform and gaussian sampling.
* Comparing the time taken by ```cubature``` v/s ```volesti``` to calculate till 23rd dimension was ```s``` and ```s``` respectively (ran custom tests till 23rd dimension).
* ```volesti``` was undoubtedly fast and better at accuracy and time taken.
 
Code:

```ruby
// Code goes here
```
Output: 

```
// Output goes here
```

## 4. Bonus

Task: Generate a `100-dimensional` random H-polytope compute the largest inscribed ball (Chebychev ball) and let the center be the `x0`. Compute the integral of `f(x) = exp^{-a||x-x0||^2}` over the polytope for various values of `a`, `20` times each with both uniform and Gaussian sampling and take the average. Report the standard deviation for each experiment.

* Created HPolytope using ```gen_rand_hpoly()``` and computed centre ```x0``` of the largest inscribed ball(Chebychev ball) along with radius using ```inner_ball()```.
* Computed the integral `f(x) = exp^{-a||x-x0||^2}` over the polytope for various values of `a`, `20` times using both uniform and Gaussian sampling and took the average and calculated standard deviation using standard R functions ```mean()``` and ```sd()```

Code: 

```ruby
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
```

Output:

```
[1] "Radius of the inscribed ball =  10"
[1] "Average value of volume by uniform sampling =  5.30559731182375e+120"
[1] "Standard deviation of volume by uniform sampling =  1.81370241701095e+116"
[1] "Average value of volume by gaussian sampling =  4.76385561491636e+120"
[1] "Standard deviation of volume by gaussian sampling =  1.02632220859897e+117"
```


