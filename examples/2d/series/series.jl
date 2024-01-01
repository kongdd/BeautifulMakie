using CairoMakie, Random, LaTeXStrings
CairoMakie.activate!(type = "svg") #hide
Random.seed!(123)
m = 200
function spiral(; a = 1, n = 100, h = 0, k = 0)
    φ = LinRange(rand() + 1, 6π, n)
    h .+  rand(-1:2:1)*a*cos.(φ)./φ, k .+  rand(-1:2:1)*a*sin.(φ)./φ
end
x = raw"x=a\,\cos(\varphi)/\varphi,\quad "
y = raw"y=a\,\sin(\varphi)/\varphi,\quad "
curves = [spiral(; a = rand(), h = rand(-1:1)) for i in 1:m]

fig = Figure(size = (600,400))
ax = Axis(fig[1,1])
series!(curves; color = resample_cmap(:bone_1, m), linewidth = 1.5)
text!(latexstring(x * y * "\\varphi>0"), position = (-1,-1))
hidedecorations!(ax; grid = false)
fig
save("series.svg", fig); # hide

# ![](series.svg)