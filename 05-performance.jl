### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ 0339da02-4ee2-40a6-b25f-0955f25aacd9
begin
	using AbstractTrees
	using PlutoUI
	AbstractTrees.children(x::Type) = subtypes(x)
	using BenchmarkTools
	using Dates
	using LinearAlgebra
end

# ╔═╡ 9deadd22-8766-11ec-3432-5f61ec091f16
md"""
# Julia Bootcamp - Types and Performance

Florian Oswald, $(Dates.format(Dates.today(), "dd u yyyy"))


"""

# ╔═╡ a91e6f40-54e3-4ed9-af97-923068ab7ff1
html"<button onclick='present()'>present</button>"

# ╔═╡ 87f1838d-1630-4e38-928a-50e6c032eeb8
md"""
## The Basics

1. All performance critical code has to be inside a function
2. Avoid global variables at all cost
3. Pre-allocate arrays and/or avoid too much memory allocation in general
4. Don't confuse the julia compiler by writing code with *type instability*

### So. Why is julia fast anyway?

* Julia runs as fast as C or fortran because the julia compiler (based on the [LLVM](https://llvm.org/) compiler) generates machine instructions which are very similar, if not identical to those low-level languages.
* In cases where this is not true, something is wrong (usually with the code we wrote).
* the key is how julia specializes instructions for the supplied input types: adding two `Int` is not the same LLVM instruction as is adding to `Float`s, for example.

"""

# ╔═╡ a6dbe781-9db9-4804-8341-e5203ebfa5fe
md"""
#
"""

# ╔═╡ dc10db9a-d42e-4823-9a84-dfcae53cf2f9
md"""
## Measure and Benchmark

* The first task is to accurately measure the time it takes to perform a certain task. 
* `@time` is the base julia timing and memory usage macro.
* `@btime` is from `BenchmarkTools.jl` and is more sophisticated. 
* The built-in [code profiler](https://docs.julialang.org/en/v1/manual/profile/#Profiling) is very good. ProfileView.jl provides a GUI where you can click on the line that takes most time.

### Avoid global variables

If you have to, mark them with `const x` inside some namespace (like a package). Do not measure the compilation time (i.e. the first run of a function), but the run time (second run):
"""

# ╔═╡ b290c05d-e77f-486c-b32a-b8e366b98d9f
md"""
#
"""

# ╔═╡ 16dd0736-6f1b-422f-93c2-10a96ba70177
x = rand(1000);

# ╔═╡ a7023bf2-91c8-40dc-ae4d-6baaafe92522
function sum_global()
    s = 0.0
    for i in x
		s += i
    end
    return s
end

# ╔═╡ 80ac3661-2b10-4194-aa95-27c86bad05ce
@time sum_global()

# ╔═╡ 8aa13a67-812e-4440-bb5a-92ad6bae8ef9
@time sum_global()

# ╔═╡ 4e6afdd5-2c8d-45d2-99ba-ee7ddfbac6f1
md"""
#
"""

# ╔═╡ 06924d26-8f65-4288-a437-29209a736411
md"""
* In this example, we see a significant amount of memory allocation.
* This is strange, as their should be nothing allocated: we just sum over a array `x` in global scope.
* so there is a problem. This is a sign that we are allocating many small arrays or are otherwise messing up. 
* Let's pass `x` as an arugement instead:
"""

# ╔═╡ f519847f-2fde-4c35-b6bf-b1306723e45c
function sum_global_arg(x)
    s = 0.0
    for i in x
		s += i
    end
    return s
end

# ╔═╡ 1b73ff00-b46f-4315-b9ba-88a4ec5ccb30
@time sum_global_arg(x)

# ╔═╡ 6869e39f-cf70-4762-963f-42a4eb2fa72b
md"""
#

* No memory allocation at all!
* So, it seems leaving `x` in global scope means that there will some *copying* from global scope into the function scope, which means unnecessary work and lost time. Passing the argument leaves the array in place where it is.
"""

# ╔═╡ a9573443-1c99-4318-ad04-932698a1e519
md"""
## Avoid Type Instabilities

* Avoid tricking the JIT compiler that he can rely on your type being stable throughout the function.
* If halfway through you change data type, that's an issue:
"""

# ╔═╡ 5a55126a-1193-4650-883d-5ee43df1b012
function unstable()
	N= 10_000
	x = ones(Int,N) # x is an Int
	y = 1
    for i = 1:N
        x0 = x[i] / rand()  # this converts x into a float
		y += x0
    end
    return x,y
