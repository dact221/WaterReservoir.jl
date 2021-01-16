abstract type Inflow end

discharge(i::Inflow, t) =
    error("Please implement a discharge function for type ", typeof(i))

struct ConstantInflow <: Inflow
    Q::Float64
end

discharge(i::ConstantInflow, t) = i.Q

struct DiscreteHydrograph <: Inflow
    n::Int
    t::Vector{Float64}
    Q::Vector{Float64}
end

discharge(i::DiscreteHydrograph, t) = _linear_interpolation(i.n, i.t, i.Q, t)
