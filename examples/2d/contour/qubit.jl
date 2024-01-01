using CairoMakie
CairoMakie.activate!(type = "png") #hide

function tα_qubit(β, ψ1, ψ2, fα, f)
    2 + 2 * β - cos(ψ1) - cos(ψ2) - 2 * β * cos(π * fα) * cos(2 * π * f + π * fα - ψ1 - ψ2)
end
ψ1 = ψ2 = range(0, 4 * π, length=100)
z = [tα_qubit(0.61, x, y, 0.2, 0.1) for x in ψ1, y in ψ2]

fig = Figure(size=(600, 400))
ax = Axis(fig[1, 1], aspect=1, xlabel="ψ1", ylabel="ψ2")
cls = contour!(ψ1, ψ2, z; colormap=:plasma, levels=20, linewidth=1.5)
## Colorbar(fig[1, 2], cls, label="α-q")
limits!(ax, 0, 4π, 0, 4π)
## colsize!(fig.layout, 1, Aspect(1, 1.0))

save("qubit.png", fig); # hide

# ![](qubit.png)