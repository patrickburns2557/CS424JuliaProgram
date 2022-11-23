#!/usr/bin/julia



open("register.txt") do file
    counter = 0
    while counter < 30
        counter += 1
        println("[", counter, "] |", readline(file), "|")
    end
end