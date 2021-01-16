"""
A reservoir Outlet should always have the following:
    - An elevation field z
    - A discharge function.

The discharge function depends on the hydralic head measured from the elevation
of the outlet (z) to the reservoir water surface.
"""

abstract type Outlet end

discharge(o::Outlet; z) = z > o.z ? discharge(o, z - o.z) : 0.0

discharge(o::Outlet, h) =
    error("Please implement a discharge function for type ", typeof(o))

Base.@kwdef struct Orifice <: Outlet
    C::Float64
    A::Float64
    z::Float64
    g::Float64 = 9.81
end

discharge(o::Orifice, h) = o.C * o.A * √(2.0 * o.g * h)

Base.@kwdef struct Weir <: Outlet
    C::Float64
    B::Float64
    z::Float64
end

discharge(o::Weir, h) = o.C * o.B * h^1.5
