### A Pluto.jl notebook ###
# v0.17.7

using Markdown
using InteractiveUtils

# ╔═╡ 0339da02-4ee2-40a6-b25f-0955f25aacd9
begin
	using AbstractTrees
	using PlutoUI
	AbstractTrees.children(x::Type) = subtypes(x)
end

# ╔═╡ 9deadd22-8766-11ec-3432-5f61ec091f16
md"""
# Julia Bootcamp - Types and Performance

Florian Oswald, 2022
"""

# ╔═╡ becdcc2a-1c24-4512-a647-72ab124a793d
md"""
## Type System

We talked about types already - it's now time to dig a bit deeper and introduce the magnificent type system of julia.

1. We have seen that everything in julia has a certain *type*.
2. We have also seen that functions can be made to behave differently, depending on which type they encounter. We called this *multiple dispatch*.

Let's look a bit at the type tree for a start.
"""

# ╔═╡ 609ab407-3f3b-43c2-9a5d-2f714677ea40
subtypes(Float64)

# ╔═╡ c151b492-4057-4357-9139-689934703913
md"""
`Float64` does *not* have any subtypes, as it's a *leaf* of the tree - can't go any further. What is above `Float64`?
"""

# ╔═╡ cde54e96-f76c-4eba-8ec3-114f611ce7d5
supertype(Float64)

# ╔═╡ 7f605c7e-8087-4657-bd1f-81b757b59448
md"""
ok, fine, but what is above an `AbstractFloat`?
"""

# ╔═╡ c20c8570-e98c-4bd1-97af-e38ddcc6ea2b
supertype(AbstractFloat)

# ╔═╡ daa28017-0130-464e-a432-d67670d6042c
md"""
Aha, a Real number. Makes sense. And a real number?
"""

# ╔═╡ 8ba70638-a987-4ba2-8e92-85dfbcb47b43
supertype(Real)

# ╔═╡ 5326480a-cdab-4114-bd65-d6012520d387
supertype(Number)

# ╔═╡ 1b736303-b00e-4426-9e8f-436bb49d3a74
supertype(Any)

# ╔═╡ a21b6694-9bf0-4d9e-bad7-348cfd7bffd4
with_terminal() do
	print_tree(Number)
end

# ╔═╡ 4865adae-d945-48df-b598-da35cb10921f
Float64 <: Number  # <: means "is subtype of"

# ╔═╡ da34c2b8-4974-4774-9627-0aac3160caf9
md"""
## Abstract and Concrete Types

* We saw the `AbstractFloat` type above. It used to organize the type system, and to define *methods* which are useful for all members of the `AbstractFloat` family.
* The leaves of the tree are *concrete* types, which are the objects we actually work with.

## Custom Types

We can define our own data types as well. Those are called `struct`s. There is a key distinction between *mutable* (i.e. can be changed) and *immutable* ones:
"""

# ╔═╡ ca4de486-5abe-4325-b829-796f3237f3d8
struct A   # that's immutable
	x  # the contents of the struct
	y
end

# ╔═╡ b603e489-4e52-4b72-b3b6-17f784135159
mutable struct B  # thats...mutable!
	x
	y
end

# ╔═╡ a076c080-28a2-4850-844c-0a3132f3ad29
md"""
Once defined, we can *instantiate*, or *construct* an **instance** of our type like this, where we call `a` and `b` **instances** of their respective types:
"""

# ╔═╡ d59376c3-02d0-4b88-9f28-4fd6cc08c8b7
a = A(1,2)

# ╔═╡ f023598a-23e4-4343-89fa-7b485f3340df
b = B(3,4)

# ╔═╡ 8fb95048-e9af-474e-b3f3-5c42da90b23d
md"""
you can access the fields with the `.` operator:
"""

# ╔═╡ 1e78f842-bdb6-4af8-a770-7e13a132f5d0
a.x

# ╔═╡ 060524dd-6b86-43c4-9940-d07695c9ac32
b.y

# ╔═╡ 01321a99-ddae-4cf3-aa61-cd2782e4ef4a


# ╔═╡ 1fdc3d69-3fb1-4e4f-9825-08945e06df7f
begin
	q(text) = Markdown.MD(Markdown.Admonition("tip", "Question", [text]));
	info(text) = Markdown.MD(Markdown.Admonition("info", "Info", [text]));
	danger(text) = Markdown.MD(Markdown.Admonition("danger", "Caution", [text]));
end

# ╔═╡ 478ddd4f-ab60-4d3d-8238-63f5061a2e11
danger(md"""
`Any` is the **mother of all types** in julia - it's the top of the type tree. Everything is a subtype of `Any`. In other words, if your data type is `Any`, it's the least specific data type possible, as *everything* can be `Any`. Picture?
""")

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
# ╟─9deadd22-8766-11ec-3432-5f61ec091f16
# ╠═0339da02-4ee2-40a6-b25f-0955f25aacd9
# ╠═becdcc2a-1c24-4512-a647-72ab124a793d
# ╠═609ab407-3f3b-43c2-9a5d-2f714677ea40
# ╠═c151b492-4057-4357-9139-689934703913
# ╠═cde54e96-f76c-4eba-8ec3-114f611ce7d5
# ╠═7f605c7e-8087-4657-bd1f-81b757b59448
# ╠═c20c8570-e98c-4bd1-97af-e38ddcc6ea2b
# ╠═daa28017-0130-464e-a432-d67670d6042c
# ╠═8ba70638-a987-4ba2-8e92-85dfbcb47b43
# ╠═5326480a-cdab-4114-bd65-d6012520d387
# ╠═1b736303-b00e-4426-9e8f-436bb49d3a74
# ╠═478ddd4f-ab60-4d3d-8238-63f5061a2e11
# ╠═a21b6694-9bf0-4d9e-bad7-348cfd7bffd4
# ╠═4865adae-d945-48df-b598-da35cb10921f
# ╟─da34c2b8-4974-4774-9627-0aac3160caf9
# ╠═ca4de486-5abe-4325-b829-796f3237f3d8
# ╠═b603e489-4e52-4b72-b3b6-17f784135159
# ╟─a076c080-28a2-4850-844c-0a3132f3ad29
# ╠═d59376c3-02d0-4b88-9f28-4fd6cc08c8b7
# ╠═f023598a-23e4-4343-89fa-7b485f3340df
# ╠═8fb95048-e9af-474e-b3f3-5c42da90b23d
# ╠═1e78f842-bdb6-4af8-a770-7e13a132f5d0
# ╠═060524dd-6b86-43c4-9940-d07695c9ac32
# ╠═01321a99-ddae-4cf3-aa61-cd2782e4ef4a
# ╠═1fdc3d69-3fb1-4e4f-9825-08945e06df7f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
