# `Julia` Bootcamp (for Economists)     

<p align="center"> <a href="https://floswald.github.io/julia-bootcamp/">:balloon: <b>Go to online notebooks</b> :balloon:</a></p>


This is an 8-hours crash course to get going with the julia computing language. 

> It says in the title *for Economists*, but that's mainly because I am one myself, and people in the profession asked me to teach this course; That said, you don't need any specific economics knowledge for this course.

## Organization

We have 8 blocks of one hour each. Each block will be interrupted several times along the way to check whether what I just said makes sense to you, and to allow you to formulate questions. 


## session 1

The first session we will do freestyle, in terminal and VScode. then we will switch to notebooks. 

> Notice that the notebooks are visible online at [https://floswald.github.io/julia-bootcamp/](https://floswald.github.io/julia-bootcamp/). You will need those during the questions in class!

<p align="center"><a href="https://floswald.github.io/julia-bootcamp/">:balloon: <b>Go to online notebooks</b> :balloon:</a></p>


* installing julia
* installing vscode and julia extension
  * in vscdoe, shift-cmd-p for command palette, then type *shell command*
* customize the julia startup file at `~/.julia/config/startup.jl`
  * sticky shell mode
  * set vscode as standard editor

### How to run julia

* running julia as standalone app
* running julia inside vscode
* starting julia from the command line
* important locations and directories, different julia versions, etc

### Working with the REPL

* working with the REPL
    * help mode: find `max` help and compute the maximum over numbers `3,5,10`
    * help mode: find `ifelse` function and run `ifelse(3 < 5, 3,5)`
    * do `@edit max(3,5)` and look at source code
    * println function hello world
* running a file in vscode: 01.jl
* `include` function: 01.jl
* workflows for modules: https://docs.julialang.org/en/v1/manual/workflow-tips/#A-basic-editor/REPL-workflow
* assigning a variable. standard, unicode, maths

### Julia Packages

* What are packages? In words.
* How to install? Whose package? Where from? 
* Different package versions and environments. the `Project.toml` file.
* installing a package: distributions
    * create file 02.jl, say you want to use the Distributions package and create a normal distribution with `n = Normal(1.0,0.5)`. 
    * look at `?quantile` (last entry) and `?pdf` and finally compute the value of the pdf at the 0.95 quantile of your distribution `n`


## notebooks

1. assigning varialbes
1. arrays
2. datatypes
1. functions and programming constructs
2. performance
3. plotting
4. interactive plotting and dashboards
5. Dataframes (to be added) ; https://dataframes.juliadata.org/stable/

## Homeworks

I will not give you any homeworks, however, you may want to practice a bit more. I have several fully worked homeworks on my course website, which you could have a go at if you wanted.
1. [Lockdown in a SIR model](https://floswald.github.io/NumericalMethods/hw1/)
1. [Spatial epidemic model](https://floswald.github.io/NumericalMethods/hw2/)
1. [Probit Estimator](https://floswald.github.io/NumericalMethods/hw3/)
1. [Portfolio Choice Problem](https://floswald.github.io/NumericalMethods/hw5/)

## day 2
* computing a value function in parallel: https://www.sas.upenn.edu/~jesusfv/Guide_Parallel.pdf and https://github.com/floswald/Parallel_Computing/tree/master

## Other Cool Things I won't talk about

There are too many. Let me try with a quick list:

* https://fluxml.ai/
* https://jump.dev/
* https://makie.juliaplots.org/stable/ and https://lazarusa.github.io/BeautifulMakie/
* https://turing.ml/stable/
* https://julia.quantecon.org/intro.html
* all free courses at https://juliaacademy.com/



## Where did I teach this course?

1. University of Barcelona
2. Bocconi (Parts of it)
3. SciencesPo (Parts of it)


## Resources

I used examples and got inspiration from several excellent tutorials out there to build this boot camp:

* [Think Julia](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html) by @benlauwens is fully comprehensive and *very complete* intro to julia, which I highly recommend.
* [The Julia Express](http://bogumilkaminski.pl/files/julia_express.pdf) by @bkamins is a much condensed version - great for a quick start.
* [From Zero to Hero](https://github.com/Datseris/Zero2Hero-JuliaWorkshop) by @datseris is a great tutorial series, bit more advanced but great insights for beginners as well.

Have a look at the [dedicated section](https://julialang.org/learning/) on the julialang website for more great material!
