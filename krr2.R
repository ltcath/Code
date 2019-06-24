#Define Kernel Ridge Regression

krr <- function(x1, x2, y, lambda, sigma = 1) {
  x = as.matrix(x)
  x1 = x[,1]
  x2 = x[,2]
  n = nrow(x)
  p = ncol(x)
  
  K = kernlab::kernelMatrix(k, x1, x2)
  
  if (det(K + lambda*diag(n)) == 0) {
    stop("Error: Cannot invert matrix.  Choose larger lambda or smaller n")
  }
  else {
    alpha_hat = solve(K + lambda*diag(n)) %*% y
  }
  f_hat = K %*% alpha_hat
  
  residuals = f_hat - y#still working on residuals, I don't think this is right
  print(f_hat)
  print(y)
  print(f_hat)
  MSE = mean((f_hat - y)^2)
  
  out = list("Predicted Values" = f_hat,
             "Alpha_hat Vector" = alpha_hat,
             "X" = x,
             "Y" = y,
             "Residuals" = residuals,
             "MSE" = MSE)
  write.csv(out, file = "krr.csv")
  return(out)
}

krr(v, z, y, lambda = 0.0001, sigma = 1)