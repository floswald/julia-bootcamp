

shapes() = [:circle, :rect, :star5, :diamond, :hexagon, :cross, :xcross, :utriangle, :dtriangle, :rtriangle, :ltriangle, :pentagon, :heptagon, :octagon, :star4, :star6, :star7, :star8, :vline, :hline, :+, :x]
function fakelines(n)
    @assert n < 10
    fd = Plots.fakedata(12,n)
    s = shapes()[1:n]
    plot(fd, title = "$n nice lines", 
         labels = ["line $j" for i in [1], j in 1:n],
         markershape = :auto )
end