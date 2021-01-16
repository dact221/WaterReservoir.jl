g = Extrusion(5)
i = ConstantInflow(0)
o = Orifice(C = 0.7, A = 0.005, z = 0)
model = ReservoirModel(geometry = g, inflow = i, outlet = o, z₀ = 10.0)
sim = Simulation(model = model, Δt = 5.0, n = 500)
t, z, Qout = run(sim)


struct ContinuousCurve <: ReservoirGeometry end

surface_area(g::ContinuousCurve, z) = 100.0 * z^2

struct ContinuousHydrograph <: Inflow end

function discharge(i::ContinuousHydrograph, t)
    if t < 40_000.0
        2000.0 * (1.0 - t / 40_000.0)
    else
        0.0
    end
end

g = ContinuousCurve()
i = ContinuousHydrograph()
o = Weir(C = 1.0, B = 100.0, z = 95.0)
model = ReservoirModel(geometry = g, inflow = i, outlet = o, z₀ = 50.0)
sim = Simulation(model = model, Δt = 100.0, n = 1000)
t, z, Qout = run(sim)
