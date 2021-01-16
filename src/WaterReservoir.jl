module WaterReservoir

using Interpolations

include("reservoir-geometry.jl")
include("inflow.jl")
include("outlet.jl")

Base.@kwdef struct ReservoirModel{G<:ReservoirGeometry,I<:Inflow,O<:Outlet}
    geometry::G
    inflow::I
    outlet::O
    z₀::Float64 = 0.0
end

Base.@kwdef struct Simulation{M <: ReservoirModel}
    model::M
    Δt::Float64
    n::Int
end

function run(sim)
    # Result storage
    t = Vector{Float64}(undef, sim.n + 1)
    z = similar(t)
    Qout = similar(t)
    # Initial conditions
    t[1] = 0.0
    z[1] = sim.model.z₀
    Qout[1] = discharge(sim.model.outlet, z = z[1])
    # Iterations
    for i = 1:sim.n
        Qin = discharge(sim.model.inflow, t[i])
        S = surface_area(sim.model.geometry, z[i])
        t[i+1] = i * sim.Δt
        z[i+1] = z[i] + sim.Δt * (Qin - Qout[i]) / S
        Qout[i+1] = discharge(sim.model.outlet, z = z[i+1])
    end
    return t, z, Qout
end

end # module
