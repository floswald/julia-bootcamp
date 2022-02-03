### A Pluto.jl notebook ###
# v0.17.7

using Markdown
using InteractiveUtils

# ╔═╡ 0f93b987-a8d8-4ca9-874e-40c263abb848
begin
	using AbstractTrees
	using PlutoUI
	AbstractTrees.children(x::Type) = subtypes(x)
end
	

# ╔═╡ 505963ac-853c-11ec-028c-b34d1d0e028f
md"""
# Julia Bootcamp
"""

# ╔═╡ b182aaf9-6b81-4697-8a37-83ff03fba00e
md"""
## Assigning Variables

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

# ╔═╡ 23771d6f-a197-49fd-b53f-9df398598017
md"""
## data types

* basic built-in types
  * conversions
* tupes
* arrays
  cliboard data from browser
* Composite Types
* Dictionaries
* strings
"""

# ╔═╡ 8182aa7a-160b-4341-a429-2b1890b4107d
md"""
```julia
1::Int       # 64 bit integer on 64 bit Julia, no overflow warnings
1.0::Float64 # 64 bit float, defines NaN, -Inf, Inf
true::Bool   # boolean, allows "true" and "false"
'c'::Char    # character, allows Unicode
"s"::String  # strings, allows Unicode, see also Strings below
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

# ╔═╡ 4a353442-e563-4e2f-917f-e31e0059019b
md"""
### Strings
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

# ╔═╡ 6768aba8-5135-4b11-a9a8-81a84c130c61
md"""
### Dictionaries
"""

# ╔═╡ 962e7e32-37c4-4558-98a4-8b15f27132ba
md"""
### Arrays
"""

# ╔═╡ bc65166b-1505-47de-a92d-63030a675225
md"""
### Arrays
"""

# ╔═╡ 5c37940a-423a-41b5-a278-f2a60479524e


# ╔═╡ 317d447e-97f7-4255-928d-be52c3afdc74
with_terminal() do
	print_tree(Number)
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
AbstractTrees = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
AbstractTrees = "~0.3.4"
PlutoUI = "~0.7.34"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.1"
manifest_format = "2.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.AbstractTrees]]
git-tree-sha1 = "03e0550477d86222521d254b741d470ba17ea0b5"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.3.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "0b5cfbb704034b5b4c1869e36634438a047df065"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "8979e9802b4ac3d58c503a20f2824ad67f9074dd"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.34"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

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

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

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

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
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
# ╟─23771d6f-a197-49fd-b53f-9df398598017
# ╟─8182aa7a-160b-4341-a429-2b1890b4107d
# ╠═45cd1145-bbcc-49cc-981d-997dd4ca652e
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
# ╠═4a353442-e563-4e2f-917f-e31e0059019b
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
# ╠═6768aba8-5135-4b11-a9a8-81a84c130c61
# ╠═962e7e32-37c4-4558-98a4-8b15f27132ba
# ╠═bc65166b-1505-47de-a92d-63030a675225
# ╠═5c37940a-423a-41b5-a278-f2a60479524e
# ╟─0f93b987-a8d8-4ca9-874e-40c263abb848
# ╟─317d447e-97f7-4255-928d-be52c3afdc74
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
