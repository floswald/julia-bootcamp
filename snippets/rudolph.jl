using Plots
using Dates

x1 = Dates.Date("2021-05-01"):Day(1):Dates.Date("2021-12-24")
x2 = Dates.Date("2021-01-01"):Day(10):Dates.Date("2021-12-24")
y1 = cumsum(randn(length(x1)))
y2 = cumsum(randn(length(x2)))
plot( plot(x1, y1, label = "Rudolph", color = :red, yticks = nothing), 
	  plot(x2, y2, label = "Santa",   l = (:red, 4),  yticks = nothing), layout = (2,1), link=:x)
