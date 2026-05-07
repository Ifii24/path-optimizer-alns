# structs.jl
# Defines the core data types used across the whole codebase.
# Grouping everything into structs instead of passing 15 arguments everywhere
# makes the function signatures actually readable.

# Everything about the problem instance itself - the data, nothing else
struct ProblemInstance
    n::Int64              # number of nodes (not counting the depot twice)
    d::Matrix{Int64}      # distance matrix (n x n)
    t::Matrix{Int64}      # travel time matrix (n x n)
    h::Vector{Int64}      # handling time at each node
    ei::Vector{Int64}     # earliest allowed arrival (time window start)
    li::Vector{Int64}     # latest allowed arrival (time window end)
    q::Float64            # normalization factor for distance in the cost function
end

# Parameters for the LNS/ALNS solver - tuning knobs basically
struct SolverParams
    time_limit::Float64           # max runtime in seconds
    initial_temperature::Float64  # starting temperature for simulated annealing
    cooling_rate::Float64         # how fast temperature drops (e.g. 0.99)
    percentage_to_destroy::Float64 # fraction of nodes removed per iteration
    wd::Float64                   # weight on distance in cost function
    wt::Float64                   # weight on travel time
    wv::Float64                   # weight on time window violations
end

# Parameters specific to ALNS (extends the basic solver params)
struct ALNSParams
    max_iterations::Int64
    initial_temperature::Float64
    cooling_rate::Float64
    r::Float64                     # reaction factor for weight updates
    percentage_to_destroy::Float64
    segment_size::Int64            # how often to update heuristic weights
end

# Tracks which solutions were found and when - used for post-run analysis
struct HeuristicOutcome
    iteration::Int
    time::Float64
    destruction_index::Int
    construction_index::Int
    cost::Float64
end

# Stores how heuristic weights evolved over segments - for plotting
struct WeightSnapshot
    iteration::Int
    destruction_weights::Vector{Float64}
    construction_weights::Vector{Float64}
end
