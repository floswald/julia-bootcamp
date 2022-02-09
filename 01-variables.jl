### A Pluto.jl notebook ###
# v0.17.7

using Markdown
using InteractiveUtils

# ╔═╡ c20ae2b4-50d0-4634-9e85-a1eaaf0afa8c
using Colors  # package for color functionality

# ╔═╡ b7c5d3db-9a8f-46dc-a5be-42f5be2220fb
using Dates # built-in dates package

# ╔═╡ 505963ac-853c-11ec-028c-b34d1d0e028f
md"""
# Julia Bootcamp
"""

# ╔═╡ b182aaf9-6b81-4697-8a37-83ff03fba00e
md"""
## Assigning Variables and Mathematical Operations

* We assign with the `=` sign
* Your variable names can be any Unicode character
* Strings are in double quotes `"` and single quotes `'` are characters
* We can to `LaTeX` completion with the TAB key.
"""

# ╔═╡ 0f882cf2-a25f-4481-b8c7-15e7aa780a10
x = 4

# ╔═╡ 883d1dae-d6aa-4c42-8676-50dbcd3ab5c9
y = x ^ 2

# ╔═╡ 0d32140e-26c7-46d6-a97b-97d279eedf5e
α = 1/3  # type \alpha and hit TAB

# ╔═╡ 8687b097-97c3-4882-acf1-801ec0c01d2d
β = 2/3

# ╔═╡ 672bc5e6-fd9d-476c-81c8-c046a9d055dc
α + β == 1

# ╔═╡ 4ca5b69a-545b-4713-88f0-592182ee439d
😄, 💃, 🍕 = (1, 2, 3)  # \:pizza: and TAB

# ╔═╡ 6bf1f569-c6f8-43d0-9ea6-e77f3db4c7c4
ifelse(😄 + 💃 == 🍕, md"🎉 this is the correct, OMG", md"🤮 Oh no, totally wrong")

# ╔═╡ c8181ff7-7edf-46b2-91ce-1b0ae9221c92
md"""
We have the special updating assignment operators as well:

```julia
x += 1 # x = x + 1
x -= 2 # x = x - 2
x *= 4 # x = x * 4
x /= 1.4 # x = x / 1.4
```
"""

# ╔═╡ b848b674-bd41-432f-9ed4-542bd991780b
md"""
we can write really terse code in multiplication as long as the number is on the left of the variable:
"""

# ╔═╡ 88513608-ac93-466f-b9ec-6f249e97731f
5x + 3α - 2β

# ╔═╡ 30f00ec5-3f97-4624-8b2f-397fc5c97e71
md"""
Every object in julia has a *type*, and this is really important. We can learn the type of any object by doing
"""

# ╔═╡ b8df2f83-5877-41c1-87f9-0d70001f3043
typeof(🍕)

# ╔═╡ c4d1cb6b-7226-4f2d-a9f6-4c0cb541483e
typeof("¿Cuál es el significado de qué onda wey?")

# ╔═╡ 9b9160b8-4c60-4a6e-821d-1f4b9c78c9e4
md"""
by the way, string interpolation is really nice with the `$` operator:
"""

# ╔═╡ 3f5625cd-2718-402b-9ef0-7ae3e1eba7d7
🍺 = 2

# ╔═╡ 111deaa0-2970-4e53-92dc-8636cb723b72
md"""
I'll eat $(🍕) 🍕 and I'll drink $(🍺) 🍺. Make that $(🍺 + 1) 🍺.
"""

# ╔═╡ 9bbab050-ad99-4bcc-be23-50d4b1379108
md"""
```julia
"I'll eat $(🍕) 🍕 and I'll drink $(🍺) 🍺. Make that $(🍺 + 1) 🍺."
```
"""

# ╔═╡ 6b302cc1-fc1e-4835-aa7d-6d3e3f56daac


# ╔═╡ 65cfcb70-b754-4816-b588-91c0efe72c01
md"""
## Boolean Operators
"""

# ╔═╡ 76dbda14-90ca-4910-873d-045c0ac29aae
1 == 1

# ╔═╡ d7435925-5479-4ff7-9c0e-89759db7f58c
true || false   # short circuit and

