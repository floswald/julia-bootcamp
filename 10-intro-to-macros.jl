### A Pluto.jl notebook ###
# v0.19.22

using Markdown
using InteractiveUtils

# ╔═╡ 886a7170-7d07-11eb-3b3f-572614aaa162
md"

# What are macros?

Julia Bootcamp, Florian Oswald
"

# ╔═╡ 80b2135e-f1ed-11ea-17ee-656b8062026a
md"""
**Macros** change the syntax of parts of a program.

While functions work on values, a macro works on a **piece of Julia code**, which is represented as a data structure in Julia itself, and **rewrites it to a different piece of code**! This can be a very powerful thing to do.

We should notice that macros operate at the [Abstract Syntax Tree](https://en.wikipedia.org/wiki/Abstract_syntax_tree) level. That means

* Before code is actually *executed*, but
* After code is *parsed* (i.e. **read from user-provided text**)


"""

# ╔═╡ 7acec72a-f1fa-11ea-2753-efcf2cee8335
md"""

#

As a simple example, let's look at the macro called `@elapsed`, which measures how much time it takes to run a piece of code.

It does this by taking the input expression and adding extra code around it.

First let's see it in action! We'll use a function that takes some time to run: the function `peakflops()` estimates how fast your computer runs. (It reports an estimate of the number of flops, i.e. floating-point operations per second, when doing matrix multiplications.)
"""

# ╔═╡ e849259c-7d06-11eb-209d-81df1985eff8
md"
#

"

# ╔═╡ 0f7c908c-f1fb-11ea-18fb-c7e70278ec46
peakflops()

# ╔═╡ f43139a2-f1ed-11ea-0cdf-678ffac4374a
@elapsed peakflops()

# ╔═╡ 67b3fb78-f1ee-11ea-2d0a-a92e81580917
md"""
**NOTE:** a macro is always called using the `@` prefix character; this is a visual cue that the following piece of code is *not what is actually executed*, but rather is *transformed in some way*.
"""

# ╔═╡ 5677f2d6-f1ee-11ea-3f9b-b59c8a8d07ff
md"""

# Looking Inside Macros 

You can look at the transformed expression by using `@macroexpand`. Since this name begins with `@`, we can see that this is actually itself a macro!
"""

# ╔═╡ 4b2cbfc4-f1ee-11ea-17d6-a72fd22e6d89
@macroexpand @elapsed peakflops()

# ╔═╡ c4e4e402-f1fa-11ea-3e5e-4344dcc7e17b
md"

#

Let's remove the line number information:"

# ╔═╡ 9639e822-f1ee-11ea-19b6-5f377bb4b809
Base.remove_linenums!( @macroexpand @elapsed peakflops() )

# ╔═╡ ea65d68c-f1fa-11ea-1cde-ebf4b7958b8a
md"We see that the macro has added more code around the original `peakflops()` call.
Julia *replaces* the original code by the new code; this new code is what will actually be used (compiled)."

# ╔═╡ a5816132-f1ee-11ea-268b-05086212324b
md"""
Here, the `remove_linenums!` function actually receives a Julia **expression** as its argument.
"""

# ╔═╡ db54c43a-d821-4614-b649-5549a62a749e
md"""
## Why Macros and not Functions?

* another important macro is the `@time` macro - similar in spirit to the above example.
* We would do `time 1+2`

You may want to ask

> But why don't we just write a function `time(1 + 2)` instead?

👉 The problem here is that we would have to evaluate the expression `1 + 2` *before* we call the `time()` function, so this would not be a great way to measure the time it took to evaluate `1 + 2` - which is what we actually wanted.

👉 Macro use cases are all of this kind: you want to do something *with* a piece of code before its being executed - transform it in some kind of way. Very important in data processing pipelines, for instance with

1. [Tidier.jl](https://github.com/kdpsingh/Tidier.jl) or
2. [DataFramesMeta.jl](https://juliadata.github.io/DataFramesMeta.jl/stable/)
"""

# ╔═╡ e3bd8fbc-f1fa-11ea-331f-bbe8f038f46a
md"

# Expressions in Julia"

# ╔═╡ cb5e6a8a-f1fb-11ea-2f15-e7486afdfa4a
md"One feature that makes Julia powerful is its ability (influenced by the Lisp language) to represent Julia code as Julia objects, which can be manipulated using the usual Julia features.
"