end

# ╔═╡ 70d961ec-ef48-4da1-ada1-c4a480efab18
md"""
let's first verify that:
"""

# ╔═╡ 9fc6575d-fab6-4b51-8160-53a70a875ac5
(typeof(1),typeof(1.0), typeof(1/rand()))

# ╔═╡ 241852b8-5d82-4666-936d-49520a0d24cd
md"""
#

ok, run the benchmarks!
"""

# ╔═╡ 222db2b2-de06-4283-ae16-4a32c8dc7f8c
bu = @benchmark unstable()

# ╔═╡ 57c5bce7-7a96-41a6-a8ed-79aba5fbf795
md"""
#
"""

# ╔═╡ d2feab8e-c56a-4ae6-bafd-560c82b7d52d
function stable()
    N= 10_000
	x = ones(Float64,N) # x is an Float array
	y = 1
    for i = 1:N
        x0 = x[i] / rand()  # this converts x into a float
		y += x0
    end
    return x,y
end

# ╔═╡ ac9352d5-b6e3-4e84-b07c-316b18dc809d
bs = @benchmark stable()

# ╔═╡ 6a17e7b7-f6b5-4108-a655-c20351c3475c
md"""
#

That looks like a tiny difference, but notice that with more complicated functions, this problem will get much worse. Also, the functions are *identical* up to the `.0` in the beginning, a very small change to have such an impact:
"""

# ╔═╡ 61f80625-140d-4e4f-8a1e-8860b8d56da6
j = judge(median(bu), median(bs))

# ╔═╡ 4a6ece68-f74c-4309-94bb-991e1da83295
md"""
#
"""

# ╔═╡ 28672e20-a27c-4157-a61b-0e1f212a85b9
@code_warntype unstable()

# ╔═╡ 53af6951-2a42-469a-abc0-f49bb6b5a969
md"""
## Avoid Working in Global Space - Use Functions instead!

* all performance cricitcal code to be placed inside functions.
"""

# ╔═╡ 19afe93e-b1e5-44b4-af94-01ae97c64281
md"""
#

Why is that? Well, because the type of `z` can change at any point. look: 👀
"""

# ╔═╡ fa3e04ea-f7f2-49ea-a1d0-a5b19baff3c3
begin
	z = 1
	println("now z is $z, of type $(typeof(z))")
	z = "what?"
	println("now z is $z, of type $(typeof(z))")
end

# ╔═╡ eaa7520e-8291-490d-8c4d-6e405f49ce58
md"""
#

in other words, the compiler can't rely on any type remaining the same. 😞 
Let's try this out. 
"""

# ╔═╡ be553fa2-366f-4043-8fe1-20207e21643e
md"""
```julia
x1, y1 = rand(1000), rand(1000)
global a = 0.0 # need `global` here for @benchmark

bbad = @benchmark for i in 1:length(x1)
    global a += x1[i]^2 + y1[i]^2
end


function localf(x, y)
    a = zero(eltype(x))
    for i in 1:length(x)
        a += x[i]^2 + y[i]^2
    end
    return a
end

bgood = @benchmark localf(x1,y1)

judge(median(bbad), median(bgood))
```
"""

# ╔═╡ ac59696f-8085-43d3-b348-05eb7a99a352
md"""
🤯
"""

# ╔═╡ 12feebe1-c7e6-433a-bda5-d3f6cb18eabf
md"""
#
"""

# ╔═╡ d4ab1138-e8da-4111-8259-0d37c5fd5e22
md"""
## Pre-allocate Output

* If you can, it may be a good idea to pre-allocate an output array.
* Particularly, if you have to call a function many times over.
* Let's look simple matrix multiplication. In a first function, we return a *new matrix* (the result) each time, in the second version, we prepared an output array *to write into*:
"""

# ╔═╡ 1d5fe023-6bd7-480e-99f1-b8b362e33f4c
md"""
#
"""

# ╔═╡ 313f2ffb-440b-45f7-a5ef-f295db73c45e
begin
	# version 1: 
	function randmul(n)
	    A = fill(rand(), n, n); B = fill(rand(), n, n)
	    return sum(A*B)  # first creates a new temp matrix, then sums over it
	end
	
	# version 2: all matrices pre-allocated
	function randmul!(C, A, B)
	    fill!(A, rand()); fill!(B, rand())
	    mul!(C, A, B)
	    return sum(C)
	end
