## This currently fails with CairoMakie
## https://discourse.julialang.org/t/striped-colors-for-e-g-bar-plots-in-julia/64435/3
using GLMakie.Makie, GLMakie, Random
GLMakie.activate!()
GLMakie.closeall() # close any open screen


Random.seed!(13)
## patterns
## `'/'`, `'\\'`, `'-'`, `'|'`, `'x'`, and `'+'`
directions = [Vec2f(1), Vec2f(1, -1), Vec2f(1, 0), Vec2f(0, 1),
    [Vec2f(1), Vec2f(1, -1)], [Vec2f(1, 0), Vec2f(0, 1)]]
colors = [:white, :orange, (:green, 0.5), :yellow, (:blue, 0.85), :black]

patternColors = [Makie.LinePattern(direction = hatch; width = 5, tilesize = (20, 20),
    linecolor = colors[indx], background_color = colors[end-indx+1])
        for (indx, hatch) in enumerate(directions)]

fig, ax, pltobj = barplot(1:2, strokewidth = 2, color = ["grey", "orange"],
    figure = (size = (1200, 800), fontsize = 32))
for (idx, pattern) in enumerate(patternColors)
    barplot!(ax, [idx + 2], [idx * (2rand() + 1)], color = pattern, strokewidth = 2)
end
ax.xticks = (1:8, ["grey", "orange", "/", "\\", "-", "|", "x", "+"])
fig
save("stripped_bars.png", fig); # hide

# ![](stripped_bars.png)