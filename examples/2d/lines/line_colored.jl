using CairoMakie, ColorSchemes
CairoMakie.activate!(type = "svg") #hide

xs = 0:0.01:1
p = -10:1:10
p = filter(x -> x != 0, collect(p))
psize = length(p)
ys = zeros(length(xs), psize)
for (indx, i) in enumerate(p)
    if i <= -1
        ys[:, indx] = xs .^ (1 / abs(i))
    elseif i >= 1
        ys[:, indx] = xs .^ i
    end
end
cbarPal = :thermal
cmap = cgrad(colorschemes[cbarPal], psize, categorical = true)
fig = Figure(size = (600, 400), fonts = (; regular= "CMU Serif"))
ax = Axis(fig[1, 1], aspect = 1, xlabel = L"x", ylabel = L"x^{p}",
    xlabelsize = 22, ylabelsize = 22)
[lines!(xs, ys[:, v], color = cmap[v], label = "$(p[v])") for v in 1:psize]
Legend(fig[1, 2], ax, L"p"; nbanks = 2)
colsize!(fig.layout, 1, Aspect(1, 1.0))
fig
save("line_colored.svg", fig); # hide

# ![](line_colored.svg)