end


# ╔═╡ 941d5692-ee65-423f-bd33-4683664e55ee
md"""
#
"""

# ╔═╡ d34cc463-127a-46eb-95a1-a0e250eeea8f
begin
	n = 100;
	A = fill(rand(), n, n)
	B = copy(A); C = copy(A);

	(randmul(n), randmul!(C, A, B)) # trigger compilation
end

# ╔═╡ 5388eb5d-ecc0-4e0b-90f8-0ca4d275f4fd
abad = @benchmark randmul($n)

# ╔═╡ a02f7f5e-4fad-4cea-8543-f997de8a21a3
md"""
#
"""

# ╔═╡ f72f2b7c-1932-49cc-8fb2-43ac0849e0d7
agood = @benchmark randmul!($C, $A, $B)

# ╔═╡ c304ea03-5e69-47ed-ba13-93f9c9494a41
md"""
#
"""

# ╔═╡ 26e581f4-6c89-4cd7-812e-ab28be0cf99c
judge(median(abad), median(agood))

# ╔═╡ 9320ee4a-3626-4d38-ab08-d267d28c9e95
md"""
#
"""

# ╔═╡ 1fdc3d69-3fb1-4e4f-9825-08945e06df7f
begin
	q(text) = Markdown.MD(Markdown.Admonition("tip", "Question", [text]));
	info(text) = Markdown.MD(Markdown.Admonition("info", "Info", [text]));
	danger(text) = Markdown.MD(Markdown.Admonition("danger", "Caution", [text]));
end

# ╔═╡ ea997773-7453-4227-bf94-7e89274ae15e
info(md"""The manual section on [performance tips](https://docs.julialang.org/en/v1/manual/performance-tips/) is a great place to look for more on performance issues. Also, use [stackoverflow](https://stackoverflow.com/questions/tagged/julia) and the [julia discourse forum](https://discourse.julialang.org/) to post issues with your code not performing well. People are very helpful.
"""
)

# ╔═╡ 1c26b7de-fc29-49e4-9a6e-fc25d08e3f76
danger(md"That is $(round((j.ratio.time-1)*100,digits = 2))% slower!")

# ╔═╡ 768f5bee-44fc-4f38-9e90-00713ec397f0
info(md"""
the `@code_warntype` macro is your friend!
""")

# ╔═╡ 83055867-8b4b-4054-9a23-2105c38341c3
danger(md"**Evertying** in global scope is type instable!")

