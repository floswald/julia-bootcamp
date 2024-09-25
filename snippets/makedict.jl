
# * Create a `Dict` with keys `1,3,5,7`
# * The value for for each key should be the value of the key raised to the third power.
# * Filter the elements with value greater than 21

Dict( k => k ^ 3 for k in [1,3,5,7] )
d = Dict( k => k ^ 3 for k in 1:2:7 )
filter( p -> p.second > 21, d)

# question: existing vectors into dict
# Dict(zip(k, k3))