# ╔═╡ df64ae39-7593-434a-87b8-54178af73f76
true && false   # short circuit or

# ╔═╡ c890d968-6004-4dbb-9f84-33fcf542ff4f


# ╔═╡ 23771d6f-a197-49fd-b53f-9df398598017
md"""

## basic built-in data types
"""

# ╔═╡ 8182aa7a-160b-4341-a429-2b1890b4107d
md"""
```julia
1::Int       # 64 bit integer on 64 bit Julia, no overflow warnings
1.0::Float64 # 64 bit float, defines NaN, -Inf, Inf
true::Bool   # boolean, allows "true" and "false"
'c'::Char    # character, allows Unicode
"s"::String  # strings, allows Unicode
```
"""

# ╔═╡ 45cd1145-bbcc-49cc-981d-997dd4ca652e
md"""
we can convert types with the `convert` function, or by just calling the *constructor* of a certain type (more on that later!):
"""

# ╔═╡ fa12276d-6ef4-42c5-a6b9-9cea4af344e4
convert(Float64,1)

# ╔═╡ 0bac8b82-3450-4ab3-8db4-d47cff57f24a
Float64(1)

# ╔═╡ 173f003a-6c10-4b81-9e0f-896a6681c08e
convert(Int,2.0)

# ╔═╡ 9fdf6eeb-8dec-4db4-8f76-808693d9e3af
Int(2.0)

# ╔═╡ 63dc06e0-cad1-4519-8aed-44255dd63e80
string(true)

# ╔═╡ 51787899-7339-4210-aa62-c4d1960f2333
Int(true)

# ╔═╡ c4128a1b-1e1c-4808-9da7-895fc5b88e46
Bool(1)

# ╔═╡ 37e0b7f2-ecc2-40cc-8776-bf4abdb0e81f
Bool(2) #error

# ╔═╡ 63d4b74a-c51c-4876-af20-af35a61931a3
zero(1.1)  # the additive identity element of typeof(1.1)

# ╔═╡ 7a9e0bbe-5e5c-49d9-9f03-c4b75348007c
one(1+3im)  # multiplicative identity element of imaginary numbers

# ╔═╡ 2751b1b6-cc43-4331-a0ec-6a3b6ed34f1d
floor(π), ceil(π), round(π, digits =3)

# ╔═╡ ba168312-dd09-446e-82c0-e59c888a5b42
parse(Int,"1") isa Int  # same as isa(parse(Int,"1"),Int)

# ╔═╡ 894dc9f8-72af-4e12-963c-f848699fd4f2
BigFloat(10)^1000

# ╔═╡ 65321f25-c155-448c-ab5f-d310a6bdb94e
md"""
Next to `convert` we can also *promote* types to a common type:
"""

# ╔═╡ 65f98399-4a1f-4c08-b479-452c3d23e88a
promote(1, 2.5)  # `upgrades` the Int to a Float

# ╔═╡ 4a353442-e563-4e2f-917f-e31e0059019b
md"""
### Strings
"""

# ╔═╡ 0b51f9e2-49db-40e6-8538-dc6f3a3b56b5
s = "¿Cuál es el significado" 

# ╔═╡ 4c0c2f5e-2336-4be1-bcd7-bca51a51d9f6
typeof(s)

# ╔═╡ c5bceb53-3dd1-48b9-b36d-e9ed5bd6a55c
s * " de qué onda wey?"    # the * operator concatenates a string

# ╔═╡ e415a8ef-c9d1-404e-a945-0613e3118a53
string("hi"," there")

# ╔═╡ d4558619-6fce-4cf7-9552-10553d0b13c1
string("number = ",112)

# ╔═╡ bd00eff7-031a-4cb4-ac5c-67a97538d9b6
md"""
There are bunch of *special strings* in julia as well. Like in this notebook, I'm using *markdown strings* all the time with `md"string"` (part of the `Markdown` package).
"""

# ╔═╡ 0be453a4-7b06-4d9c-9868-3ca8ee341f83
md"""
This is a markdown string. You guys know [markdown](https://docs.julialang.org/en/v1/stdlib/Markdown/)?
"""

