### A Pluto.jl notebook ###
# v0.19.40

using Markdown
using InteractiveUtils

# ╔═╡ 9e8ca0a8-3b36-4ef0-a3a8-4f15a61bcb7f
begin
	using PlutoUI
	using AbstractTrees
	using Dates
	using Distributions
end

# ╔═╡ 4723a50e-f6d1-11ea-0b1c-3d33a9b92f87
md"""
# Julia Bootcamp - Data Types


Florian Oswald, $(Dates.format(Dates.today(), "dd u yyyy"))
"""

# ╔═╡ 91ba119e-670a-11eb-0bb2-15ac7192e7e7
html"<button onclick='present()'>present</button>"

# ╔═╡ 92cef0a4-670a-11eb-2df2-5b31a1602299
md"
# Types in Julia

* Julia has a very rich type system
* The [manual](https://docs.julialang.org/en/v1/manual/types/) is very good again.
* What's really cool with julia is the easy with which we can declare new types.
"

# ╔═╡ 3b265f7c-d500-4e34-8770-55c74ff8e306
md"""
## Type System

We talked about types already - it's now time to dig a bit deeper and introduce the magnificent type system of julia.

1. We have seen that everything in julia has a certain *type*.
2. We have also seen that functions can be made to behave differently, depending on which type they encounter. We called this *multiple dispatch*.

Let's look a bit at the type tree for a start.
"""

# ╔═╡ ce3f2d01-4c41-42fb-8136-5833caa76c7e
md"""
#
"""

# ╔═╡ a86a4033-82c8-43ba-892a-c0dd296cadbc
subtypes(Float64)

# ╔═╡ d3b34825-28a5-4f84-9b5f-daa7514a59bc
md"""
`Float64` does *not* have any subtypes, as it's a *leaf* of the tree - can't go any further. What is above `Float64`?
"""

# ╔═╡ b98fae39-681e-42cf-a788-2052373b2f7e
supertype(Float64)

# ╔═╡ a92d1167-e556-4250-a46d-b392e268dfb0
md"""
ok, fine, but what is above an `AbstractFloat`?
"""

# ╔═╡ d26e157d-af55-4ee3-9a02-ff0bbb511113
supertype(AbstractFloat)

# ╔═╡ c44d5856-4a43-403c-b71d-e96cdadf11d5
md"""
Aha, a Real number. Makes sense. And a real number?
"""

# ╔═╡ 93f97e5a-1675-4987-8c58-d1ce4943982b
supertypes(Real)

# ╔═╡ 71a43e12-9f1e-4b4b-b141-f85516b9be9f
md"""
#
"""

# ╔═╡ d19385e0-678a-11eb-3156-c51cb20abe3e
md"
# Julia Base Type System

Here is the basics of the `Number` type in julia. This is just one part of the type system. 

At the very top of all types (not shown) is the `DataType` `Any`, from which all others are derived.
"

# ╔═╡ f6249141-8c42-4631-a487-c4a6afcd7b9d
AbstractTrees.children(x::Type) = subtypes(x)

# ╔═╡ c2b13386-256f-4df3-9ca4-64f6e551a91f
print_tree(stdout,Number)

# ╔═╡ aa5adfba-678e-11eb-02e4-210b8b753e21
subtypes(Integer)

# ╔═╡ bff062f0-678e-11eb-131d-e11297e36d4b
supertypes(Integer)

# ╔═╡ 0dce8005-3001-4dab-b2e8-71e113464621
md"""
## Abstract and Concrete Types

* We saw the `AbstractFloat` type above. It used to organize the type system, and to define *methods* which are useful for all members of the `AbstractFloat` family.
* The leaves of the tree are *concrete* types, which are the objects we actually work with.

## Custom Types

We can define our own data types as well. Those are called `struct`s. There is a key distinction between *mutable* (i.e. can be changed) and *immutable* ones:
"""

# ╔═╡ 194dd1c4-9731-4a6b-a89a-8ec48a3afd0a
struct A   # that's immutable
	x  # the contents of the struct
	y
end

# ╔═╡ 0b812de3-35ef-46f4-b564-3846f1d24546
mutable struct B  # thats...mutable!
	x
	y
end

# ╔═╡ 2f8a6a81-04c0-4c2c-8059-5bdf25042eec
md"""
Once defined, we can *instantiate*, or *construct* an **instance** of our type like this, where we call `a` and `b` **instances** of their respective types:
"""

# ╔═╡ ce4be32d-6373-40a9-a33e-a78cb8d90808


# ╔═╡ e23742e2-7b6f-4b14-8a81-a366cf76dbd3
a = A(1,2)

# ╔═╡ 28bb8cb7-06cd-4971-acd2-f10e490f54be
b = B(3,4)

# ╔═╡ f0d4b551-84e1-4cf7-9786-45ab326244f1
md"""
you can access the fields with the `.` operator:
"""

# ╔═╡ 92c57af3-2a12-40c7-b7f7-f4eb2a6bcf9b
b.x

# ╔═╡ bed2a154-f6d1-11ea-0812-1f5c628a9785
md"
# Why define new types?

Here is an example. Many mathematical and other objects can be represented by a pair of numbers, for example:

  - a rectangle has a width and a height;
  - a complex number has a real and imaginary part;
  - a position vector in 2D space has 2 components.

Each of these could naturally be represented by a pair $(x, y)$ of two numbers, or in Julia as a tuple:"

# ╔═╡ 81113974-f6d2-11ea-2ef8-fb2930402a74
begin 
	rectangle = (3, 4)   # could mean (width, height)
	c = (3, 4)   # could mean 3 + 4im
	x = (3, 4)   # could be a position vector
end

# ╔═╡ a4296474-6714-11eb-0500-1d888fe18b51
md"#"

# ╔═╡ ac321d80-f6d2-11ea-2951-676e6e1aef56
md"


But from the fact that we have to remind ourselves using comments what each of these numbers represents, and the fact that they all look the same but should behave very differently, we see that there is a problem here. 

For example, we would like to have a function `width` that returns the width of a rectangle, but it makes no sense to apply that to a complex number.

In other words, we need a way to be able to distinguish between different *types of* objects with different *behaviours*.
"

# ╔═╡ 9a168a92-670b-11eb-34af-0121d1a252bd
md"
# Defining a New type
"

# ╔═╡ 66abc04e-f6d8-11ea-27d8-9f8b14659755
struct Rectangle
	width::Float64
	height::Float64
end

# ╔═╡ 7571be3a-f6d8-11ea-174c-9d65d5185153
md"""The keyword `struct` (short for "structure") tells Julia that we are defining a new type. We list the field names together with **type annotations** using `::` that specify which type each field can contain."""

# ╔═╡ 9f384ac2-f6d8-11ea-297e-4bf09acf9fe7
md"Once Julia has this template, we can create objects which have that type as follows:"

# ╔═╡ b0dac516-f6d8-11ea-1bdb-b59723107206
r = Rectangle(1, 2.5)

# ╔═╡ af236602-5ffa-11eb-0bec-cd944a602c70
md"the function `Rectangle` with identical name to our type is called a **constructor**."

# ╔═╡ b98b9faa-f6d8-11ea-3610-bf8a84af2b5a
md"
#

We can check that `r` is now a variable whose type is `Rectangle`, in other words `r` *is a* `Rectangle`:"

# ╔═╡ cf1c4aae-f6d8-11ea-3200-c5fb458c7c09
typeof(r)

# ╔═╡ d0749974-f6d8-11ea-2f41-074b6744f3d5
r isa Rectangle

# ╔═╡ d372342c-f6d8-11ea-10cd-573cf7eab992
md"""We can  extract from `r` the information about the values of the fields that it contains using "`.`": """

# ╔═╡ dd8f9e88-f6d8-11ea-15e3-f17f4af0d81b
r.width

# ╔═╡ e3e70064-f6d8-11ea-22fd-892bbc567ed4
r.height

# ╔═╡ e582eb02-f6d8-11ea-1fcc-89bbc9dfbb07
md"

#

We can create a new `Rectangle` with its own width and height:"

# ╔═╡ f2ed18b4-f6d8-11ea-3bc7-0b82eb5e8dc0
r2 = Rectangle(3.0, 4.0)

# ╔═╡ ab5b20ee-4ba8-49cd-b747-f57c5738ac63
r.width

# ╔═╡ f9d192fe-f6d8-11ea-138d-3dcdff33c034
md"You should check that this does *not* affect the `width` and `height` variables belonging to `r`."

# ╔═╡ 6085144c-f6db-11ea-19fe-ed46dafb4562
md"Types like this are often called **composite types**; they consist of aggregating, or collecting together, different pieces of information that belong to a given object."

# ╔═╡ 1840898e-f6d9-11ea-3035-bb4dac496834
md"

## Mutable vs immutable


Now suppose we want to change the width of `r`. We would naturally try the following:

"

# ╔═╡ 63f76d28-f6d9-11ea-071c-458528c36008
r.width = 10

# ╔═╡ 68934a2a-f6d9-11ea-37ea-850304f6d3d6
md"But Julia complains that fields of objects of type `Rectangle` *cannot* be modified. This is because `struct` makes **immutable** (i.e. unchangeable) objects. The reason for this is that these usually lead to *faster code*."

# ╔═╡ 3fa7d8e2-f6d9-11ea-2e82-9f59b5cb9424
md"## Functions on types

We can now define functions that act only on given types. To restrict a given function argument to only accept objects of a certain type, we add a type annotation:"

# ╔═╡ 8c4beb6e-f6db-11ea-12d1-cf450181363b
width(r::Rectangle) = r.width

# ╔═╡ 91e21d28-f6db-11ea-1b0f-336719682f28
width(r)

# ╔═╡ 2ef7392e-f6dc-11ea-00e4-770cdf9a102e
md"Applying the function to objects of other types gives an error:"

# ╔═╡ 9371209e-f6db-11ea-3ba2-c3597d42d8ed
width(3)   # throws an error

# ╔═╡ d1166a30-670b-11eb-320d-9b13b96824fb
md"#"

# ╔═╡ b916acb4-f6dc-11ea-3cdf-2b8ab3c34e03
md"""It is common in Julia to have "generic" versions of functions that apply to any object, and then specialised versions that apply only to certain types.

For example, we might want to define an `area` function with the correct definition for `Rectangle`s, but it might be convenient to fall back to a version that just returns the value itself for any other type:"""

# ╔═╡ 6fe1b332-f6dd-11ea-39d4-1954aeda6f08
begin
	# two different function bodies for the same function name!
	area(r::Rectangle) = r.width * r.height
	area(x) = x
end

# ╔═╡ c34355b8-f6dd-11ea-1089-cf5be2117ba8
area(r)

# ╔═╡ c4a7fae6-f6dd-11ea-1851-3bd445ebf677
area(17)

# ╔═╡ c83180d8-f6dd-11ea-32f7-634b781070f1
md"

#

But since we didn't restrict the type in the second method, we also have"

# ╔═╡ d3dc64b6-f6dd-11ea-1273-7fb3957e4964
area("hello")

# ╔═╡ 6d7ca590-f6f5-11ea-0a00-6128f971b546
area

# ╔═╡ d6e5a276-f6dd-11ea-34aa-b9e2d3805364
md"which does not make much sense."

# ╔═╡ 79fa562e-f6dd-11ea-2e97-df3c62c83685
md"Note that these are different versions of the function with the *same* function name; each version acting on different (combinations of) types is called a **method** of the (generic) function."

# ╔═╡ a1d2ae6c-f6dd-11ea-0216-ef9db5d9e29b
md"Suppose that later we create a `Circle` type. We can then just add a new method `area(c::Circle)` with the corresponding definition, and Julia will continue to choose the correct version (method) when we call `area(x)`, depending on the type of `x`.

[Note that at the time of writing, Pluto requires all methods of a function to be defined in the same cell.]
"

# ╔═╡ 41e21994-f6de-11ea-0e5c-0515a3a52f6f
md"## Multiple dispatch


The act of choosing which function to call based on the type of the arguments that are passed to the function is called **dispatch**. A central feature of Julia is **multiple dispatch**: this choice is made based on the types of *all* the arguments to a function.

For example, the following three calls to the `+` function each call *different* methods, defined in different locations. Click on the links to see the definition of each method in the Julia source code on GitHub!"

# ╔═╡ 4204309d-65e7-40c5-8e7a-3b779814c1ef
md"""
#
"""

# ╔═╡ 814e328c-f6de-11ea-13c0-d1b97714c4f3
cc = 3 + 4im

# ╔═╡ cdd3e14e-f6f5-11ea-15e2-bd309e658823
cc + cc

# ╔═╡ e01e26f2-f6f5-11ea-13b0-95413a6f7290
+

# ╔═╡ 84cae75c-f6de-11ea-3cd4-1b263e34771f
@which cc + cc

# ╔═╡ 8ac4904a-f6de-11ea-105b-8925016ca6d5
@which cc + 3

# ╔═╡ 8cd9f438-f6de-11ea-2b58-93bbb860a005
@which 3 + cc

# ╔═╡ d6183261-d370-412f-95d1-7a066b5d03ec
md"""
#
"""

# ╔═╡ 549c63e4-670c-11eb-2574-55611c612e43
md"
# A `WorkerSpell` Type

* Let's look at something a bit more relevant for us
* [Robin, Piyapromdee and Lentz](https://www.dropbox.com/s/4ylyn1v7fe0jmn1/Piyapromdee_Anatomy.pdf?dl=0) write *On Worker and Firm Heterogeneity in Wages and Employment Mobility: Evidence from Danish Register Data*
* Their data are *worker spells* at firms in appendix E.1
* They have $I = 4,000,000$ workers and $J=400,000$ firms

# What is a `Spell`?

It's a period of time that a worker spent at a certain firm, earning a certain wage.

1. Start/end date of spell
1. ID of worker $i$ and firm $j$
1. A vector of wages for each year in the spell $w_i$
1. An indicator whether the worker changes firm after this spell, $D_{it}$

# Why Not a Spreadsheet?

* They have a likelihood function to estimate which encodes for worker $i$ the likelihood of observing the data

$$(w_{it}, j_{it}, x_{it})_{t=1}^{T_i}$$

* Simplifying a bit, this looks for worker $i$ like

$$L_i = \Pi_{t=1}^{T_i} f(w_{it} | j_{it}, x_{it}) \times \Pi_{t=1}^{T_i} S(i,j_{it},x_{it})^{1-D_{it}} M(j'|i,j_{it},x_{it})^{D_{it}}$$

* Can you see the $T_i$ there? 
* 👉different workers have differently long spells!
"

# ╔═╡ 1a5ca388-670e-11eb-0321-51c90fcbef35
md"## Defining a `Spell`"

# ╔═╡ 0b9cb9f4-670f-11eb-338a-5d6c16c99248
mutable struct Spell 
	start       :: Date
	stop        :: Date
	duration    :: Week
	firm        :: Int   # ∈ 1,2,...,L+1
	wage        :: Float64
	change_firm :: Bool   # switch firm after this spell?
	function Spell(t0::Date,fid::Int)  # this is the `inner constructor` method
		this = new()
		this.start = t0
		this.stop = t0
		this.duration = Week(0)
		this.firm = fid
		this.wage = 0.0
		this.change_firm = false
		return this 
	end
end

# ╔═╡ c63a5110-670d-11eb-0502-5fc01e7d59d5
md"#

Let's create one of those:
"

# ╔═╡ 320edd04-670f-11eb-2a98-353ca1501537
sp = Spell(Date("2015-03-21"), 34)

# ╔═╡ 3d2a7a92-670f-11eb-265c-77d1d30af869
md"ok, great. now we need a way to set some infos on this type. In particular, we want to record the wage the worker got, and how long the spell lasted. Here is function to call at the end of a spell:"

# ╔═╡ 50b68470-670f-11eb-2fd2-e9ac408adad2
md"#"

# ╔═╡ 52ecd1f4-670f-11eb-1843-7380dcf1ee54
function finish!(s::Spell,w::Float64,d::Week)
    @assert d >= Week(0)
    s.stop = s.start + d
    s.duration = d
    s.wage = w
end

# ╔═╡ 6359fe04-670f-11eb-1b4e-7d4193109484


# ╔═╡ 5afaa42c-670f-11eb-1e96-afa2a6466656
md"
let's say that particular spell lasted for 14 weeks and was characterised by a wage of 100.1 Euros
"

# ╔═╡ 5f97e3f8-670f-11eb-2b7b-e54286c0cbb3
finish!(sp, 100.1, Week(14))

# ╔═╡ 622172a6-670f-11eb-1910-8fe1652cf65b
sp

# ╔═╡ 666fba34-670f-11eb-19b0-6f5046362154
md"# Workers

Next, we need a worker. Workers accumulate `Spells`.
"

# ╔═╡ ddfab162-670f-11eb-1bff-037e2e001178
mutable struct Worker
    id :: Int   # name
    T  :: Int   # number of WEEKS observed
    l  :: Int   # current firm ∈ 1,2,...,L+1
    spells :: Vector{Spell}  # an array of type Spell
    function Worker(id,T,start::Date,l::Int)
        this = new()
        this.id = id
        this.T = T 
        this.l = l
        this.spells = Spell[Spell(start,l)]
        return this
    end
end

# ╔═╡ 1b971326-6710-11eb-2b7b-eba640d686ba
md"
#

Let's create a worker and make him work at a new firm:
"

# ╔═╡ 27629a70-6710-11eb-0527-2fe3a1fd89b5
w0 = Worker(13, 18, Dates.today(), 3)

# ╔═╡ 7119d84c-6710-11eb-0afd-b3695a395be1
md"and let's say that first spell lasts for 15 weeks at 500 Euros per week"

# ╔═╡ a5ec451e-6710-11eb-0b52-95ef2e17082e
finish!(w0.spells[end], 500.0,  Week(15))

# ╔═╡ d8ed9ee0-6710-11eb-33a0-d5648e5e3891
w0.spells

# ╔═╡ 5291c44c-6725-11eb-3508-5113b947e07b
md"
# Useful?

When we want to evaluate the function $L_i$ above, we need to sum over each workers $T_i$ weeks of work." 

# ╔═╡ e5635fae-6725-11eb-3bcc-491220b5e24a
begin
	N = 50 # workers
	F = 20 # firms
end

# ╔═╡ b8c625c8-6725-11eb-3853-2916ae6f4af5
begin
	starts = rand(Date(2014,1,29):Week(1):Dates.today(),N)
	Ts = rand(5:10,N)
	js = rand(1:F,N)
	wrks = [Worker(id,Ts[id],starts[id],js[id]) for id in 1:N]
end

# ╔═╡ f521adde-6726-11eb-1904-5d4a8cd90746
md"
#
"

# ╔═╡ fa1c3a34-6726-11eb-333b-21b7f91d524c
md"
now let's set some wages on those workers. Let's say with prob 0.5 they have 2 spells:
"

# ╔═╡ a2df9a4e-6727-11eb-129b-9bd913058795
Ln = LogNormal(1.0,	0.1)

# ╔═╡ 050b2ba8-6727-11eb-1a9a-738f657d78e6
begin
	# an empty array of type worker
	dates = Date(2014,1,29):Week(1):Dates.today()
    workers = Worker[]
	for iw in 1:N
		w = Worker(iw,rand(5:10),rand(dates),rand(1:F))
		dur = 0 # start with zero weeks
		for tx in 1:w.T
			dur += 1 # increase duration
			if rand() < 0.5
				# switches to another firm
				finish!(w.spells[end], rand(Ln), Week(dur))
				dur = 0 # reset duration
				w.spells[end].change_firm = true
				# new spell starts on the same day!
				newfirm = rand(1:F)
				push!(w.spells, Spell(w.spells[end].stop,newfirm))
				w.l = newfirm
			else
				# nothing to record: stay at same firm
			end
			if tx == w.T
				# finish last spell
				finish!(w.spells[end], rand(Ln), Week(dur))
			end
		end
		push!(workers,w)
	end
end

# ╔═╡ b8ccbe4e-6728-11eb-1f1f-7367e85017c6
workers

# ╔═╡ e2b3e500-6728-11eb-3b01-f769c8a4c799
md"# Summing over the Likelihood

Then, finally, we can iterate over our array of workers like this
"

# ╔═╡ fc2f870c-6728-11eb-06ff-ab6affcfaefe
begin
	L0 = 0.0
	for iw in workers
		# loops over multiple spells
		# for each worker
		for (idx, sp) in enumerate(iw.spells)
			L0 += logpdf(Ln, sp.wage)
		end						
	end
end

# ╔═╡ 5d72de64-672a-11eb-2b64-e73f79c72d9c
L0

# ╔═╡ 525ce1f7-c433-4aa8-b5b7-17c334d93ba1
begin
	q(text) = Markdown.MD(Markdown.Admonition("tip", "Question", [text]));
	info(text) = Markdown.MD(Markdown.Admonition("info", "Info", [text]));
	danger(text) = Markdown.MD(Markdown.Admonition("danger", "Caution", [text]));
end

# ╔═╡ ae8ee93d-4956-46cc-86c5-7be8b74500ac
danger(md"""
`Any` is the **mother of all types** in julia - it's the top of the type tree. Everything is a subtype of `Any`. In other words, if your data type is `Any`, it's the least specific data type possible, as *everything* can be `Any`. Picture?
""")

# ╔═╡ 6b8055c8-ec26-45b9-9a83-04adf8b283a0
q(md"""
1. Create a mutable struct called `MPoint` with two fields `x` and `y`, both restricted to be of type `Number`
2. Create an instance `m` that holds `x = 1.5` and `y = 4.1`
3. Finally, *change* the value of y by doing `m.y = 3.1`
""")

# ╔═╡ b04f3eb1-9a24-42ab-8ff1-db69b0cd97ac
q(md"""
Create a *method* for `+` which will add together two instances of your `MPoint` type created above. So, we want to be able to write `a + b` where both `a` and `b` are `MPoint`s. You have to decide yourself what the meaning of **adding two `MPoint`s actually is**. I would suggest to add the coordinates to each other, i.e. take the `x` from the `a` and add to the `x` of `b`. Here is how:
1. You must `import` the existing `+` methods from the `Base` module. Type `import Base.:+` (we need the `:` because the `+` is called an *infix* function)
2. Define `+(a::MPoint, b::Mpoint) = ... ` . you have to fill in `...` what the function is supposed to do. Hint: you want to create a *new instance* of `MPoint`, made up of the contents of `a` and `b` 😉
3. Then, try it out! Create `a = MPoint(1,2)` and `b = MPoint(3,5.5)` and show us `a + b`!

	"""
)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
AbstractTrees = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
AbstractTrees = "~0.3.4"
Distributions = "~0.25.107"
PlutoUI = "~0.7.17"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.4"
manifest_format = "2.0"
project_hash = "fb324762188b4d11b6b9fceb7065e100225ff108"

[[deps.AbstractTrees]]
git-tree-sha1 = "03e0550477d86222521d254b741d470ba17ea0b5"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.3.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "c955881e3c981181362ae4088b35995446298b80"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.14.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "97d79461925cdb635ee32116978fc735b9463a39"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.19"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Distributions]]
deps = ["FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns"]
git-tree-sha1 = "7c302d7a5fec5214eb8a5a4c466dcf7a51fcf169"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.107"

    [deps.Distributions.extensions]
    DistributionsChainRulesCoreExt = "ChainRulesCore"
    DistributionsDensityInterfaceExt = "DensityInterface"
    DistributionsTestExt = "Test"

    [deps.Distributions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DensityInterface = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.DualNumbers]]
deps = ["Calculus", "NaNMath", "SpecialFunctions"]
git-tree-sha1 = "5837a837389fccf076445fce071c8ddaea35a566"
uuid = "fa6b7ba4-c1ee-5f82-b5fc-ecf0adba8f74"
version = "0.6.8"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FillArrays]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "bfe82a708416cf00b73a3198db0859c82f741558"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.10.0"
weakdeps = ["PDMats", "SparseArrays", "Statistics"]

    [deps.FillArrays.extensions]
    FillArraysPDMatsExt = "PDMats"
    FillArraysSparseArraysExt = "SparseArrays"
    FillArraysStatisticsExt = "Statistics"

[[deps.HypergeometricFunctions]]
deps = ["DualNumbers", "LinearAlgebra", "OpenLibm_jll", "SpecialFunctions"]
git-tree-sha1 = "f218fe3736ddf977e0e772bc9a586b2383da2685"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.23"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
git-tree-sha1 = "5efcf53d798efede8fee5b2c8b09284be359bf24"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.2"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7e5d6779a1e09a36db2a7b6cff50942a0a7d0fca"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.5.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.4.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "18144f3e9cbe9b15b070288eef858f71b291ce37"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.27"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "949347156c25054de2db3b166c52ac4728cbad65"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.31"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "ae4bbcadb2906ccc085cf52ac286dc1377dceccc"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.1.2"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PlutoUI]]
deps = ["Base64", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "615f3a1eff94add4bca9476ded096de60b46443b"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.17"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "9b23c31e76e333e6fb4c1595ae6afa74966a729e"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.9.4"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "f65dcb5fa46aee0cf9ed6274ccbd597adc49aa7b"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.7.1"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6ed52fdd3382cf21947b15e8870ac0ddbff736da"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.4.0+0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "e2cfc4012a19088254b3950b85c3c1d8882d864d"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.3.1"

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

    [deps.SpecialFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1ff449ad350c9c4cbc756624d6f8a8c3ef56d3ed"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "5cf7606d6cef84b543b483848d4ae08ad9832b21"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.3"

[[deps.StatsFuns]]
deps = ["HypergeometricFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "cef0472124fab0695b58ca35a77c6fb942fdab8a"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.3.1"

    [deps.StatsFuns.extensions]
    StatsFunsChainRulesCoreExt = "ChainRulesCore"
    StatsFunsInverseFunctionsExt = "InverseFunctions"

    [deps.StatsFuns.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╠═9e8ca0a8-3b36-4ef0-a3a8-4f15a61bcb7f
# ╟─4723a50e-f6d1-11ea-0b1c-3d33a9b92f87
# ╟─91ba119e-670a-11eb-0bb2-15ac7192e7e7
# ╟─92cef0a4-670a-11eb-2df2-5b31a1602299
# ╟─3b265f7c-d500-4e34-8770-55c74ff8e306
# ╟─ce3f2d01-4c41-42fb-8136-5833caa76c7e
# ╠═a86a4033-82c8-43ba-892a-c0dd296cadbc
# ╟─d3b34825-28a5-4f84-9b5f-daa7514a59bc
# ╠═b98fae39-681e-42cf-a788-2052373b2f7e
# ╟─a92d1167-e556-4250-a46d-b392e268dfb0
# ╠═d26e157d-af55-4ee3-9a02-ff0bbb511113
# ╟─c44d5856-4a43-403c-b71d-e96cdadf11d5
# ╠═93f97e5a-1675-4987-8c58-d1ce4943982b
# ╟─71a43e12-9f1e-4b4b-b141-f85516b9be9f
# ╟─ae8ee93d-4956-46cc-86c5-7be8b74500ac
# ╟─d19385e0-678a-11eb-3156-c51cb20abe3e
# ╠═f6249141-8c42-4631-a487-c4a6afcd7b9d
# ╟─c2b13386-256f-4df3-9ca4-64f6e551a91f
# ╠═aa5adfba-678e-11eb-02e4-210b8b753e21
# ╠═bff062f0-678e-11eb-131d-e11297e36d4b
# ╟─0dce8005-3001-4dab-b2e8-71e113464621
# ╠═194dd1c4-9731-4a6b-a89a-8ec48a3afd0a
# ╠═0b812de3-35ef-46f4-b564-3846f1d24546
# ╟─2f8a6a81-04c0-4c2c-8059-5bdf25042eec
# ╟─ce4be32d-6373-40a9-a33e-a78cb8d90808
# ╠═e23742e2-7b6f-4b14-8a81-a366cf76dbd3
# ╠═28bb8cb7-06cd-4971-acd2-f10e490f54be
# ╟─f0d4b551-84e1-4cf7-9786-45ab326244f1
# ╠═92c57af3-2a12-40c7-b7f7-f4eb2a6bcf9b
# ╟─bed2a154-f6d1-11ea-0812-1f5c628a9785
# ╠═81113974-f6d2-11ea-2ef8-fb2930402a74
# ╟─a4296474-6714-11eb-0500-1d888fe18b51
# ╟─ac321d80-f6d2-11ea-2951-676e6e1aef56
# ╟─9a168a92-670b-11eb-34af-0121d1a252bd
# ╠═66abc04e-f6d8-11ea-27d8-9f8b14659755
# ╟─7571be3a-f6d8-11ea-174c-9d65d5185153
# ╟─9f384ac2-f6d8-11ea-297e-4bf09acf9fe7
# ╠═b0dac516-f6d8-11ea-1bdb-b59723107206
# ╟─af236602-5ffa-11eb-0bec-cd944a602c70
# ╟─b98b9faa-f6d8-11ea-3610-bf8a84af2b5a
# ╠═cf1c4aae-f6d8-11ea-3200-c5fb458c7c09
# ╠═d0749974-f6d8-11ea-2f41-074b6744f3d5
# ╟─d372342c-f6d8-11ea-10cd-573cf7eab992
# ╠═dd8f9e88-f6d8-11ea-15e3-f17f4af0d81b
# ╠═e3e70064-f6d8-11ea-22fd-892bbc567ed4
# ╟─e582eb02-f6d8-11ea-1fcc-89bbc9dfbb07
# ╠═f2ed18b4-f6d8-11ea-3bc7-0b82eb5e8dc0
# ╠═ab5b20ee-4ba8-49cd-b747-f57c5738ac63
# ╟─f9d192fe-f6d8-11ea-138d-3dcdff33c034
# ╟─6085144c-f6db-11ea-19fe-ed46dafb4562
# ╟─1840898e-f6d9-11ea-3035-bb4dac496834
# ╠═63f76d28-f6d9-11ea-071c-458528c36008
# ╟─68934a2a-f6d9-11ea-37ea-850304f6d3d6
# ╟─6b8055c8-ec26-45b9-9a83-04adf8b283a0
# ╟─3fa7d8e2-f6d9-11ea-2e82-9f59b5cb9424
# ╠═8c4beb6e-f6db-11ea-12d1-cf450181363b
# ╠═91e21d28-f6db-11ea-1b0f-336719682f28
# ╟─2ef7392e-f6dc-11ea-00e4-770cdf9a102e
# ╠═9371209e-f6db-11ea-3ba2-c3597d42d8ed
# ╟─d1166a30-670b-11eb-320d-9b13b96824fb
# ╟─b916acb4-f6dc-11ea-3cdf-2b8ab3c34e03
# ╠═6fe1b332-f6dd-11ea-39d4-1954aeda6f08
# ╠═c34355b8-f6dd-11ea-1089-cf5be2117ba8
# ╠═c4a7fae6-f6dd-11ea-1851-3bd445ebf677
# ╟─c83180d8-f6dd-11ea-32f7-634b781070f1
# ╠═d3dc64b6-f6dd-11ea-1273-7fb3957e4964
# ╠═6d7ca590-f6f5-11ea-0a00-6128f971b546
# ╟─d6e5a276-f6dd-11ea-34aa-b9e2d3805364
# ╟─79fa562e-f6dd-11ea-2e97-df3c62c83685
# ╟─a1d2ae6c-f6dd-11ea-0216-ef9db5d9e29b
# ╟─41e21994-f6de-11ea-0e5c-0515a3a52f6f
# ╟─4204309d-65e7-40c5-8e7a-3b779814c1ef
# ╠═814e328c-f6de-11ea-13c0-d1b97714c4f3
# ╠═cdd3e14e-f6f5-11ea-15e2-bd309e658823
# ╠═e01e26f2-f6f5-11ea-13b0-95413a6f7290
# ╠═84cae75c-f6de-11ea-3cd4-1b263e34771f
# ╠═8ac4904a-f6de-11ea-105b-8925016ca6d5
# ╠═8cd9f438-f6de-11ea-2b58-93bbb860a005
# ╟─d6183261-d370-412f-95d1-7a066b5d03ec
# ╟─b04f3eb1-9a24-42ab-8ff1-db69b0cd97ac
# ╟─549c63e4-670c-11eb-2574-55611c612e43
# ╟─1a5ca388-670e-11eb-0321-51c90fcbef35
# ╠═0b9cb9f4-670f-11eb-338a-5d6c16c99248
# ╟─c63a5110-670d-11eb-0502-5fc01e7d59d5
# ╠═320edd04-670f-11eb-2a98-353ca1501537
# ╟─3d2a7a92-670f-11eb-265c-77d1d30af869
# ╟─50b68470-670f-11eb-2fd2-e9ac408adad2
# ╠═52ecd1f4-670f-11eb-1843-7380dcf1ee54
# ╠═6359fe04-670f-11eb-1b4e-7d4193109484
# ╟─5afaa42c-670f-11eb-1e96-afa2a6466656
# ╠═5f97e3f8-670f-11eb-2b7b-e54286c0cbb3
# ╠═622172a6-670f-11eb-1910-8fe1652cf65b
# ╟─666fba34-670f-11eb-19b0-6f5046362154
# ╠═ddfab162-670f-11eb-1bff-037e2e001178
# ╟─1b971326-6710-11eb-2b7b-eba640d686ba
# ╠═27629a70-6710-11eb-0527-2fe3a1fd89b5
# ╟─7119d84c-6710-11eb-0afd-b3695a395be1
# ╠═a5ec451e-6710-11eb-0b52-95ef2e17082e
# ╠═d8ed9ee0-6710-11eb-33a0-d5648e5e3891
# ╟─5291c44c-6725-11eb-3508-5113b947e07b
# ╠═e5635fae-6725-11eb-3bcc-491220b5e24a
# ╠═b8c625c8-6725-11eb-3853-2916ae6f4af5
# ╟─f521adde-6726-11eb-1904-5d4a8cd90746
# ╟─fa1c3a34-6726-11eb-333b-21b7f91d524c
# ╠═a2df9a4e-6727-11eb-129b-9bd913058795
# ╠═050b2ba8-6727-11eb-1a9a-738f657d78e6
# ╠═b8ccbe4e-6728-11eb-1f1f-7367e85017c6
# ╟─e2b3e500-6728-11eb-3b01-f769c8a4c799
# ╠═fc2f870c-6728-11eb-06ff-ab6affcfaefe
# ╠═5d72de64-672a-11eb-2b64-e73f79c72d9c
# ╟─525ce1f7-c433-4aa8-b5b7-17c334d93ba1
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
