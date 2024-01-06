# ## x-error barplot and y-errorbars
# ![](x_barplot_error_y_error.svg)

using CairoMakie, Random
CairoMakie.activate!(type = "svg") #hide

Random.seed!(145)
x, y = 1:2:20, 5 * rand(10)
yerr, xerr = 0.4 * abs.(randn(10)), abs.(randn(10))
fig = Figure(size = (600, 400), fonts =(; regular= "sans"))
ax = Axis(fig[1, 1], xlabel = "variables", ylabel = "values")
barplot!(ax, x, y; width = 1.8xerr, strokewidth = 1, color = :transparent,
    strokecolor = :black)
errorbars!(ax, x, y, yerr; whiskerwidth = 12)
fig
save("x_barplot_error_y_error.svg", fig); # hide