# ## Meshes: Cylinder, Pyramid, Cone, Cube

# ![](meshes.png)

using GLMakie, Random, Colors, LinearAlgebra
using GeometryBasics: Cylinder, Pyramid
using Makie
import GeometryBasics
GLMakie.activate!() # hide
GLMakie.closeall() # close any open screen

Random.seed!(3)

cyl = Cylinder(Point{3, Float64}(1,2,3), Point{3, Float64}(2,3,4), 1.0)
pyr = Pyramid(Point3f(0), 1f0, 1f0)
rectmesh = Rect3(Point3f(-0.5), Vec3f(1))
rectthin = Rect3(Point3f(-1), Vec3f(2,2,0.25))
sphere = Sphere(Point3f(-0.5), 1)
Cone(; quality = 10) = merge([
    Makie._circle(Point3f(0), 0.5f0, Vec3f(0,0,-1), quality),
    Makie._mantle(Point3f(0), Point3f(0,0,1), 0.5f0, 0f0, quality)])
cone = Cone()
rectMesh = GeometryBasics.mesh(rectmesh)
rectThin = GeometryBasics.mesh(rectthin)
cyL = GeometryBasics.mesh(cyl)

cmap = resample_cmap(:Spectral_11, length(rectMesh.position))
colors1 = [cmap[i] for (i,v) in enumerate(rectMesh.position)]
colors2 = [RGBA(rand(4)...) for v in rectThin.position]
colors3 = [norm(v) for v in cyL.position]
markers = [sphere, rectmesh, cyl, pyr, cone]

with_theme(theme_dark()) do
    fig = Figure(size = (1200,800))
    axs = [Axis3(fig[i,j]; aspect = :data, perspectiveness = 0.5) 
        for j in 1:3, i in 1:2]
    mesh!(axs[1], sphere, color = :white)
    mesh!(axs[2], rectmesh, color = colors1)
    mesh!(axs[3], pyr; color = (:dodgerblue, 0.85))
    wireframe!(axs[3], pyr; color = :grey90)
    mesh!(axs[4], cyl; color = colors3, 
        colormap = :diverging_tritanopic_cwr_75_98_c20_n256)
    mesh!(axs[5], cone; transparency = true)
    wireframe!(axs[5], cone; color = :grey90, linewidth = 0.5)
    mesh!(axs[6], rectthin; color = colors2, shading = NoShading)
    [meshscatter!(axs[6], Point3f(1.5rand(3) .- 0.5); marker = markers[i], 
        markersize = 0.25) for i in 1:5]
    fig
end
save("meshes.png", current_figure()); # hide