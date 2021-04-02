library(volesti)

P = gen_rand_hpoly(10, 50, generator = list(constants = "sphere"))

volm = volume(P)

print(volm)

