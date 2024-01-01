using CairoMakie, ColorSchemes
CairoMakie.activate!(type = "svg") #hide

x = range(0, 2π, 50)
fig = Figure(size = (800, 400))
ax = Axis(fig[1, 1], xlabel = L"x", xlabelsize = 22)
line1 = lines!(x, sin.(x); color = x, colormap = :thermal, linewidth = 4)
line2 = lines!(x, cos.(x); color = sqrt.(x), colormap = :ice, linewidth = 4)
line3 = lines!(x, -sin.(x); color = x .^ 2, colormap = :viridis, linewidth = 4)
line4 = lines!(x, -cos.(x); color = x / 2, colormap = :plasma, linewidth = 4)
lineas = [line1, line2, line3, line4]
labels = [L"x", L"\sqrt{x}", L"x^{2}", L"x/2"]
cbars = [Colorbar(fig[1, i+1], lineas[i], label = labels[i], labelsize = 22)
            for i in 1:4]
colgap!(fig.layout, 5)
fig
save("line_cmaps.svg", fig); # hide

# ![](line_cmaps.svg)
