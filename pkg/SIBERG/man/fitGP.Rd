\name{fitGP}
\alias{fitGP}
\title{Fit Generalized Poisson Mixture Model}
\description{
The function fits a two-component Generalized Poisson mixture model. 
}
\usage{
fitGP(y, d=NULL, inits=NULL, model='V', zeroPercentThr=0.2)
}

\arguments{  
\item{y}{A vector representing the RNAseq raw count.}
\item{d}{A vector of the same length as y representing the normalization constant to be applied to the data. }
\item{inits}{Initial value to fit the mixture model. A vector with elements mu1, mu2, phi1, phi2 and pi1. } 
\item{model}{Character specifying E or V model. E model fits the mixture model with equal dispersion phi 
while V model doesn't put any constraint. } 
\item{zeroPercentThr}{A scalar specifying the minimum percent of zero counts needed when fitting a zero-inflated 
Generalized Poisson model. This parameter is used to deal with zero-inflation in RNAseq count data. When the percent of zero exceeds this threshold, 
rather than fitting a 2-component Generalized Poisson mixture, a mixture of point mass at 0 
and Generalized Poisson is fitted. } 

}
\details{
This function directly maximize the log likelihood function through optimization. 
With this function, three models can be fitted: (1) Generalized Poisson mixture with equal dispersion (E model); 
(2) Generalized Poisson mixture with unequal dispersion (V model); (3) 0-inflated Generalized Poisson model.
The 0-inflated Generalized Poisson has the following density function:

\eqn{P(Y=y)=\pi D(y) + (1-\pi)GP(\mu, \phi)} where D is the point mass at 0 while \eqn{GP(\mu, \phi)} is the density
of Generalized Poisson distribution with mean \eqn{\mu} and dispersion \eqn{\phi}. The variance is \eqn{\phi \mu}.

The rule to fit 0-inflated model is that the observed percentage of count exceeds the user specified threshold. This
rule overrides the model argument when observed percentae of zero count exceeds the threshold.


}

\value{
A vector consisting parameter estimates of mu1, mu2, phi1, phi2, pi1, logLik and BIC. 
For 0-inflated model, mu1=phi1=0.

}

\references{
Tong, P., Chen, Y., Su, X. and Coombes, K. R. (2012). Systematic Identification of Bimodally Expressed Genes
Using RNAseq Data. Bioinformatics, 2013 Mar 1;29(5):605-13. 
}

\author{
Pan Tong (nickytong@gmail.com), Kevin R Coombes (krc@silicovore.com)
}
\seealso{
\link{SIBER}
\link{fitLN}
\link{fitNB}
\link{fitNL}
}


\examples{
# artificial RNAseq data from negative binomial distribution
set.seed(1000)
dat <- rnbinom(100, mu=1000, size=1/0.2)
fitGP(y=dat)
}
