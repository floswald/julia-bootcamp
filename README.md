# `Julia` Bootcamp (for Economists)     

<p align="center"> <a href="https://floswald.github.io/julia-bootcamp/">:balloon: <b>Go to online notebooks</b> :balloon:</a></p>


This is an 8-hours crash course to get going with the [julia computing language](https://julialang.org). 

> It says in the title *for Economists*, but that's mainly because I am one myself, and people in the profession asked me to teach this course; That said, you don't need any specific economics knowledge for this course.

## Organization

We have 8 blocks of one hour each. Each block will be interrupted several times along the way to check whether what I just said makes sense to you, and to allow you to formulate questions. 


## Material

We did the first session freestyle, in terminal and VScode (see below). then we switched to notebooks. 

> Notice that the notebooks are visible online at [https://floswald.github.io/julia-bootcamp/](https://floswald.github.io/julia-bootcamp/). You will need those during the questions in class!

<p align="center"><a href="https://floswald.github.io/julia-bootcamp/">:balloon: <b>Go to online notebooks</b> :balloon:</a></p>

### Notebooks

You can either download the notebooks from the [website](https://floswald.github.io/julia-bootcamp/) to run locally, or you clone this repository - the notebooks are identical, so whatever you prefer.

1. assigning variables
1. arrays
2. datatypes
1. functions and programming constructs
2. performance
3. plotting
4. interactive plotting and dashboards


### Session 1

* installing julia
* installing vscode and julia extension
  * *Optionally* in vscdoe, shift-cmd-p for command palette, then type *shell command* to put `code` onto your `PATH` such that you can start it from the command line.
* *Optionally* customize the julia startup file at `~/.julia/config/startup.jl`
  * I put my `startup.jl` [here](snippets/startup.jl) into this repository for you to copy to `~/.julia/config/startup.jl` on your computer if you want.
  * It sets *sticky shell mode*: if you hit `;` in the julia REPL, it will switch to shell mode (so you are on your OS console). By default that switches back after your last shell command returns - not with *sticky* mode, where it will only switch back if you hit `backspace`.
  * set vscode as standard editor: when you use the `@edit` macro for instance, it will open vscode to look at the source code.

#### How to run julia

* running julia as standalone app
* running julia inside vscode
* starting julia from the command line
* important locations and directories, different julia versions, etc

#### Working with the REPL

* working with the REPL
    * help mode: find `max` help and compute the maximum over numbers `3,5,10`
    * help mode: find `ifelse` function and run `ifelse(3 < 5, 3,5)`
    * do `@edit max(3,5)` and look at source code
    * println function hello world
* running a file in vscode: [`01.jl`](snippets/01.jl)
* `include` function: [`01.jl`](snippets/01.jl)
* workflows for modules: https://docs.julialang.org/en/v1/manual/workflow-tips/#A-basic-editor/REPL-workflow
* assigning a variable. standard, unicode, maths

#### Julia Packages

* What are packages? In words.
* How to install? Whose package? Where from? 
* Different package versions and environments. the `Project.toml` file.
* installing a package: distributions
    * create file [`02.jl`](snippets/02.jl), say you want to use the Distributions package and create a normal distribution with `n = Normal(1.0,0.5)`. 
    * look at `?quantile` (last entry) and `?pdf` and finally compute the value of the pdf at the 0.95 quantile of your distribution `n`


## Homeworks and More Material

I have a more complete course, also more relevant for Economists, at [this website](https://floswald.github.io/NumericalMethods/). Maybe have a look there if you are looking for econ-specific applications. Another great place for such a search is by the way the [QuantEcon](https://julia.quantecon.org/intro.html) project by Perla, Sargent and Stachurski.

I will not give you any homeworks, however, you may want to practice a bit more. I have several fully worked homeworks on my course website, which you could have a go at if you wanted.
1. [Lockdown in a SIR model](https://floswald.github.io/NumericalMethods/hw1/)
1. [Spatial epidemic model](https://floswald.github.io/NumericalMethods/hw2/)
1. [Probit Estimator](https://floswald.github.io/NumericalMethods/hw3/)
1. [Portfolio Choice Problem](https://floswald.github.io/NumericalMethods/hw5/)

Finally, I'm quite fond of my julia implementation of @fediskhakov 's et al discrete choice EGM paper, so check it out at [https://github.com/floswald/DCEGM.jl](https://github.com/floswald/DCEGM.jl), in particular the [`MLine`](https://github.com/floswald/DCEGM.jl/blob/master/src/line.jl) data type which is really cool 😎.

## Other Resources

There are too many things to cover. Let me try with a quick list:

* https://fluxml.ai/
* https://jump.dev/
* https://makie.juliaplots.org/stable/ and https://lazarusa.github.io/BeautifulMakie/
* https://turing.ml/stable/
* https://julia.quantecon.org/intro.html
* all free courses at https://juliaacademy.com/
* [DataFrames.jl](https://dataframes.juliadata.org/stable/)
* [Parallel computation guide by Jesus Fernandez-Villaverde and David Zarruk](https://www.sas.upenn.edu/~jesusfv/Guide_Parallel.pdf) and everything on Jesus' website.



## Where did I teach this course?

1. University of Barcelona. [Videos made with consent of participants.](https://youtube.com/playlist?list=PLs8aCCD_PbIz3Sliij8Qlv01HXEG2FWb-)
2. Bocconi
3. SciencesPo


## Resources

I used examples and got inspiration from several excellent tutorials out there to build this boot camp:

* [Think Julia](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html) by @benlauwens is fully comprehensive and *very complete* intro to julia, which I highly recommend.
* [The Julia Express](http://bogumilkaminski.pl/files/julia_express.pdf) by @bkamins is a much condensed version - great for a quick start.
* [From Zero to Hero](https://github.com/Datseris/Zero2Hero-JuliaWorkshop) by @datseris is a great tutorial series, bit more advanced but great insights for beginners as well.

Have a look at the [dedicated section](https://julialang.org/learning/) on the julialang website for more great material!
