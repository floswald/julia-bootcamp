### A Pluto.jl notebook ###
# v0.17.7

using Markdown
using InteractiveUtils

# ╔═╡ 88b27144-068b-42ed-b4b0-d12f5ca8c53c
using PlutoUI

# ╔═╡ 91562a82-8741-11ec-1332-7db3016c8b30
md"""
# Julia Bootcamp - Programming Constructs

Florian Oswald 2021

> Iteration, Loops, and Functions
"""

# ╔═╡ 8424693a-4445-4309-ba54-549ba861838b
md"""
We have seen how we can assign a variable already:
"""

# ╔═╡ a28fea67-89e7-452d-96b5-ee94efd14217
y = 5

# ╔═╡ 4fd7c57b-b579-49a6-84dc-06869cdf8b64
md"""
We can be more elaborate and assign multiple variables with a `begin...end` block:
"""

# ╔═╡ a16ca545-83be-4ef3-8946-4e79012042f3
y2 = begin
	b = 3
	a = 2
	a * b - 12
end

# ╔═╡ 05eda001-588f-49e0-b589-a22a6195994e
b

# ╔═╡ b780b7ed-7b0c-4464-a8aa-23b3a4180f64
y2

# ╔═╡ bb502134-a506-4c86-898b-f84a74f0c1a5
md"""
## Loops

Like all julia syntax which introduces a local scope (i.e. a region where local variables can be defined, and used), a standard `for` loop ends with the `end` keyword:

```julia
for itervar in iterable
	# the loop body:
    # do stuff with itervar
	g(itervar)  # for example
    # itervar only exists inside this loop!
end
```
"""

# ╔═╡ d25a2c47-04f1-482a-8e3e-0f1bbc1ac14e
md"""
For example, run this loop in your terminal (You don't have to worry about the `with_terminal() do ... end` stuff, that's just for me inside this Pluto notebook). You just copy this:

```julia
for n ∈ 1:3
	println(n)
end
```
"""

# ╔═╡ a07bbc3f-1c2d-47fe-a1b4-46929e963d72
md"""
here is me inside Pluto (I have to *simulate* what the terminal looks like if I want to print stuff to it - don't worry about this, Pluto is awesome.)
"""

# ╔═╡ 77cbaffd-9ded-4032-8670-bf0d64ff701c
with_terminal() do
	for n ∈ 1:3
		println(n)
	end
end

# ╔═╡ b88de86f-f510-4c5c-a52c-5e66fb27d517
md"""
What's quite cool with julia iteration is that you can iterate over multiple things at once. Suppose we had this `Dict`:
"""

# ╔═╡ cf992726-f7d9-42f8-a0db-108861ebae8f
di = Dict(:a => 1.1, :b => 3.2)

# ╔═╡ a48694a3-7b90-4811-a860-0620b604bf77
with_terminal() do  # again, you don't need this...
	for (k,v) in di
		println("the key is $k, the value is $v")
	end
end  # ...and that

# ╔═╡ 142d25a9-e122-4253-8736-cdb10b123fc9
md"""
similarly, we have a standard *while* loop:
"""

# ╔═╡ 50ff9608-93b3-4181-b019-a20b587749dd
n = 0

# ╔═╡ ac4917fe-446a-40b1-a6ca-ba00e4428e40
n  # does not exist outside of the loop

# ╔═╡ ff25ba08-617e-487b-aa17-471942818e12
with_terminal() do
	while n < 4
		n += 1
		println(n)
	end
end

# ╔═╡ 6cdd5994-b881-47f4-add7-1b6ac7349c76
m = 4

# ╔═╡ b3b3b926-72ff-482a-900d-20a8a5595e6c
md"""
*if-else* constructs are very standard (never forget the `end` to close the block!)
"""

# ╔═╡ 681733ec-046d-49fe-ae65-ec36e7b62509
if m < 4
	md"m is less than 4"   # i use a Markdown string such that this shows in Pluto
else
	md"m is greater or equal 4"
end

# ╔═╡ b5274ca3-07d5-4340-ae5f-8609d0c190e0
md"""
We can have the terse *ternary* notation `condition ? if true : if false` as well:
"""

# ╔═╡ 4983b419-ca26-486a-a5ce-4af1901c625c
m < 4 ? md"m < 4 is true" :  md"m ≥ 4 is true"