# ╔═╡ faa18946-f1fb-11ea-0f5b-290683f29ebf
md"Let's look at some simple expressions.

If we type an expression, Julia will **evaluate** it and return its value:
"

# ╔═╡ c5465fe0-f1ee-11ea-2f61-3172509f693d
x = 1 + 2

# ╔═╡ 6bb8d276-f1ff-11ea-2ada-1916761bc6a8
md"

#

The variable `x` now contains the value `3`, the result of evaluating the expression `1 + 2`."

# ╔═╡ 10d909b4-f1fc-11ea-080a-f9f87b3512c5
md"We can prevent Julia from evaluating an expression by **quoting** it, which we can do in one of two ways:"

# ╔═╡ c88dfe88-f1ee-11ea-0327-8b18a25c511c
expr = :(1 + 2)

# ╔═╡ 80ec2c30-f1ff-11ea-30ea-ef5dd01e26ae
expr2 = quote
			1 + 2
		end

# ╔═╡ 60778b00-f1ff-11ea-011f-231f3ab18de1
md"This *leaves the expression alone, without evaluating it*, giving as result the unevaluated expression. This is a Julia object of type `Expr` that we have not seen before:"

# ╔═╡ bdb08e52-f1ff-11ea-1881-4bb2bb3f5c77
typeof(expr)

# ╔═╡ 6a0fdfc8-f637-11ea-04d8-a55a4c42df3e
md"

#

As an example, we can create the following expression:"

# ╔═╡ cbce40ee-f1ee-11ea-2e05-1d523acbf8b9
expr3 = :(y + 1)

# ╔═╡ 7f1cad88-f637-11ea-1cf2-4d5b9a4fb50f
md"If we evaluate this expression, it gives an error, since there is no variable `y` in the current notebook:"

# ╔═╡ 906e3234-f637-11ea-1f77-679dc897ec69
eval(expr3)

# ╔═╡ 61c5a0da-d8ad-4f5a-bae0-463783e6666b
md"""
Notice, however, that `expr2` runs, since that only requires to `eval` the expression `1 + 2`:
"""

# ╔═╡ 2ee4e1c5-4b07-45e3-95ba-688c4dcfa9d9
eval(expr2)

# ╔═╡ 940f888c-f637-11ea-20a0-1ddda8fb7908
md"

#

Since expressions are Julia objects, we can examine them using Julia's usual mechanisms. For example, the `dump` function allows us to inspect the fields inside an object:"

# ╔═╡ 77437eaa-f639-11ea-0c4d-3756cbd589da
dump(expr3)

# ╔═╡ 8dab58d4-f639-11ea-1b0b-536927639c6c
md"

#

We can extract the fields inside the object:"

# ╔═╡ 3ef16efa-7d08-11eb-1a1a-bf3efcbcdb78
expr4 = :(y + 1)

# ╔═╡ e46e6c96-f1ee-11ea-3e7f-4f613282ccb1
expr4.head

# ╔═╡ e631bede-f1ee-11ea-0fab-7516ab535cf5
expr4.args

# ╔═╡ 95cf0d76-f639-11ea-34dc-f32852ac32b8
md"

#

and even modify them:"

# ╔═╡ 9a587ba4-f639-11ea-2bef-37fed4d45a7f
expr4.args[2]

# ╔═╡ 9cd4334e-f639-11ea-26c6-e9782451ef02
expr4.args[2] = :x

# ╔═╡ a037391e-f639-11ea-2723-455ccff4b024
md"(`:x` and `:y` here are `Symbol`s, a special type of string.)"

# ╔═╡ b6e67c1a-f639-11ea-3abe-f75671ed4ca2
expr4

# ╔═╡ 111ce380-7d97-11eb-0b9f-3fa5aebf369e
eval(expr4)

# ╔═╡ cb0cb434-f639-11ea-1ea2-93009c372885
md"We see that we have been able to *modify the `Expr` object, which is a piece of Julia code, using Julia itself! This is the simplest example of **metaprogramming**, i.e. writing a program that modifies another *program* (instead of modifying data).

This is what macros do internally: transform Julia expressions into something else.
"

