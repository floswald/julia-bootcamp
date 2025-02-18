import REPL
Base.atreplinit() do repl
    # make the ; shell mode sticky
    !isdefined(repl, :interface) && (repl.interface = REPL.setup_interface(repl))
    repl.interface.modes[2].sticky=true
end

ENV["JULIA_EDITOR"]="code"
