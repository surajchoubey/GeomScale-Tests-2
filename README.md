# MONTE CARLO INTEGRATION TESTS

## 1. Easy

Task: Easy: compile and run ```volesti```. Read the CRAN package documentation, generate a random H-polytope and compute its volume.

* Compiled and run volesti in C++ interface using ```cmake```

* Created a random H-polytope using ```gen_rand_hpoly()``` and computed its volume using ```volume()```

```ruby
library(volesti)
P = gen_rand_hpoly(10, 50, generator = list(constants = "sphere"))
volm = volume(P)
print(volm)
```

## 2. Medium

## 3. Hard

## 4. Bonus