# ╔═╡ c2bf25cd-43c0-4739-8978-21de5b2cd0ac
md"""
Raw strings are good for windows file paths: 
"""

# ╔═╡ cf3c2069-da2f-423f-9cf6-6285ad94af59
raw"C:\MyWindows\Path"

# ╔═╡ 856b1263-61d0-4d60-bf41-292d2cfcf012
md"""
## File System
"""

# ╔═╡ e2471749-1374-47e7-8013-d0071b1d5ee0
md"""
Oh, file paths. Never hard code a file path. use this instead:
"""

# ╔═╡ 64f9e174-0855-49fb-8dfa-d90adae7c268
joinpath("path","to","file")   # the file separater (the slash) is OS specific

# ╔═╡ e2ba69c5-94f4-4ec9-8acb-85bb8311f893
md"""
you can refer to the location of the current file
"""

# ╔═╡ 872590dc-9756-48b6-9bf0-f7e1d8d01501
@__FILE__

# ╔═╡ 6a126422-62cc-4b8e-998b-5fa11520049b
@__DIR__  # current directory. useful for scripts andprograms

# ╔═╡ 9cbb941a-bbf6-49a1-892c-962f16bbab90
pwd()  # useful in an interactive session

# ╔═╡ 9286d7d7-4eea-4236-83d2-f6c3ccc8bd0f
cd(".")  # change to directory (the dot is the current directory!)

# ╔═╡ b26020a0-bb82-4261-be06-f39162edad13
contains("There are many football clubs in Barelona", "football")

# ╔═╡ 567e6a01-baca-4c9e-b1f9-dba2885a0805
occursin("football", "There are many football clubs in Barelona")

# ╔═╡ 42e71a94-29c3-43e2-a669-a62fb54a3ca7
r = r"A|B"  # a regex

# ╔═╡ d29a6c41-e72b-4be9-a695-09c835375483
occursin(r,"CDE")

# ╔═╡ 57b72616-2eb4-4154-a5a2-df5c02220417
occursin(r,"The A-Team")

# ╔═╡ a74db094-81c7-4f23-af47-9a93aecca866
match(r, "The A-Team is Ace, Buddy")  # find first match

# ╔═╡ 2f507515-bf94-48f5-9473-7195abdaa3ca
eachmatch(r, "The A-Team is Ace, Buddy")  # find all matches

# ╔═╡ 060482dc-38cc-4a8b-b114-7cf9f4fa6b94
[e.match for e in eachmatch(r, "The A-Team is Ace, Buddy")]  

# ╔═╡ 3c37e656-c960-4846-b94e-76eeb17c7814
md"""
Wow, what's that? An Array! What's an array? ➡ a *Collection*!
"""

# ╔═╡ d1cba411-5ac6-4f1c-a6d6-004070ee4ee6
md"""
## Collections

In julia you have many different containers for data, each useful for a different purpose. Collections are called *iterables* in julia, because you can *iterate* over them, i.e. traverse them one by one and do stuff with each element. Notice that sometimes you can only *read* each element (and not write).

*Indexing*, i.e. *getting an element from a collection* is done with the `[]` operator in julia, like if `c` is a collection, 

```
c[4]
```
you would get the *fourth element* of `c`.

**Julia indexing starts at 1!**

### Tuples and NamedTuples

Tuples are immutable (often short) sequences of values. *immutable* means you can't change them.
"""

# ╔═╡ ee73f510-26e0-491f-9ff9-da12acb920fe
w = (1,2,"what's up",🍕)

# ╔═╡ bd9dc1c7-eb73-458b-bfd7-cf043311a881
w[1]

# ╔═╡ d8760510-1773-44c9-9f59-f3bcd3badb0e
w[3]

# ╔═╡ 3b483860-094c-41b0-8f2a-f99e08abe29c
w[4] = 10  # cannot change a tuple, i.e. cannot assign a different value

# ╔═╡ c7e68933-095d-4fd7-a938-12a93856f298
md"""
NamedTuples are similar, but you can give names. 
"""

# ╔═╡ 5ce16643-19c2-4f56-81c3-e5865e656a6e
ww = (one = 1, two = 2, three = "what's up", 🍔 = 🍕)