# ╔═╡ 06101a96-097a-4cba-955a-a54ac48b24db
md"""
## Functions

* Very important in julia: put all your work inside functions. 
* The compiler will be able to properly optimize your code only if give it functions to analyse.

**Two ways** to define your own functions:
"""

# ╔═╡ 12024ae2-c9cd-45d9-9bda-305e69cd6054
function f(x)   # `function` keyword, function name (f), args (if any) enclosed in ()
	y = x ^ 2  # function body
	# again, a local scope: y only visible in here
	y  # by default, returns the last value
	   # or explicity with
	#    return(y)
end

# ╔═╡ 4de3eb6d-c728-4d8d-aa79-38b06a3292c7
f2(x) = x ^ 2  # same function, but shorter to define

# ╔═╡ 83ab78f0-6160-4f4d-aa5c-d1d7322461a9
md"""
We *execute* function (we *call* the function) by typing its name and supplying the required arguments (again, if any, otherwise empty `()`):
"""

# ╔═╡ c465539c-e923-480d-abc7-cc9206f8f49a
f(2)

# ╔═╡ fe13c7cd-bb36-450d-8865-08a53a915311
f(2) == f2(2)

# ╔═╡ 95261af6-ad68-4987-bbfc-0d0ed79adfe5
md"""
### Keyword and Positional Arguments

1. You can have multiple arguments by position
2. We can set default values for positional arguments 
3. We can give keyword arguments (difference to 2.: you **must** use the keyword in the function call)
"""

# ╔═╡ 7e63209b-1574-4439-b943-f18a5889ceb0
function g(x, y = 2; z = 3)
	x * y * z
end

# ╔═╡ bf892497-3d34-409f-a9ac-c6cba4874863
g(1)

# ╔═╡ 50976b94-ac8d-4c90-8f59-52c210ff96a1
g(1) == 1 * 2 * 3 # default values for y and z

# ╔═╡ 873ea764-5c10-4612-abe5-d5df3d4b9c85
g(1,3) == 1 * 3 * 3  # default z, y = 3

# ╔═╡ 7eda5b77-9cdd-4602-b906-1404b51989b1
g(1,3,z = 0) == 1 * 3 * 0  # y = 3, z = 0

# ╔═╡ 368d83da-92dc-4cf1-852f-8390550b6db0
md"""
notice that treating positional `y` like a keyword doesn't work, nor the other way around:
"""

# ╔═╡ ef29f3b5-0bef-4684-92c4-67e9a8f0f33d
g(1,y = 4)

# ╔═╡ 5a3802ff-85d9-4251-97f4-cca2cd00d332
g(1,3,10)

# ╔═╡ fb61fd7f-aabf-442b-a6c8-3077cb2e8207
md"""
---

We can return more than one values by returning a tuple (or any other container like a dict or an array):
"""

# ╔═╡ 2962bf2a-dbee-4ca7-b3e6-e9df1a2d0bb4
g2(x) = (x,x^2,x^3)

# ╔═╡ b1f4f5ef-5f56-4ee8-8def-5c87b71be658
g2(2)

# ╔═╡ 719682fd-9a6d-43e7-b8b4-ba6a27a6f500
function g3(x)
	Dict(:x => x, :xsquared => x^2, :xcube => x^3)
end

# ╔═╡ 3ab95641-080a-4d5d-84b6-4654e4900019
g3(2)

# ╔═╡ 6e4d8075-3303-4967-9a81-9d497bfd3068
md"""
### Duck-Typing

Julia will always use the most appropriate version (*method*) of a function. Notice that we didn't specify any particular input type for function `g` above. Let's try to give it a matrix:
"""

# ╔═╡ 9bfe0644-de15-4322-8bb0-31636e26afc1


# ╔═╡ 1b4be433-4e34-4b8c-91cd-7548e7377333
A = rand(2,2)

# ╔═╡ b2faa599-d962-4479-97b9-98aacac6c209
g(A)

# ╔═╡ be3f68c9-72ea-436b-9c28-47f8857d71ea
g(A,A)

# ╔═╡ 99f45b26-1d42-44d4-8107-58454ad80b37
g(A,A, z = A)

# ╔═╡ 276d64cb-e27f-4bdb-a964-bcf36c9a46d9
md"""
Or a string!
"""

# ╔═╡ fe561c2c-fb7f-4e67-9e49-546041112c50
g("oh ","my ", z = "word!")

