mutable struct MPoint
    x::Number
    y::Number
end

import Base:+  # import the + function so we can extend it

# define new `+`
function +(a::MPoint,b::MPoint)
    MPoint(a.x + b.x, a.y + b.y)
end
# also like this
+(a::MPoint,b::MPoint) = MPoint(a.x + b.x, a.y + b.y)

a = MPoint(1,2)
b = MPoint(3,5.5)
a + b