# ╔═╡ 527925b4-5bef-4299-8947-2f78e3c71c65
ww[1]   # can still index by position  

# ╔═╡ 87782135-a05d-4e84-ad8e-b4d163632904
ww[:three]  # by name as a "Symbol" (the : creates a symbol)

# ╔═╡ 43012bd6-83b4-41f4-ac8a-1cabea0e1417
ww[:🍔]   # 🍔 is just another name!

# ╔═╡ 89b15836-c931-4902-b3c8-faaa0c6e4761
md"""
or with the object accessor `.`
"""

# ╔═╡ 92c3561d-a180-4e72-80b0-f936c7ad51d1
ww.two   # or with the object accessor `.`

# ╔═╡ 4d64e715-3d3d-4a5f-90fb-328052c3ff97
md"""
## Ranges

A range is a sequence with fixed step size. The advantage of julia ranges is that they are computed *lazily*, i.e. we never store an entire array of values. We only store 3 values: `start`, `stop` and `step`:
"""

# ╔═╡ 6c676131-b7b0-4faa-9261-9ac6b14ccc32
ra = 0:2:12  

# ╔═╡ c096fc85-3a1c-4667-8e62-595a65b65b8c
typeof(ra)

# ╔═╡ 778e0c66-e9cf-45ab-8fc8-95955a208bd7
rb = range(0, stop = 10, length = 11)

# ╔═╡ 4db3429f-6901-46dd-85ae-85c3b53c5993
typeof(rb)

# ╔═╡ 65422359-25c9-43db-90c0-161abbad4ac4
md"""
you can collect all values into a standard array with 
"""

# ╔═╡ c6445e9e-ea94-46a8-95e7-47ea642d23e0
collect(ra)

# ╔═╡ 1ab25def-758c-4d6d-83e1-33fc37ec04aa
md"""
but most of the times you don't need that. we use ranges often to index other iterables, and so we go through the range on by one. for, example, if we want to get the fifth element of `ra`, the corresponding value is computed on the fly:
"""

# ╔═╡ 78160acc-fa24-4cd3-9d89-9750df24caac
ra[5]

# ╔═╡ b1210e5b-2ba9-47f5-b965-360b5c0cda88
ra[5] = 2

# ╔═╡ 833a7d75-12ea-44c6-b946-da287566dee1
md"""
ranges can be built on many data types, not just numbers.
"""

# ╔═╡ 8fe2d586-65ce-4df2-8b17-3406b95ab914
letters = 'a':'z'

# ╔═╡ 1438bcde-9d01-4d5e-b273-f675a5383e67
letters[4]

# ╔═╡ ac6f68fd-5c84-4650-98f1-b26f4a7bc547
range(colorant"red", stop=colorant"green", length=15)

# ╔═╡ 70598515-4f53-4c0a-92a2-ff18ac36c3f5
dr = Date(2014,1,29):Day(1):Date(2014,2,3)

# ╔═╡ dc8722ce-2a0e-4a87-8cb9-5704c74ed7fd
dr[2]

# ╔═╡ 6768aba8-5135-4b11-a9a8-81a84c130c61
md"""
### Dictionaries

* Similar to `R` `list` objects
* Similar to `python` `dicts`
* Similar to *linked lists* in FORTRAN
* like a `map` in `C++`.

We have a `key => value` structure. the `key` can be any type, as can of course the `value`.
"""

# ╔═╡ b48a6589-22a1-4dec-9bd5-96d6fb33d8b8
phonebook = Dict(:john => 34221, :mary => 12344)

# ╔═╡ d02618a3-720d-42f1-89fb-ff80733e2339
phonebook[:john]

# ╔═╡ 72229086-eedb-4bd0-8f0c-49bb5731e1f8
phonebook[1]

# ╔═╡ cd456c1f-0b63-45f7-aea2-f9f2a205bbb0
phonebook[:peter] = 43210  # notice once it's created, assign with '='

# ╔═╡ 51d37b9d-f630-4ed3-9ec4-699cd68470cd
phonebook["florian"] = 12334  # wrong type of key

# ╔═╡ 666f5e87-5e14-4cd0-8c44-497d11562414
typeof(phonebook)

