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

```
Output: 

```
[1] "Integral value over [-1,1]^ 2 using uniform distribution =  3.47958052914335"
[1] "Integral value over [-1,1]^ 3 using uniform distribution =  7.34310638845663"
[1] "Integral value over [-1,1]^ 4 using uniform distribution =  14.0041311403605"
[1] "Integral value over [-1,1]^ 5 using uniform distribution =  24.5581689295208"
[1] "Integral value over [-1,1]^ 6 using uniform distribution =  47.8389683606352"
[1] "Integral value over [-1,1]^ 7 using uniform distribution =  88.9909978347601"
[1] "Integral value over [-1,1]^ 8 using uniform distribution =  165.366520519254"
[1] "Integral value over [-1,1]^ 9 using uniform distribution =  320.784329246581"
[1] "Integral value over [-1,1]^ 10 using uniform distribution =  612.636524363196"
[1] "Integral value over [-1,1]^ 11 using uniform distribution =  1373.98943526384"
[1] "Integral value over [-1,1]^ 12 using uniform distribution =  2257.6189351748"
[1] "Integral value over [-1,1]^ 13 using uniform distribution =  4545.20239883357"
[1] "Integral value over [-1,1]^ 14 using uniform distribution =  9719.273797693"
[1] "Integral value over [-1,1]^ 15 using uniform distribution =  17665.2151789952"
[1] "Integral value over [-1,1]^ 16 using uniform distribution =  37318.4528566982"
[1] "Integral value over [-1,1]^ 17 using uniform distribution =  83784.2125626854"
[1] "Integral value over [-1,1]^ 18 using uniform distribution =  125387.94369372"
[1] "Integral value over [-1,1]^ 19 using uniform distribution =  200791.568133982"
[1] "Integral value over [-1,1]^ 20 using uniform distribution =  474317.991509771"
[1] "Integral value over [-1,1]^ 21 using uniform distribution =  1243317.9674028"
[1] "Integral value over [-1,1]^ 22 using uniform distribution =  2335363.97787586"
[1] "Integral value over [-1,1]^ 23 using uniform distribution =  4668724.14178082"
[1] "Integral value over [-1,1]^ 24 using uniform distribution =  8578043.93059802"
[1] "Integral value over [-1,1]^ 25 using uniform distribution =  17453430.9090393"
[1] "Integral value over [-1,1]^ 26 using uniform distribution =  41544244.744885"
[1] "Integral value over [-1,1]^ 27 using uniform distribution =  72184684.2164071"
[1] "Integral value over [-1,1]^ 28 using uniform distribution =  124467610.248677"
[1] "Integral value over [-1,1]^ 29 using uniform distribution =  239013184.064041"
[1] "Integral value over [-1,1]^ 30 using uniform distribution =  325661023.824638"
[1] "Integral value over [-1,1]^ 31 using uniform distribution =  778986724.880578"
[1] "Integral value over [-1,1]^ 32 using uniform distribution =  1825208835.99786"
[1] "Integral value over [-1,1]^ 33 using uniform distribution =  3407160274.679"
[1] "Integral value over [-1,1]^ 34 using uniform distribution =  9359095232.17973"
[1] "Integral value over [-1,1]^ 35 using uniform distribution =  24130920944.0908"
[1] "Integral value over [-1,1]^ 36 using uniform distribution =  50784624459.7556"
[1] "Integral value over [-1,1]^ 37 using uniform distribution =  50285123642.4973"
[1] "Integral value over [-1,1]^ 38 using uniform distribution =  140341665212.935"
[1] "Integral value over [-1,1]^ 39 using uniform distribution =  313458553386.779"
[1] "Integral value over [-1,1]^ 40 using uniform distribution =  597262629359.835"
[1] "Integral value over [-1,1]^ 41 using uniform distribution =  508058349712.648"
[1] "Integral value over [-1,1]^ 42 using uniform distribution =  2563108434230.31"
[1] "Integral value over [-1,1]^ 43 using uniform distribution =  3399565624297.48"
[1] "Integral value over [-1,1]^ 44 using uniform distribution =  10137070228693"
[1] "Integral value over [-1,1]^ 45 using uniform distribution =  14607212483674.7"
[1] "Integral value over [-1,1]^ 46 using uniform distribution =  38381879795844.3"
[1] "Integral value over [-1,1]^ 47 using uniform distribution =  71029843389958"
[1] "Integral value over [-1,1]^ 48 using uniform distribution =  144226849786684"
[1] "Integral value over [-1,1]^ 49 using uniform distribution =  207461093037700"
[1] "Integral value over [-1,1]^ 50 using uniform distribution =  609417902253475"
[1] "Integral value over [-1,1]^ 2 using gaussian distribution =  3.65307552902872"
[1] "Integral value over [-1,1]^ 3 using gaussian distribution =  7.96745982582881"
[1] "Integral value over [-1,1]^ 4 using gaussian distribution =  14.0865095355663"
[1] "Integral value over [-1,1]^ 5 using gaussian distribution =  29.9424947755922"
[1] "Integral value over [-1,1]^ 6 using gaussian distribution =  48.2224821236312"
[1] "Integral value over [-1,1]^ 7 using gaussian distribution =  85.8420553707497"
[1] "Integral value over [-1,1]^ 8 using gaussian distribution =  180.082597583327"
[1] "Integral value over [-1,1]^ 9 using gaussian distribution =  377.230105780463"
[1] "Integral value over [-1,1]^ 10 using gaussian distribution =  660.144264219646"
[1] "Integral value over [-1,1]^ 11 using gaussian distribution =  1337.44287903842"
[1] "Integral value over [-1,1]^ 12 using gaussian distribution =  2437.380895284"
[1] "Integral value over [-1,1]^ 13 using gaussian distribution =  4720.03420736713"
[1] "Integral value over [-1,1]^ 14 using gaussian distribution =  9184.20393889849"
[1] "Integral value over [-1,1]^ 15 using gaussian distribution =  17438.3204002611"
[1] "Integral value over [-1,1]^ 16 using gaussian distribution =  37812.0984794268"
[1] "Integral value over [-1,1]^ 17 using gaussian distribution =  76187.7392817069"
[1] "Integral value over [-1,1]^ 18 using gaussian distribution =  157567.4851812"
[1] "Integral value over [-1,1]^ 19 using gaussian distribution =  267540.901910762"
[1] "Integral value over [-1,1]^ 20 using gaussian distribution =  608603.799269992"
[1] "Integral value over [-1,1]^ 21 using gaussian distribution =  1212997.48608232"
[1] "Integral value over [-1,1]^ 22 using gaussian distribution =  2036606.0556861"
[1] "Integral value over [-1,1]^ 23 using gaussian distribution =  4704780.85914318"
[1] "Integral value over [-1,1]^ 24 using gaussian distribution =  8598142.54702057"
[1] "Integral value over [-1,1]^ 25 using gaussian distribution =  17833292.2194114"
[1] "Integral value over [-1,1]^ 26 using gaussian distribution =  40617315.6282162"
[1] "Integral value over [-1,1]^ 27 using gaussian distribution =  65956315.596745"
[1] "Integral value over [-1,1]^ 28 using gaussian distribution =  130529132.35196"
[1] "Integral value over [-1,1]^ 29 using gaussian distribution =  220081170.576365"
[1] "Integral value over [-1,1]^ 30 using gaussian distribution =  570686733.543895"
[1] "Integral value over [-1,1]^ 31 using gaussian distribution =  959165862.033751"
[1] "Integral value over [-1,1]^ 32 using gaussian distribution =  2234492877.39355"
[1] "Integral value over [-1,1]^ 33 using gaussian distribution =  4209222591.14345"
[1] "Integral value over [-1,1]^ 34 using gaussian distribution =  6866549183.13196"
[1] "Integral value over [-1,1]^ 35 using gaussian distribution =  17328490761.6516"
[1] "Integral value over [-1,1]^ 36 using gaussian distribution =  31491418336.131"
[1] "Integral value over [-1,1]^ 37 using gaussian distribution =  80463071917.654"
[1] "Integral value over [-1,1]^ 38 using gaussian distribution =  155336006498.757"
[1] "Integral value over [-1,1]^ 39 using gaussian distribution =  220769244745.982"
[1] "Integral value over [-1,1]^ 40 using gaussian distribution =  578060279053.164"
[1] "Integral value over [-1,1]^ 41 using gaussian distribution =  1197382949859.3"
[1] "Integral value over [-1,1]^ 42 using gaussian distribution =  2790447061212.67"
[1] "Integral value over [-1,1]^ 43 using gaussian distribution =  3858215623692.57"
[1] "Integral value over [-1,1]^ 44 using gaussian distribution =  7954255057818.94"
[1] "Integral value over [-1,1]^ 45 using gaussian distribution =  20930322067879.8"
[1] "Integral value over [-1,1]^ 46 using gaussian distribution =  27490151488699.7"
[1] "Integral value over [-1,1]^ 47 using gaussian distribution =  55831628001189.9"
[1] "Integral value over [-1,1]^ 48 using gaussian distribution =  154509284523988"
[1] "Integral value over [-1,1]^ 49 using gaussian distribution =  263057012174131"
[1] "Integral value over [-1,1]^ 50 using gaussian distribution =  671832954525815"
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