# ╔═╡ 4524cc39-4d8f-4496-b0d1-8302c5614f47
md"""
All of those worked because the function `*` is defined for Floats (simple multiplication), conformable matrices (matrix multiplication), and strings (concatenate). Look at that:
"""

# ╔═╡ 679a6875-44a4-4e7d-85cc-f5ea90ead8ff
g(2,"oh")  # oh. that does not work, because see above...

# ╔═╡ 5d85f558-1b4e-4be7-a530-72a6705f58ec
md"""
So that's kind of interesting. There are all of these *methods* of the function `*` around, and depending on what input you give, it will do different things. This is a first preview of a core julia concept called 

> Multiple Dispatch: A function `f` can be *specialized* for certain input types.
"""

# ╔═╡ 1d68be68-1064-425b-baaf-da76ec7af76a
md"""
### Argument Passing Behaviour

* Julia passes arguments to functions *by reference*
* In particular, if what we give is a **mutable** object (like an array, for example), then the function changes to supplied object *in the caller*!
* This is quite cool, because we can modify objects *in-place* : think about a large array. It would be expensive to copy all the data from the caller into the function, do the job, then copy all the data back into the caller. Much better: leave the data where it is (in the caller), *modify it* as required in the function body, and copy nothing back and forth!
"""

# ╔═╡ 2bfaffab-300b-467d-95c9-f0b81d66c231
function addtofirst!(x,y)
	x[1] += y  
	return nothing # not required, but clearer
end

# ╔═╡ ccb84f7e-b76f-4797-978a-ce670b0a13f6
v = ones(4) # a mutable object: an array

# ╔═╡ 09a05e9f-1ee0-4364-b835-ffe8ab510afd
addtofirst!(v,2)

# ╔═╡ 36df9bd8-a924-4107-b9c2-e04d2db4ea28
v

# ╔═╡ 1d3b4411-0eeb-4f6e-bc0e-7f9b493885f5
md"""
By convention, we add a `!` to the end of the function name to signal that our function will *modify* the first given argument (`x` in the definition), usually *not returning anything*. 

There are many built-in functions like that, often with two versions: 
1. one version that *makes a copy and returns a new object*
2. another version that does the same operation *in-place*:
"""

# ╔═╡ 725ba4ba-95ea-4d07-b7da-206784ba6ab6
v2 = sort(v)  # v2 is a new array

# ╔═╡ 17af5ec9-3713-489b-abd7-437cb0fac71c
sort!(v)   # that's the same v

# ╔═╡ c4ab1742-9e0c-41f1-8a3a-762eb3757a93
md"""
in particular, `v` here occupies the same *memory address on your computer* as it did when we created it above! Look at that:
"""

# ╔═╡ 971a0406-d84f-44ee-be02-9675328bd790
v2 == v   # look at the help for == vs === !

# ╔═╡ 2df8f30b-1798-49cd-957b-1aeb6f70fde3
v2 === v

# ╔═╡ 04edb9d7-7ddd-4e04-aa97-7daafc5a01e4
md"""
## Function Library
"""

# ╔═╡ b7960f1b-93ed-4bf5-85d5-3e37aa0297a4
tip(text) = Markdown.MD(Markdown.Admonition("tip", "Question", [text]));

# ╔═╡ 5d44a00b-8cb2-432b-a58b-01dd9bf72882
tip(md"Notice that julia says it defined *two* methods here! A *method* is a specific *version of a function*. Can you think of a reason for this here?")

# ╔═╡ 982c1fee-5f3e-45bf-97b5-443d00a25e2b
info(text) = Markdown.MD(Markdown.Admonition("info", "Info", [text]));

# ╔═╡ 5142b680-af06-4100-b355-3c900d0e6dcc
q(text) = Markdown.MD(Markdown.Admonition("tip", "Question", [text]));

