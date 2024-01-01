using GLMakie, GitHub, Downloads, FileIO
GLMakie.activate!() #hide

function getavatars(; n = 90)
    contri = GitHub.contributors("JuliaPlots/Makie.jl")[1]
    avatars = []
    contributions = []
    for i in eachindex(contri)
        push!(avatars, contri[i]["contributor"].avatar_url.uri)
        push!(contributions, contri[i]["contributions"])
    end
    p = sortperm(contributions, rev=true)
    imgs = []
    for i in p[1:n]
        img_d = Downloads.download(avatars[i])
        push!(imgs, load(img_d))
    end
    return imgs
end
avatars = getavatars()

function plotcontributors(avatars)
    fig = Figure(; size = (1200,600))
    ax = Axis(fig[1,1], aspect = DataAspect())
    k = 1
    for i in 6:-1:1, j in 1:15
        scatter!(ax, Point2f(j,i); 
            marker = #Circle, 
            image = avatars[k], 
            markersize = 70)
        k += 1
    end
    hidedecorations!.(ax)
    hidespines!.(ax)
    limits!(ax, 0, 16, 0, 7)
    fig
end

fig = plotcontributors(avatars)
save("makie_contributors.png", fig); # hide

# ![](makie_contributors.png)