# ╔═╡ 5d9eea1e-3f09-4634-9a8a-91000fe9bdde
Dict( k => rand([true,false],rand(1:4)) for k in 1:2 )  # Dict constructor 

# ╔═╡ 11efb440-cf18-4e8a-9751-f92a0a85f96e
keys(phonebook)

# ╔═╡ 87a56c3a-1e2e-489e-a790-783180e6cc21
values(phonebook)

# ╔═╡ a42fcc5d-2998-48cd-a5c6-aa97be940af0
with_terminal() do
	for (k,v) in phonebook
		println("The number of $k is $v")
	end
end

# ╔═╡ b8061445-404d-46c6-a811-4f4cb566fb25
haskey(phonebook, :florian)

# ╔═╡ 2046420f-ad09-4143-9072-0320d20b3ef3
filter( p -> p.first == :peter, phonebook)  # x -> 2x is an anonymous function

# ╔═╡ e125a1af-ce81-491b-b7a2-c3e7e0ee8216
filter( p -> p.second > 12500, phonebook)

# ╔═╡ d64bdfdb-50d5-476d-81ae-2543e0e246da
begin
	q(text) = Markdown.MD(Markdown.Admonition("tip", "Question", [text]));
	info(text) = Markdown.MD(Markdown.Admonition("info", "Info", [text]));
	danger(text) = Markdown.MD(Markdown.Admonition("danger", "Caution", [text]));
end

# ╔═╡ 066a7ddd-7203-44aa-9029-0566f91a0348
q(md"""
* create a create a variable s1 that contains the word "hello"
* create a variable n that contains your name as a string
* use the `println` function to print the sentence "hello, n, welcome to julia!" where you want to evaluate the value of `n` inside the string.
""")

# ╔═╡ b24fcce2-f729-49e2-9cbc-b0cf28ca6e33
q(md"""
* save the path of the current directory into a variable `dir`
* look at `?mkdir` and create a new folder `bootcamp` in your tempdir.
* you can get your tempdir with `tempdir`
* use `cd` to go into the new `bootcamp` folder
* use `cd` again to go back to `dir`
""")

# ╔═╡ cc346dd2-5920-46b7-b192-db59ce4f04d6
q(md"""
* look at `?findall` to find all the positions of the the characters `'g'` or 😄 (!) in "The weather is good today, I'm not going to take an umbrella 😄"
""")

# ╔═╡ 6caf7a73-7377-4e6f-9858-b9cdc141746d
q(md"""
* Create a `Dict` with keys `1,3,5,7`
* The set of numbers `1,3,5,7` should be represent by a `range`.
* The value for for each key should be the value of the key raised to the third power.
* Filter the elements with value greater than 21
""")

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Colors = "5ae59095-9a9b-59fe-a467-6f913c188581"
Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"

