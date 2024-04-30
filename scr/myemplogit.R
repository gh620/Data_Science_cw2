#' Simulate rounded Gaussian random variates
#'
#' param yvar the target variable y, should be a vector with values between 0 to 1.
#' param xvar the variable x
#' param maxbins the number of bins to calculate the interval mean for the plots
#' param sc controls how large the buuble/dots in the plot
#' 
#' notice that a hand trial and error of the maxbin and the sc parameter is needed to produce a sensible plot
#'
#' return The empirical logits plot between log(odds) of yvar vs xvar
#'
#' reference: Dr. Teresa Brunsdon, Materials in Advanced Statistical Modelling Module from University of Warwick

library(Stat2Data)    # for myemplogit() function
library(plyr)         # for myemplogit() function

myemplogit <- function(yvar=y,xvar=x,maxbins=10,sc=1,line=TRUE,...){
  breaks  <<- unique(quantile(xvar, probs=0:maxbins/maxbins))
  levs  <<- (cut(xvar, breaks, include.lowest=FALSE))
  num <<- as.numeric(levs)
  c.tab <- count(num,'levs')
  c.tab$levs <- factor(c.tab$levs, levels = levels(addNA(c.tab$levs)), 
                       labels = c(levels(c.tab$levs), paste("[",min(xvar),"]",sep="")), exclude = NULL)
  c.tab <- c.tab[c(nrow(c.tab),1:nrow(c.tab)-1),]
  sc <- (max(c.tab$freq)/min(c.tab$freq)/sc)^2
  zcex <<- sqrt(c.tab$freq/pi)/sc
  print(c.tab);print(zcex);print(sc)
  emplogitplot1(yvar~xvar,breaks=breaks,cex=zcex,showline=line,...)
}