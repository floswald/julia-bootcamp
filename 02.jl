using Distributions

n = Normal(1.0,1)
pdf(n,quantile(n,0.95))