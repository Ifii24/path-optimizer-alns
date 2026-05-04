using Plots

# holds weights (or probabilities) per segment + do it for the plot
struct ALNS_Stats_Destructors
    segment::Int                          
    destruction_weights::Vector{Float64}  
end

# holds weights (or probabilities) per segment + do it for the plot
struct ALNS_Stats_Constructors
    segment::Int                          
    construction_weights::Vector{Float64} 
end

struct HeuristicOutcome
    iteration::Int           # Iteration number
    time::Float64            # Time in seconds since the start
    destruction_index::Int   # Index of the destruction heuristic used
    construction_index::Int  # Index of the construction heuristic used
    cost::Float64            # Cost of the solution
end

mutable struct ALNSTracker
    global_best::Vector{HeuristicOutcome}  # Track all global best solutions
    better::Vector{HeuristicOutcome}       # Track all better solutions
    worse::Vector{HeuristicOutcome}        # Track all worse solutions
end

function plot_cumulative_outcomes_destructors(cumulative_outcomes::Vector{Vector{Int64}})
    # Define destructor names
    destructor_names = [
        "Random\nDestructor",
        "Worst\nCost\nRemoval",
        "Distance-Based\nRemoval",
        "Worst\nRemoval\nNarrow\nTW",
        "Worst\nRemoval\nWide\nTW"
    ]

    # Prepare data for grouped bar plot
    global_best = [outcome[1] for outcome in cumulative_outcomes]
    better = [outcome[2] for outcome in cumulative_outcomes]
    worse = [outcome[3] for outcome in cumulative_outcomes]

    # Create the grouped bar plot
    p = groupedbar(
        [global_best better worse],
        bar_position = :dodge,
        bar_width = 0.7,
        xlabel = "Destructors",
        ylabel = "Counts",
        title = "Cumulative Outcomes for Destructors",
        xticks = (1:5, destructor_names),
        label = ["Global Best" "Better" "Worse"],
        legend = :topright
    )

    display(p)
end

function plot_cumulative_outcomes_constructors(cumulative_outcomes::Vector{Vector{Int64}})
    # Define constructor names
    constructor_names = [
        "Cheapest\nInsertion\nHeuristic",
        "Regret\nk-2\nHeuristic",
        "Regret\nk-3\nHeuristic"
    ]

    # Prepare data for grouped bar plot
    global_best = [outcome[1] for outcome in cumulative_outcomes]
    better = [outcome[2] for outcome in cumulative_outcomes]
    worse = [outcome[3] for outcome in cumulative_outcomes]

    # Create the grouped bar plot
    p = groupedbar(
        [global_best better worse],
        bar_position = :dodge,
        bar_width = 0.7,
        xlabel = "Constructors",
        ylabel = "Counts",
        title = "Cumulative Outcomes for Constructors",
        xticks = (1:3, constructor_names),
        label = ["Global Best" "Better" "Worse"],
        legend = :topright
    )

    display(p)
end


function plot_weights_evolution_constructors(stats_c::Vector{ALNS_Stats_Constructors})
    segments = [s.segment for s in stats_c]  # Collect segment numbers
    xticks = collect(0:maximum(segments))  # Ensure the x-axis uses integers

    # Define names for constructors
    constructor_names = ["Cheapest Insertion Heuristic", "Regret k-2 Heuristic", "Regret k-3 Heuristic"]

    # Initialize the plot for the first constructor heuristic
    plot(segments, [s.construction_weights[1] for s in stats_c], label=constructor_names[1], lw=2)

    # Add other constructors to the plot
    for i in 2:3
        plot!(segments, [s.construction_weights[i] for s in stats_c], label=constructor_names[i], lw=2)
    end

    # Adjust axis
    xlabel!("Segment Number")
    ylabel!("Weights (Probabilities)")
    title!("Constructor Weight Evolution Over Segments")
    xticks!(xticks)  # Set integer x-axis ticks
    ylims!(0.2, 0.5) 
    display(plot!())
end


function plot_weights_evolution_destructors(stats_d::Vector{ALNS_Stats_Destructors})
    segments = [s.segment for s in stats_d]  # Collect segment numbers
    xticks = collect(0:maximum(segments))  # Ensure the x-axis uses integers

    # Define names for destructors
    destructor_names = ["Random Destructor", "Worst Cost Removal", "Distance-Based Removal", 
                        "Worst Removal Narrow TW", "Worst Removal Wide TW"]

    # Initialize the plot for the first destructor heuristic
    plot(segments, [s.destruction_weights[1] for s in stats_d], label=destructor_names[1], lw=2)

    # Add other destructors to the plot
    for i in 2:5
        plot!(segments, [s.destruction_weights[i] for s in stats_d], label=destructor_names[i], lw=2)
    end

    # Adjust axis
    xlabel!("Segment Number")
    ylabel!("Weights (Probabilities)")
    title!("Destructor Weight Evolution Over Segments")
    xticks!(xticks)  # Set integer x-axis ticks
    ylims!(0.0, 1.0)  
    display(plot!())
end

function plot_cost_vs_iterations(tracker::Vector{ALNSTracker})
    # Extract iterations and costs from the global_best tracker
    iterations = [outcome.iteration for outcome in tracker.global_best]
    costs = [outcome.cost for outcome in tracker.global_best]

    # Create the plot
    p = plot(
        iterations, costs,
        title = "Global Best Cost vs Iterations",
        xlabel = "Iterations",
        ylabel = "Cost",
        marker = :circle,
        linecolor = :orange, 
        markercolor = :orange, 
        label = "Cost over Iterations",
        legend = :topright,
        linewidth = 2
    )
    
    # Display the plot
    display(p)
end