# ╔═╡ bfdf1dfb-7f42-451c-8de3-36b1625398c6
q(md"""
Newton's square root algorithm says that in order to compute $\sqrt{a} , a> 0$ up to arbitrary precision, you start with *any* given estimate $x >0$ of $\sqrt{a}$, and then you update your guess via

$$x \leftarrow \frac{1}{2}\left(x + \frac{a}{x}\right)$$

you will very quickly find the correct result of $\sqrt{y}$. 

1. in a `.jl` file, define function `mysqrt_step(a,x)`, which returns the next guess for `x` as in the above formula.
2. Try out your function manually in the REPL to compute $\sqrt{4}$, by calling `mysqrt_step(4,6)`, and then repeatedly using the output of the function to replace the second argument (so, instead of the `6` you put what comes out of the function).
3. define a second function, `mysqrt(a,x; tol = 1e-8)`, which *iterates* on `mysqrt_step(a,x)` for *as long as the absolute distance* between two successive guesses for `x` is larger the value set in keyword argument `tol`. Make the function return a tuple `(x,iters)`, where `iters` is the number of iterations the function needed to converge to the true value.
4. Finally, 😓, write a function `sqrt_table()` which takes values for `a = 2:10`, and uses initial guesses `x = a^2`, and prints the output of `mysqrt(a,x)` to the following table, and onto your terminal. You want to get this output:
```
julia> sqrt_table()
 a     mysqrt       sqrt Iterations 
 2   1.414214   1.414214          6 
 3   1.732051   1.732051          7 
 4   2.000000   2.000000          8 
 5   2.236068   2.236068          8 
 6   2.449490   2.449490          9 
 7   2.645751   2.645751          9 
 8   2.828427   2.828427          9 
 9   3.000000   3.000000         10 
10   3.162278   3.162278         10 
```
Let me help you a bit to get that table output printed nicely. Here is what I did, which uses standard [formatted printing](https://docs.julialang.org/en/v1/stdlib/Printf/): the `%2s` would mean *2 string characters*, the `%10d` means 10 digits, the `\n` means *new line*, etc...

```julia
using Printf  # use the Printf package (built-in)
function sqrt_table()
    @printf("%2s %10s %10s %10s \n", "a", "mysqrt", "sqrt", "Iterations")
    for a in 2:10
        tmp = mysqrt(a,a^2)
        @printf("%2d %10f %10f %10d \n", a, tmp[1], sqrt(a), tmp[2])
    end
end
```
"""
)

# ╔═╡ 58974c53-3a1b-4df0-9465-6d9c1c032ace
info(title,text) = Markdown.MD(Markdown.Admonition("info", title, [text]));

# ╔═╡ 49ad6a05-78a4-44f4-a57d-71a75543d497
info("Summary",md"""

1. Positional arguments can have default values (like `y` here)
2. Keyword arguments **must be given with the keyword** when calling
3. Keyword arguments are given after a semicolon in the definition in a `name = value` fashion.
4. You can have as many (keyword) arguments as you want.
""")

