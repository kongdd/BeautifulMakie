using CairoMakie, Random
CairoMakie.activate!(type = "svg") #hide

Random.seed!(145)
n = 50
x = 1:n
y = sin.(x) .+ randn(n)/10
yerr = 0.2*abs.(randn(n))
xerr = abs.(randn(n))

fig, ax, =  errorbars(x, y, yerr; color = 1:n, colormap = ([:black, :orangered]),
    whiskerwidth = 10, linewidth = 1.5, 
    figure = (;size = (600,400)))
errorbars!(x, y, xerr; color = 1:n, colormap = ([:orangered, :black]), 
    direction = :x, linewidth = 1.5, whiskerwidth = 10)
scatter!(x, y; markersize = 10, color = (:black, 0.25), 
    strokewidth = 1, strokecolor = :black)
lines!(x, y; linewidth = 0.5, linestyle = :dashdot)
hidedecorations!(ax; grid = false) 
fig
save("errorbars.svg", fig); # hide

# ![](errorbars.svg)