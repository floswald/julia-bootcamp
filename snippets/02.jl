using Distributions

n = Normal(1.0,1)
pdf(n,quantile(n,0.95))

# what is this going to return?
cdf(n,quantile(n,0.95))
