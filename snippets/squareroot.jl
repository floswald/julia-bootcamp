# exercise from https://benlauwens.github.io/ThinkJulia.jl/latest/book.html#_exercises_8

function mysqrt_step(a,x)
    0.5 * (x + a / x)
end

function mysqrt(a,x; tol = 1e-8)
    Δ = 1000.0  # an arbitrary large number 
    xnew = 0.0  # a new guess for x
    iters = 0
    while Δ > tol  # convergence criterion
        iters += 1
        xnew = mysqrt_step(a,x)
        Δ = abs(xnew - x)
        x = xnew  # update x 
    end
    return (x,iters) 
end

using Printf
function sqrt_table()
    @printf("%2s %10s %10s %10s \n", "a", "mysqrt", "sqrt", "Iterations")
    for a in 2:10
        tmp = mysqrt(a,a^2)
        @printf("%2d %10f %10f %10d \n", a, tmp[1], sqrt(a), tmp[2])
    end
end