# ╔═╡ c48f1189-ee68-42bb-85cb-0c759f8ff098
danger(text) = Markdown.MD(Markdown.Admonition("danger", "Caution", [text]));

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
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
# ╟─91562a82-8741-11ec-1332-7db3016c8b30
# ╠═88b27144-068b-42ed-b4b0-d12f5ca8c53c
# ╟─8424693a-4445-4309-ba54-549ba861838b
# ╠═a28fea67-89e7-452d-96b5-ee94efd14217
# ╟─4fd7c57b-b579-49a6-84dc-06869cdf8b64
# ╠═a16ca545-83be-4ef3-8946-4e79012042f3
# ╠═05eda001-588f-49e0-b589-a22a6195994e
# ╠═b780b7ed-7b0c-4464-a8aa-23b3a4180f64
# ╟─bb502134-a506-4c86-898b-f84a74f0c1a5
# ╟─d25a2c47-04f1-482a-8e3e-0f1bbc1ac14e
# ╟─a07bbc3f-1c2d-47fe-a1b4-46929e963d72
# ╠═77cbaffd-9ded-4032-8670-bf0d64ff701c
# ╠═ac4917fe-446a-40b1-a6ca-ba00e4428e40
# ╟─b88de86f-f510-4c5c-a52c-5e66fb27d517
# ╠═cf992726-f7d9-42f8-a0db-108861ebae8f
# ╠═a48694a3-7b90-4811-a860-0620b604bf77
# ╠═142d25a9-e122-4253-8736-cdb10b123fc9
# ╠═50ff9608-93b3-4181-b019-a20b587749dd
# ╠═ff25ba08-617e-487b-aa17-471942818e12
# ╠═6cdd5994-b881-47f4-add7-1b6ac7349c76
# ╟─b3b3b926-72ff-482a-900d-20a8a5595e6c
# ╠═681733ec-046d-49fe-ae65-ec36e7b62509
# ╠═b5274ca3-07d5-4340-ae5f-8609d0c190e0
# ╠═4983b419-ca26-486a-a5ce-4af1901c625c
# ╟─06101a96-097a-4cba-955a-a54ac48b24db
# ╠═12024ae2-c9cd-45d9-9bda-305e69cd6054
# ╠═4de3eb6d-c728-4d8d-aa79-38b06a3292c7
# ╟─83ab78f0-6160-4f4d-aa5c-d1d7322461a9
# ╠═c465539c-e923-480d-abc7-cc9206f8f49a
# ╠═fe13c7cd-bb36-450d-8865-08a53a915311
# ╟─95261af6-ad68-4987-bbfc-0d0ed79adfe5
# ╠═7e63209b-1574-4439-b943-f18a5889ceb0
# ╟─5d44a00b-8cb2-432b-a58b-01dd9bf72882
# ╠═bf892497-3d34-409f-a9ac-c6cba4874863
# ╠═50976b94-ac8d-4c90-8f59-52c210ff96a1
# ╠═873ea764-5c10-4612-abe5-d5df3d4b9c85
# ╠═7eda5b77-9cdd-4602-b906-1404b51989b1
# ╟─368d83da-92dc-4cf1-852f-8390550b6db0
# ╠═ef29f3b5-0bef-4684-92c4-67e9a8f0f33d
# ╠═5a3802ff-85d9-4251-97f4-cca2cd00d332
# ╟─49ad6a05-78a4-44f4-a57d-71a75543d497
# ╟─fb61fd7f-aabf-442b-a6c8-3077cb2e8207
# ╠═2962bf2a-dbee-4ca7-b3e6-e9df1a2d0bb4
# ╠═b1f4f5ef-5f56-4ee8-8def-5c87b71be658
# ╠═719682fd-9a6d-43e7-b8b4-ba6a27a6f500
# ╠═3ab95641-080a-4d5d-84b6-4654e4900019
# ╟─bfdf1dfb-7f42-451c-8de3-36b1625398c6
# ╟─6e4d8075-3303-4967-9a81-9d497bfd3068
# ╠═9bfe0644-de15-4322-8bb0-31636e26afc1
# ╠═1b4be433-4e34-4b8c-91cd-7548e7377333
# ╠═b2faa599-d962-4479-97b9-98aacac6c209
# ╠═be3f68c9-72ea-436b-9c28-47f8857d71ea
# ╠═99f45b26-1d42-44d4-8107-58454ad80b37
# ╠═276d64cb-e27f-4bdb-a964-bcf36c9a46d9
# ╠═fe561c2c-fb7f-4e67-9e49-546041112c50
# ╟─4524cc39-4d8f-4496-b0d1-8302c5614f47
# ╠═679a6875-44a4-4e7d-85cc-f5ea90ead8ff
# ╟─5d85f558-1b4e-4be7-a530-72a6705f58ec
# ╟─1d68be68-1064-425b-baaf-da76ec7af76a
# ╠═2bfaffab-300b-467d-95c9-f0b81d66c231
# ╠═ccb84f7e-b76f-4797-978a-ce670b0a13f6
# ╠═09a05e9f-1ee0-4364-b835-ffe8ab510afd
# ╠═36df9bd8-a924-4107-b9c2-e04d2db4ea28
# ╟─1d3b4411-0eeb-4f6e-bc0e-7f9b493885f5
# ╠═725ba4ba-95ea-4d07-b7da-206784ba6ab6
# ╠═17af5ec9-3713-489b-abd7-437cb0fac71c
# ╟─c4ab1742-9e0c-41f1-8a3a-762eb3757a93
# ╠═971a0406-d84f-44ee-be02-9675328bd790
# ╠═2df8f30b-1798-49cd-957b-1aeb6f70fde3
# ╟─04edb9d7-7ddd-4e04-aa97-7daafc5a01e4
# ╟─b7960f1b-93ed-4bf5-85d5-3e37aa0297a4
# ╠═982c1fee-5f3e-45bf-97b5-443d00a25e2b
# ╠═5142b680-af06-4100-b355-3c900d0e6dcc
# ╠═58974c53-3a1b-4df0-9465-6d9c1c032ace
# ╠═c48f1189-ee68-42bb-85cb-0c759f8ff098
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
