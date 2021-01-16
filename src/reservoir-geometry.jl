abstract type ReservoirGeometry end

surface_area(g::ReservoirGeometry, z) =
    error("Please implement a surface_area function for type ", typeof(g))

struct Extrusion <: ReservoirGeometry
    A::Float64
end

surface_area(g::Extrusion, z) = g.A
volume(g::Extrusion, z) = g.A * z

struct DiscreteCurve <: ReservoirGeometry
    n::Int
    z::Vector{Float64}
    S::Vector{Float64}
end

surface_area(g::DiscreteCurve, z) = _linear_interpolation(g.n, g.z, g.S, z)

function volume(g::DiscreteCurve, z)
    V = 0.0
    for i = 2:g.n
        V += (S[i - 1] + S[i]) * (z[i] - z[i - 1])
    end
    return V / 2.0
end