# ╔═╡ 0ff6e154-f1ef-11ea-2ee8-61eb98523642
md"""
# Conclusion

When we see something like `@foo`, we recognise that it's a **syntactic transformation** and may modify the behavior of the language in some way!

Being able to represent Julia code within Julia is very useful, and hence we frequently see macros and expression manipulation being used in Julia code.
"""

# ╔═╡ aa3a731c-f637-11ea-3afc-9144bdeb7d6f
md"## Function library"

# ╔═╡ Cell order:
# ╟─886a7170-7d07-11eb-3b3f-572614aaa162
# ╟─80b2135e-f1ed-11ea-17ee-656b8062026a
# ╟─7acec72a-f1fa-11ea-2753-efcf2cee8335
# ╟─e849259c-7d06-11eb-209d-81df1985eff8
# ╠═0f7c908c-f1fb-11ea-18fb-c7e70278ec46
# ╠═f43139a2-f1ed-11ea-0cdf-678ffac4374a
# ╟─67b3fb78-f1ee-11ea-2d0a-a92e81580917
# ╟─5677f2d6-f1ee-11ea-3f9b-b59c8a8d07ff
# ╠═4b2cbfc4-f1ee-11ea-17d6-a72fd22e6d89
# ╟─c4e4e402-f1fa-11ea-3e5e-4344dcc7e17b
# ╠═9639e822-f1ee-11ea-19b6-5f377bb4b809
# ╟─ea65d68c-f1fa-11ea-1cde-ebf4b7958b8a
# ╟─a5816132-f1ee-11ea-268b-05086212324b
# ╟─db54c43a-d821-4614-b649-5549a62a749e
# ╟─e3bd8fbc-f1fa-11ea-331f-bbe8f038f46a
# ╟─cb5e6a8a-f1fb-11ea-2f15-e7486afdfa4a
# ╟─faa18946-f1fb-11ea-0f5b-290683f29ebf
# ╠═c5465fe0-f1ee-11ea-2f61-3172509f693d
# ╟─6bb8d276-f1ff-11ea-2ada-1916761bc6a8
# ╟─10d909b4-f1fc-11ea-080a-f9f87b3512c5
# ╠═c88dfe88-f1ee-11ea-0327-8b18a25c511c
# ╠═80ec2c30-f1ff-11ea-30ea-ef5dd01e26ae
# ╟─60778b00-f1ff-11ea-011f-231f3ab18de1
# ╠═bdb08e52-f1ff-11ea-1881-4bb2bb3f5c77
# ╟─6a0fdfc8-f637-11ea-04d8-a55a4c42df3e
# ╠═cbce40ee-f1ee-11ea-2e05-1d523acbf8b9
# ╟─7f1cad88-f637-11ea-1cf2-4d5b9a4fb50f
# ╠═906e3234-f637-11ea-1f77-679dc897ec69
# ╟─61c5a0da-d8ad-4f5a-bae0-463783e6666b
# ╠═2ee4e1c5-4b07-45e3-95ba-688c4dcfa9d9
# ╟─940f888c-f637-11ea-20a0-1ddda8fb7908
# ╠═77437eaa-f639-11ea-0c4d-3756cbd589da
# ╟─8dab58d4-f639-11ea-1b0b-536927639c6c
# ╠═3ef16efa-7d08-11eb-1a1a-bf3efcbcdb78
# ╠═e46e6c96-f1ee-11ea-3e7f-4f613282ccb1
# ╠═e631bede-f1ee-11ea-0fab-7516ab535cf5
# ╟─95cf0d76-f639-11ea-34dc-f32852ac32b8
# ╠═9a587ba4-f639-11ea-2bef-37fed4d45a7f
# ╠═9cd4334e-f639-11ea-26c6-e9782451ef02
# ╟─a037391e-f639-11ea-2723-455ccff4b024
# ╠═b6e67c1a-f639-11ea-3abe-f75671ed4ca2
# ╠═111ce380-7d97-11eb-0b9f-3fa5aebf369e
# ╟─cb0cb434-f639-11ea-1ea2-93009c372885
# ╟─0ff6e154-f1ef-11ea-2ee8-61eb98523642
# ╟─aa3a731c-f637-11ea-3afc-9144bdeb7d6f