[compat]
Colors = "~0.12.8"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.1"
manifest_format = "2.0"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
"""

# ╔═╡ Cell order:
# ╟─505963ac-853c-11ec-028c-b34d1d0e028f
# ╟─b182aaf9-6b81-4697-8a37-83ff03fba00e
# ╠═0f882cf2-a25f-4481-b8c7-15e7aa780a10
# ╠═883d1dae-d6aa-4c42-8676-50dbcd3ab5c9
# ╠═0d32140e-26c7-46d6-a97b-97d279eedf5e
# ╠═8687b097-97c3-4882-acf1-801ec0c01d2d
# ╠═672bc5e6-fd9d-476c-81c8-c046a9d055dc
# ╠═4ca5b69a-545b-4713-88f0-592182ee439d
# ╠═6bf1f569-c6f8-43d0-9ea6-e77f3db4c7c4
# ╟─c8181ff7-7edf-46b2-91ce-1b0ae9221c92
# ╟─b848b674-bd41-432f-9ed4-542bd991780b
# ╠═88513608-ac93-466f-b9ec-6f249e97731f
# ╠═30f00ec5-3f97-4624-8b2f-397fc5c97e71
# ╠═b8df2f83-5877-41c1-87f9-0d70001f3043
# ╠═c4d1cb6b-7226-4f2d-a9f6-4c0cb541483e
# ╠═9b9160b8-4c60-4a6e-821d-1f4b9c78c9e4
# ╠═3f5625cd-2718-402b-9ef0-7ae3e1eba7d7
# ╟─111deaa0-2970-4e53-92dc-8636cb723b72
# ╟─9bbab050-ad99-4bcc-be23-50d4b1379108
# ╠═6b302cc1-fc1e-4835-aa7d-6d3e3f56daac
# ╟─65cfcb70-b754-4816-b588-91c0efe72c01
# ╠═76dbda14-90ca-4910-873d-045c0ac29aae
# ╠═d7435925-5479-4ff7-9c0e-89759db7f58c
# ╠═df64ae39-7593-434a-87b8-54178af73f76
# ╠═c890d968-6004-4dbb-9f84-33fcf542ff4f
# ╟─23771d6f-a197-49fd-b53f-9df398598017
# ╟─8182aa7a-160b-4341-a429-2b1890b4107d
# ╟─45cd1145-bbcc-49cc-981d-997dd4ca652e
# ╠═fa12276d-6ef4-42c5-a6b9-9cea4af344e4
# ╠═0bac8b82-3450-4ab3-8db4-d47cff57f24a
# ╠═173f003a-6c10-4b81-9e0f-896a6681c08e
# ╠═9fdf6eeb-8dec-4db4-8f76-808693d9e3af
# ╠═63dc06e0-cad1-4519-8aed-44255dd63e80
# ╠═51787899-7339-4210-aa62-c4d1960f2333
# ╠═c4128a1b-1e1c-4808-9da7-895fc5b88e46
# ╠═37e0b7f2-ecc2-40cc-8776-bf4abdb0e81f
# ╠═63d4b74a-c51c-4876-af20-af35a61931a3
# ╠═7a9e0bbe-5e5c-49d9-9f03-c4b75348007c
# ╠═2751b1b6-cc43-4331-a0ec-6a3b6ed34f1d
# ╠═ba168312-dd09-446e-82c0-e59c888a5b42
# ╠═894dc9f8-72af-4e12-963c-f848699fd4f2
# ╟─65321f25-c155-448c-ab5f-d310a6bdb94e
# ╠═65f98399-4a1f-4c08-b479-452c3d23e88a
# ╟─4a353442-e563-4e2f-917f-e31e0059019b
# ╠═0b51f9e2-49db-40e6-8538-dc6f3a3b56b5
# ╠═4c0c2f5e-2336-4be1-bcd7-bca51a51d9f6
# ╠═c5bceb53-3dd1-48b9-b36d-e9ed5bd6a55c
# ╠═e415a8ef-c9d1-404e-a945-0613e3118a53
# ╠═d4558619-6fce-4cf7-9552-10553d0b13c1
# ╟─066a7ddd-7203-44aa-9029-0566f91a0348
# ╟─bd00eff7-031a-4cb4-ac5c-67a97538d9b6
# ╠═0be453a4-7b06-4d9c-9868-3ca8ee341f83
# ╟─c2bf25cd-43c0-4739-8978-21de5b2cd0ac
# ╠═cf3c2069-da2f-423f-9cf6-6285ad94af59
# ╟─856b1263-61d0-4d60-bf41-292d2cfcf012
# ╟─e2471749-1374-47e7-8013-d0071b1d5ee0
# ╠═64f9e174-0855-49fb-8dfa-d90adae7c268
# ╠═e2ba69c5-94f4-4ec9-8acb-85bb8311f893
# ╠═872590dc-9756-48b6-9bf0-f7e1d8d01501
# ╠═6a126422-62cc-4b8e-998b-5fa11520049b
# ╠═9cbb941a-bbf6-49a1-892c-962f16bbab90
# ╠═9286d7d7-4eea-4236-83d2-f6c3ccc8bd0f
# ╟─b24fcce2-f729-49e2-9cbc-b0cf28ca6e33
# ╠═b26020a0-bb82-4261-be06-f39162edad13
# ╠═567e6a01-baca-4c9e-b1f9-dba2885a0805
# ╠═42e71a94-29c3-43e2-a669-a62fb54a3ca7
# ╠═d29a6c41-e72b-4be9-a695-09c835375483
# ╟─cc346dd2-5920-46b7-b192-db59ce4f04d6
# ╠═57b72616-2eb4-4154-a5a2-df5c02220417
# ╠═a74db094-81c7-4f23-af47-9a93aecca866
# ╠═2f507515-bf94-48f5-9473-7195abdaa3ca
# ╠═060482dc-38cc-4a8b-b114-7cf9f4fa6b94
# ╟─3c37e656-c960-4846-b94e-76eeb17c7814
# ╟─d1cba411-5ac6-4f1c-a6d6-004070ee4ee6
# ╠═ee73f510-26e0-491f-9ff9-da12acb920fe
# ╠═bd9dc1c7-eb73-458b-bfd7-cf043311a881
# ╠═d8760510-1773-44c9-9f59-f3bcd3badb0e
# ╠═3b483860-094c-41b0-8f2a-f99e08abe29c
# ╠═c7e68933-095d-4fd7-a938-12a93856f298
# ╠═5ce16643-19c2-4f56-81c3-e5865e656a6e
# ╠═527925b4-5bef-4299-8947-2f78e3c71c65
# ╠═87782135-a05d-4e84-ad8e-b4d163632904
# ╠═43012bd6-83b4-41f4-ac8a-1cabea0e1417
# ╟─89b15836-c931-4902-b3c8-faaa0c6e4761
# ╠═92c3561d-a180-4e72-80b0-f936c7ad51d1
# ╠═4d64e715-3d3d-4a5f-90fb-328052c3ff97
# ╠═6c676131-b7b0-4faa-9261-9ac6b14ccc32
# ╠═c096fc85-3a1c-4667-8e62-595a65b65b8c
# ╠═778e0c66-e9cf-45ab-8fc8-95955a208bd7
# ╠═4db3429f-6901-46dd-85ae-85c3b53c5993
# ╟─65422359-25c9-43db-90c0-161abbad4ac4
# ╠═c6445e9e-ea94-46a8-95e7-47ea642d23e0
# ╟─1ab25def-758c-4d6d-83e1-33fc37ec04aa
# ╠═78160acc-fa24-4cd3-9d89-9750df24caac
# ╠═b1210e5b-2ba9-47f5-b965-360b5c0cda88
# ╠═833a7d75-12ea-44c6-b946-da287566dee1
# ╠═8fe2d586-65ce-4df2-8b17-3406b95ab914
# ╠═1438bcde-9d01-4d5e-b273-f675a5383e67
# ╠═c20ae2b4-50d0-4634-9e85-a1eaaf0afa8c
# ╠═ac6f68fd-5c84-4650-98f1-b26f4a7bc547
# ╠═b7c5d3db-9a8f-46dc-a5be-42f5be2220fb
# ╠═70598515-4f53-4c0a-92a2-ff18ac36c3f5
# ╠═dc8722ce-2a0e-4a87-8cb9-5704c74ed7fd
# ╟─6768aba8-5135-4b11-a9a8-81a84c130c61
# ╠═b48a6589-22a1-4dec-9bd5-96d6fb33d8b8
# ╠═d02618a3-720d-42f1-89fb-ff80733e2339
# ╠═72229086-eedb-4bd0-8f0c-49bb5731e1f8
# ╠═cd456c1f-0b63-45f7-aea2-f9f2a205bbb0
# ╠═51d37b9d-f630-4ed3-9ec4-699cd68470cd
# ╠═666f5e87-5e14-4cd0-8c44-497d11562414
# ╠═5d9eea1e-3f09-4634-9a8a-91000fe9bdde
# ╠═11efb440-cf18-4e8a-9751-f92a0a85f96e
# ╠═87a56c3a-1e2e-489e-a790-783180e6cc21
# ╠═a42fcc5d-2998-48cd-a5c6-aa97be940af0
# ╠═b8061445-404d-46c6-a811-4f4cb566fb25
# ╠═2046420f-ad09-4143-9072-0320d20b3ef3
# ╠═e125a1af-ce81-491b-b7a2-c3e7e0ee8216
# ╟─6caf7a73-7377-4e6f-9858-b9cdc141746d
# ╠═d64bdfdb-50d5-476d-81ae-2543e0e246da
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
