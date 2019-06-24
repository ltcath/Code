# my first kernelized oerceptron
rm(list=ls())
#set.seed(0.1)
##############################
## A few kernel functions
##############################
k1 = function(x,y)
  return(sum(x*y))
k12 = function(x,y)
  return(sum(x*y)+1)
k2 = function(x,y)
  return(sum(x*y)^2)
k3 = function(x,y)
  return((1+sum(x*y))^2)
d=4
k4 = function(x,y)
  return((1+sum(x*y))^d)
sigma=1
k5 = function(x,y)
  return(exp(-sum((x-y)^2)/(2*sigma^2)))        
kappa=1
theta=1
k6 = function(x,y)
  return(tanh(kappa*sum(x*y)+theta))
k = function(x,y)
  return(k12(x,y))
#################################
## generate some data in 2d #####
#################################
n.p=40
n.m=40
n=n.p+n.m
library(mvtnorm)
x.p=rmvnorm(n=n.p,mean=c(1,1)+c(2,2),sigma=diag(rep(1,2)))
x.m=rmvnorm(n=n.m,mean=c(-1,-1)+c(2,2),sigma=diag(rep(2,2)))
#x.m=rmvnorm(n=n.m,mean=c(1,1),sigma=diag(rep(10,2)))
y = c(rep(1,n.p),rep(-1,n.m))
x=rbind(x.p,x.m)
plot(x,col=y+rep(3,n),pch=16)
##################################
## compute the classifier ########
##################################
f.per=function(u){
  k.x=outer(1:n,1,Vectorize(function(i,j) k(x[i,],u)))
  return(sum(alpha*k.x))
}  
alpha=rep(0.0,times=n)
alpha[1]=y[1]
for (i in (2:n))
  if ((f.per(x[i,])*y[i])<0) alpha[i]=y[i]

##################################
## evaluate the classifier #######
## over a grid             #######
##################################
g.n=50
x.min=min(x)
x.max=max(x)
y.hat=matrix(NA,nrow=g.n,ncol=g.n)
g=seq(from=x.min,to=x.max,length.out=g.n)
for (i in (1:g.n)){
  for (j in (1:g.n)){
    u=c(g[i],g[j])
    k.x=outer(1:n,1,Vectorize(function(i,j) k(x[i,],u)))
    y.hat[i,j]=sum(k.x*alpha)
  }
}
filled.contour(x=g,y=g,z=y.hat,
               plot.axes = {axis(1);axis(2);points(x,col=y+rep(3,n),pch=16) })
  

