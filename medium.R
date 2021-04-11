library(cubature)

myfunction <- function(x,a=runif(1)) {
  y<-exp(-a * sum(x^2))
  return(y)
}

t<-1

while(TRUE){
  tryCatch({
    integral_value <- hcubature(myfunction, rep(-1,t), rep(1,t), tol=1e-4)
  })
  print(paste("Integral value over [-1,1]^",t, " = ", integral_value$integral[1]))
  t<-t+1
}
