
"""
    sir_ode!(du,u,p,t)

What is this function doing? Here are it's arguments

* `u` : variable(s) of interest (can be a vector)
* `du` : derivative(s) wrt time of u (can be a vector)
* `p` : parameters of the system 
* `t` : time period
"""
function sir_ode!(du,u,p,t)
    (S,I,R) = u  # state of the system
    (β,c,γ) = p  # parameters
    N = S + I + R  # total population
    
    du[1] = -β * c * I/N * S          # change in S
    du[2] =  β * c * I/N *S - γ*I     # change in I
    du[3] = γ*I                       # change in R
    
    nothing  # returns: nothing! it modifies `du` in the caller.
end