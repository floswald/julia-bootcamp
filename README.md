# `Julia` Bootcamp (for Economists)

This is an 8-hours crash course to get going with the julia computing language. 

> It says in the title *for Economists*, but that's mainly because I am one myself, and people in the profession asked me to teach this course; That said, you don't need any specific economics knowledge for this course.

## Organization

We have 8 blocks of one hour each. Each block will be interrupted several times along the way to check whether what I just said makes sense to you, and to allow you to formulate questions. 

short topics

* installing julia
* installing vscode
* workflows for modules: https://docs.julialang.org/en/v1/manual/workflow-tips/#A-basic-editor/REPL-workflow
* running julia as standalone app
* running julia inside vscode
* working with the REPL
    * help mode: find `max` help and compute the maximum over numbers `3,5,10`
    * help mode: find `ifelse` function and run `ifelse(3 < 5, 3,5)`
    * do `@edit max(3,5)` and look at source code
    * println function hello world
* running a file in vscode: 01.jl
* `include` function: 01.jl
* assigning a variable. standard, unicode, maths

* data types
    * basic built-in types
        * conversions
    * tuples
    * arrays
        cliboard data from browser
    * Composite Types
    * Dictionaries
    * strings
* installing a package: distributions
    * create file 02.jl, say you want to use the Distributions package and create a normal distribution with `n = Normal(1.0,0.5)`. 
    * look at `?quantile` (last entry) and `?pdf` and finally compute the value of the pdf at the 0.95 quantile of your distribution `n`
* type `varinfo()`
* functions
    * functions for types: multiple dispatch
    * methods
* 
* arrays
* plotting


## day 2
* computing a value function in parallel


## Who is this course for?

## Where did I teach this course?

1. University of Barcelona
2. Bocconi (Parts of it)
3. SciencesPo (Parts of it)


## Resources

I used examples and got inspiration from several excellent tutorials out there to build this boot camp:

* [Think Julia](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html) by @benlauwens is fully comprehensive and *very complete* intro to julia, which I highly recommend.
* [The Julia Express](http://bogumilkaminski.pl/files/julia_express.pdf) by @bkamins is a much condensed version - great for a quick start.
* [From Zero to Hero](https://github.com/Datseris/Zero2Hero-JuliaWorkshop) by @datseris is a great tutorial series, bit more advanced but great insights for beginners as well.

Have a look at the [dedicated section](https://julialang.org/learning/) on the julialang website for more great material!