# ╔═╡ c733ac51-adbe-4d79-8ddb-07417b6b19f9
q(md"""
* Use the `ProfileView.jl` package to profile this function:
```julia
function profile_test(n)
    for i = 1:n
        A = randn(100,100,20)
        m = maximum(A)
        Am = mapslices(sum, A; dims=2)
        B = A[:,:,5]
        Bsort = mapslices(sort, B; dims=1)
        b = rand(100)
        C = B.*b
    end
end
```
* Create a `.jl` file in VScode, and put `using Profile, using ProfileView` on top
* install the `ProfileView` package
* trigger compilation by calling `profile_test(1)` once.
* look at the text output of `@profile profile_test(10)`
* finally, call `ProfileView.@profview profile_test(10)` and look at the external window with the *flame graph* in it.
""")

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
AbstractTrees = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
AbstractTrees = "~0.3.4"
BenchmarkTools = "~1.3.0"
PlutoUI = "~0.7.34"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.3"
manifest_format = "2.0"
project_hash = "b277b6b195ccaf690f21f4783220f8f2fb15b18d"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.AbstractTrees]]
git-tree-sha1 = "03e0550477d86222521d254b741d470ba17ea0b5"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.3.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Profile", "Statistics", "UUIDs"]
git-tree-sha1 = "d9a9701b899b30332bbcb3e1679c41cce81fb0e8"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.3.2"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.MIMEs]]
git-tree-sha1 = "1833212fd6f580c20d4291da9c1b4e8a655b128e"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.0.0"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"

    [deps.Pkg.extensions]
    REPLExt = "REPL"

    [deps.Pkg.weakdeps]
    REPL = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "7e71a55b87222942f0f9337be62e26b1f103d3e4"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.61"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.Profile]]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

    [deps.Statistics.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

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
version = "1.11.0"

[[deps.Tricks]]
git-tree-sha1 = "6cae795a5a9313bbb4f60683f7263318fc7d1505"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.10"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─0339da02-4ee2-40a6-b25f-0955f25aacd9
# ╟─9deadd22-8766-11ec-3432-5f61ec091f16
# ╟─a91e6f40-54e3-4ed9-af97-923068ab7ff1
# ╟─87f1838d-1630-4e38-928a-50e6c032eeb8
# ╟─a6dbe781-9db9-4804-8341-e5203ebfa5fe
# ╟─ea997773-7453-4227-bf94-7e89274ae15e
# ╟─dc10db9a-d42e-4823-9a84-dfcae53cf2f9
# ╟─b290c05d-e77f-486c-b32a-b8e366b98d9f
# ╠═a7023bf2-91c8-40dc-ae4d-6baaafe92522
# ╠═16dd0736-6f1b-422f-93c2-10a96ba70177
# ╠═80ac3661-2b10-4194-aa95-27c86bad05ce
# ╠═8aa13a67-812e-4440-bb5a-92ad6bae8ef9
# ╟─4e6afdd5-2c8d-45d2-99ba-ee7ddfbac6f1
# ╟─06924d26-8f65-4288-a437-29209a736411
# ╠═f519847f-2fde-4c35-b6bf-b1306723e45c
# ╠═1b73ff00-b46f-4315-b9ba-88a4ec5ccb30
# ╟─6869e39f-cf70-4762-963f-42a4eb2fa72b
# ╟─a9573443-1c99-4318-ad04-932698a1e519
# ╠═5a55126a-1193-4650-883d-5ee43df1b012
# ╟─70d961ec-ef48-4da1-ada1-c4a480efab18
# ╠═9fc6575d-fab6-4b51-8160-53a70a875ac5
# ╟─241852b8-5d82-4666-936d-49520a0d24cd
# ╠═222db2b2-de06-4283-ae16-4a32c8dc7f8c
# ╟─57c5bce7-7a96-41a6-a8ed-79aba5fbf795
# ╠═d2feab8e-c56a-4ae6-bafd-560c82b7d52d
# ╠═ac9352d5-b6e3-4e84-b07c-316b18dc809d
# ╟─6a17e7b7-f6b5-4108-a655-c20351c3475c
# ╠═61f80625-140d-4e4f-8a1e-8860b8d56da6
# ╟─1c26b7de-fc29-49e4-9a6e-fc25d08e3f76
# ╟─4a6ece68-f74c-4309-94bb-991e1da83295
# ╟─768f5bee-44fc-4f38-9e90-00713ec397f0
# ╠═28672e20-a27c-4157-a61b-0e1f212a85b9
# ╟─53af6951-2a42-469a-abc0-f49bb6b5a969
# ╟─83055867-8b4b-4054-9a23-2105c38341c3
# ╟─19afe93e-b1e5-44b4-af94-01ae97c64281
# ╠═fa3e04ea-f7f2-49ea-a1d0-a5b19baff3c3
# ╟─eaa7520e-8291-490d-8c4d-6e405f49ce58
# ╟─be553fa2-366f-4043-8fe1-20207e21643e
# ╟─ac59696f-8085-43d3-b348-05eb7a99a352
# ╟─12feebe1-c7e6-433a-bda5-d3f6cb18eabf
# ╟─d4ab1138-e8da-4111-8259-0d37c5fd5e22
# ╟─1d5fe023-6bd7-480e-99f1-b8b362e33f4c
# ╠═313f2ffb-440b-45f7-a5ef-f295db73c45e
# ╟─941d5692-ee65-423f-bd33-4683664e55ee
# ╠═d34cc463-127a-46eb-95a1-a0e250eeea8f
# ╠═5388eb5d-ecc0-4e0b-90f8-0ca4d275f4fd
# ╟─a02f7f5e-4fad-4cea-8543-f997de8a21a3
# ╠═f72f2b7c-1932-49cc-8fb2-43ac0849e0d7
# ╟─c304ea03-5e69-47ed-ba13-93f9c9494a41
# ╠═26e581f4-6c89-4cd7-812e-ab28be0cf99c
# ╟─9320ee4a-3626-4d38-ab08-d267d28c9e95
# ╟─c733ac51-adbe-4d79-8ddb-07417b6b19f9
# ╟─1fdc3d69-3fb1-4e4f-9825-08945e06df7f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
