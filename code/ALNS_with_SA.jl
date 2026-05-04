"""
Input: 
- original_solution: The original solution array (before a node is inserted) --> (size = # of istinct nodes in the solution + 1)
- new_solution: The new solution array (after the node in question is inserted) --> (size = # of istinct nodes in the solution + 1)
- d: Distance matrix (n x n)

Functionality: 
- Computes the additional distance caused by inserting a node into the solution
- It calculates THE DIFFERENCE between the total distance of the original solution and the new solution after node insertion.

Output: 
- The difference in total distance between the original solution and the new solution (an integer)
"""
function compute_additional_distance(original_solution::Vector{Int64}, new_solution::Vector{Int64}, d::Matrix{Int64})
    original_distance = compute_total_distance(original_solution, d)
    new_distance = compute_total_distance(new_solution, d)
    #println("Original distance: ", original_distance)
    #println("New distance: ", new_distance)
    return new_distance - original_distance
end


"""
Input: 
- solution: An array representing the current solution (route) --> (size = # of istinct nodes in the solution + 1)
- d: Distance matrix (n x n)

Functionality: 
- Computes the total distance of the given solution by summing up the distances between consecutive nodes

Output: 
- total_distance: The total distance of the given solution (an integer)
"""
function compute_total_distance(solution::Vector{Int64}, d::Matrix{Int64})
    total_distance = 0
    for i in 2:(length(solution))
        total_distance += d[solution[i-1], solution[i]]
    end
    return total_distance
end

"""
Input:
- original_solution: The original solution array (before the node is inserted) --> (size = # of istinct nodes in the solution + 1)
- new_solution: The new solution array (after the node is inserted) --> (size = # of istinct nodes in the solution + 1)
- t: Time matrix (n x n)
- h: Handling times vector (size n)

Functionality:
- Computes the additional time caused by inserting a node into the solution.
- It calculates the difference between the total time of the original solution and the new solution after node insertion.

Output:
- The difference in total time between the original solution and the new solution (an integer).
"""
function compute_additional_time(original_solution::Vector{Int64}, new_solution::Vector{Int64}, t::Matrix{Int64}, h::Vector{Int64})
    original_time = compute_total_time(original_solution, t, h)
    new_time = compute_total_time(new_solution, t, h)
    #println("Original time: ", original_time)
    #println("New time: ", new_time)
    return new_time - original_time
end


"""
Input:
- solution: A vector representing the current solution (route) --> (size = # of istinct nodes in the solution + 1)
- t: Time matrix (n x n)
- h: Handling times vector (size n)

Functionality:
- Computes the total time for the given solution by summing the travel times and handling times

Output:
- total_time: The total time for the given solution (an integer)
"""
function compute_total_time(solution::Vector{Int64}, t::Matrix{Int64}, h::Vector{Int64})
    total_time = 0
    for i in 2:(length(solution))
        total_time += t[solution[i-1], solution[i]] + h[solution[i]]
    end
    return total_time
end

function two_opt_swap(route, i, j)
    new_route = copy(route) 
    reverse!(new_route, i, j) # Create a new route with the segment between i and j reverse
    return new_route
end

function delta_evaluation(route::Vector{Int64}, i::Int, j::Int, d::Matrix{Int64})
    # Old edges (before the swap)
    old_distance = d[route[i-1], route[i]] + d[route[j], route[j+1]]
    
    # New edges (after the swap)
    new_distance = d[route[i-1], route[j]] + d[route[i], route[j+1]]
    
    # Return the change in distance (new - old)
    delta_d = new_distance - old_distance
    return delta_d
end

# 2-Opt Heuristic with delta evaluation (depot at position 1 and last position)
function Two_Opt_Heuristic(current_best_route::Vector{Int64}, d::Matrix{Int64})
    neighborhood = Vector{Vector{Int64}}()
    dist = Vector{Int64}()
    
    current_distance = compute_total_distance(current_best_route, d)  # Current route's total distance
    
    for i in 2:(length(current_best_route) - 2)  
        for j in i+1:(length(current_best_route) - 1)  
            # Perform the swap using 2-opt
            neighbor = two_opt_swap(current_best_route, i, j)
            
            # Use delta evaluation to calculate the change in distance caused by the swap
            delta_dist = delta_evaluation(current_best_route, i, j, d)
            
            # Calculate the new distance using the current distance and the delta change
            new_distance = current_distance + delta_dist
            
            # Add the neighbor and the new distance to the lists
            push!(neighborhood, neighbor)
            push!(dist, new_distance)
        end
    end
    return neighborhood, dist
end

function Select_Best_Neighbor(neighborhood::Vector{Vector{Int64}}, dist::Vector{Int64}, current_best_route::Vector{Int64}, current_best_dist::Int64)
    # Find the index of the neighbor with the minimum distance
    min_dist_index = argmin(dist)
    best_neighbor = neighborhood[min_dist_index]
    min_dist = dist[min_dist_index]

    # Acceptance criteria
    if min_dist < current_best_dist
        return best_neighbor, min_dist
    else
        return current_best_route, current_best_dist
    end
end



# Single Iteration LS - 2-OPT
function SingleIterationLocalSearch2Opt(current_best_route::Vector{Int64}, current_best_dist::Int64, d::Matrix{Int64})
    # Generate neighbors and their distances in one pass
    neighborhood, dist = Two_Opt_Heuristic(current_best_route, d)
    
    # Select the best neighbor from the generated neighborhood
    current_best_route, current_best_dist = Select_Best_Neighbor(neighborhood, dist, current_best_route, current_best_dist)    # best_route = best_neighbor
    
    return current_best_dist, current_best_route
end


function two_swap(route::Vector{Int64}, i::Int, j::Int)
    new_route = copy(route) # Create a new route
    # Perform the 2-swap by exchanging nodes i and j
    new_route[i], new_route[j] = new_route[j], new_route[i]
    return new_route
end

# 2-Swap Heuristic
function Two_Swap_Heuristic(current_best_route::Vector{Int64}, d::Matrix{Int64})
    neighborhood = Vector{Vector{Int64}}()
    dist = Vector{Int64}()
    
    current_distance = compute_total_distance(current_best_route, d)  # Current route's total distance
    
    for i in 2:(length(current_best_route) - 2)  
        for j in i+1:(length(current_best_route) - 1)  
            # Perform the 2-swap
            neighbor = two_swap(current_best_route, i, j)
            
            # Calculate the new distance for the swapped route
            new_distance = compute_total_distance(neighbor, d)
            
            # Add the neighbor and the new distance to the lists
            push!(neighborhood, neighbor)
            push!(dist, new_distance)
        end
    end
    return neighborhood, dist
end

# Single Iteration LS - 2-SWAP
function SingleIterationLocalSearch2Swap(current_best_route::Vector{Int64}, current_best_dist::Int64, d::Matrix{Int64})
    # Generate neighbors and their distances in one pass
    neighborhood, dist = Two_Swap_Heuristic(current_best_route, d)
    
    # Select the best neighbor from the generated neighborhood
    current_best_route, current_best_dist = Select_Best_Neighbor(neighborhood, dist, current_best_route, current_best_dist)    # best_route = best_neighbor
    
    return current_best_dist, current_best_route
end


function roulette_selection(weights::Vector{Float64})
    cumulative_weights = cumsum(weights)
    random_value = rand() * cumulative_weights[end]
    selected_heuristic = findfirst(x -> x >= random_value, cumulative_weights)
    return selected_heuristic
end

struct WeightEvolution
    iteration::Int
    destruction_weights::Vector{Float64}
    construction_weights::Vector{Float64}
end


function update_weights_no_normalization(
    weights::Vector{Float64},     # current w for heuristics (constructors + destructors)
    scores::Vector{Float64},      # total scores (π) earned by heuristics
    usage_counts::Vector{Int},    # number of times (θ) each heuristic was used
    reaction_factor::Float64      # reaction factor (r)
)
    # Compute efficiency (π/θ)
    efficiency = [scores[i] / max(usage_counts[i], 1) for i in 1:length(scores)]
    
    # Update weights
    updated_weights = weights .* (1.0 - reaction_factor) + reaction_factor .* efficiency

    return updated_weights
end


function update_weights_normalized(
    weights::Vector{Float64},     # Current weights
    scores::Vector{Float64},      # Total scores (π) earned by heuristics
    usage_counts::Vector{Int},    # Number of times (θ) each heuristic was used
    reaction_factor::Float64      # Reaction factor (r)
)
    # Compute efficiency (π/θ)
    efficiency = [scores[i] / max(usage_counts[i], 1) for i in 1:length(scores)]
    
    # Update weights without normalization
    updated_weights = weights .* (1.0 - reaction_factor) + reaction_factor .* efficiency
    
    # Normalize the weights so they sum to 1
    weight_sum = sum(updated_weights)
    normalized_weights = updated_weights ./ weight_sum

    return normalized_weights
end

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

# Initialize the tracker
tracker = ALNSTracker([], [], [])

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

function plot_cost_vs_iterations(tracker::ALNSTracker)
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




function ALNS_with_2swap(
    initial_solution::Vector{Int64},              # 
    max_iterations::Int64,                        # 
    #initial_temperature::Float64,                #
    w::Float64,                                     # % that determines how many worse solutions are accepted initially 
    cooling_rate::Float64,                        # 
    n::Int64,                                     #
    d::Matrix{Int64},                             # Distance 
    t::Matrix{Int64},                             # Time 
    h::Vector{Int64},                             # Handling times 
    ei::Vector{Int64},                            # TW Start
    li::Vector{Int64},                            # TW End
    r::Float64,                                   # Weight reaction factor
    q::Float64,                                   # Obj. function (distance) normalization factor
    percentage_to_destroy::Float64,               # Percentage of nodes to remove during destruction
    segment_size::Int64                           # Number of iterations per segment
)

    current_solution = deepcopy(initial_solution)
    current_time = compute_total_time(current_solution, t, h)
    current_distance = compute_total_distance(current_solution, d)

    _, _, _, _, _, _, _, _, _, _, _, violationsLate, _ = compute_arrival_times_weighted_step(current_solution, t, h, ei, li)
    current_cost = 0.4 * q * current_distance + 0.4 * current_time + 0.2 * violationsLate  

    best_solution = deepcopy(current_solution)
    best_cost = current_cost

    # Initialize temperature
    #T = initial_temperature

    # Compute initial temperature
    T = -w * 50 * current_cost / log(0.5)


    iterations = 0 

    # Initialize weights and scores for destruction and construction heuristics
    destruction_weights = [0.2, 0.2, 0.2, 0.2, 0.2]         # e.g.: [Random, Max Distance Removal, Max TW Removal]
    destruction_scores = [0.0, 0.0, 0.0, 0.0, 0.0]          # π for destruction
    destruction_usage_counts = [0, 0, 0, 0, 0]              # θ for destruction
    destruction_outcomes = [[0, 0, 0] for _ in 1:5]    # e.g. destruction_outcomes = [[σ1, σ2, σ3], [σ1, σ2, σ3], [σ1, σ2, σ3], [σ1, σ2, σ3], [σ1, σ2, σ3]]
    # How many times each h yields global best, better and unknown, worse but unknown  heurstic 1    heuristic 2   heuristic 3   heuristic 4   heuristic 5

    cumulative_destruction_outcomes = [[0, 0, 0] for _ in 1:5] # for the plot

    construction_weights = [0.333333333, 0.333333333, 0.333333334]  # e.g.: [Greedy Insertion, Regret-2, Regret-3]
    construction_scores = [0.0, 0.0, 0.0]   # π for construction
    construction_usage_counts = [0, 0, 0]   # θ for construction
    construction_outcomes = [[0, 0, 0] for _ in 1:3]

    cumulative_construction_outcomes = [[0, 0, 0] for _ in 1:3] # for the plot


    # Define reward parameters (σ) - these remain unchanged during all iterations
    σ1, σ2, σ3 = 10.0, 5.0, 2.0

    # Track statistics
    weight_evolution = Vector{WeightEvolution}()

    stats_c = Vector{ALNS_Stats_Constructors}()
    push!(stats_c, ALNS_Stats_Constructors(0, deepcopy(construction_weights)))  #initialize for plotting with starting equal probability

    stats_d = Vector{ALNS_Stats_Destructors}()
    push!(stats_d, ALNS_Stats_Destructors(0, deepcopy(destruction_weights)))  #initialize for plotting with starting equal probability

    # Track the solutions that have been visited before
    visited_solutions = Set{Tuple}()  # Use tuples because they are unmutable and therefore hashable (unlike vectors)

    # Start tracking execution time
    start_time = time() 

    # ALNS Main Loop
    for iter in 1:max_iterations
        #println("Iteration: ", iter, " and temperature: ", T)
        iterations += 1

        # Step 1: Select destruction and construction heuristics
        destruction_index = roulette_selection(destruction_weights)
        construction_index = roulette_selection(construction_weights)

        # Step 2: Apply the selected destruction heuristic
        if destruction_index == 1
            remaining_solution, removed_nodes = random_destructor(current_solution, percentage_to_destroy)
        elseif destruction_index == 2
            remaining_solution, removed_nodes = Worst_Cost_Removal(current_solution, percentage_to_destroy, d, t, h, ei, li, 3)  # Pworst = 3 
        elseif destruction_index == 3
            remaining_solution, removed_nodes = Distance_Based_Removal(current_solution, d, percentage_to_destroy)
        elseif destruction_index == 4 
            remaining_solution, removed_nodes = Worst_Removal_Narrow_TW(current_solution, percentage_to_destroy, ei, li)
        elseif destruction_index == 5
            remaining_solution, removed_nodes = Worst_Removal_Wide_TW(current_solution, percentage_to_destroy, ei, li)    
        end
        destruction_usage_counts[destruction_index] += 1


        # Step 3: Apply the selected construction heuristic
        if construction_index == 1
            new_solution, _, _, _, _, _, _, _, _, _, _ = Cheapest_Insertion_Constructor(remaining_solution, removed_nodes, n, d, t, h, ei, li, q)
        elseif construction_index == 2
            new_solution, _, _, _, _, _, _, _, _, _, _ = Regret_Insertion_k2(remaining_solution, removed_nodes, d, t, h, ei, li, q)
        elseif construction_index == 3
            new_solution, _, _, _, _, _, _, _, _, _, _ = Regret_Insertion_k3(remaining_solution, removed_nodes, d, t, h, ei, li, q)
        end
        construction_usage_counts[construction_index] += 1

        new_distance = compute_total_distance(new_solution, d)

        # Step 4: Apply 2-OPT local search
        #new_distance_2opt, new_solution_2opt = SingleIterationLocalSearch2Opt(new_solution, new_distance, d)

        # Step 4': Apply 2-SWAP local search 
        new_distance_2swap, new_solution_2swap = SingleIterationLocalSearch2Swap(new_solution, new_distance, d)
#=
        # Step 5: Compute the cost of the new solution
        new_time_2opt = compute_total_time(new_solution_2opt, t, h)
        
        _, _, _, _, _, _, _, _, _, _, _, violationsLate2opt, _ = compute_arrival_times_weighted_step(new_solution_2opt, t, h, ei, li)
        new_cost_2opt = 0.4 * q * new_distance_2opt + 0.4 * new_time_2opt + 0.2 * violationsLate2opt # + 0.02*total_waiting_time  + 0.03*violationsEarly       #violations = sum(early_violations_duration) + sum(late_violations_duration)

        solution_tuple = Tuple(new_solution_2opt)
=#
        # Step 5': Compute the cost of the new solution
        new_time_2swap = compute_total_time(new_solution_2swap, t, h)

        _, _, _, _, _, _, _, _, _, _, _, violationsLate2swap, _ = compute_arrival_times_weighted_step(new_solution_2swap, t, h, ei, li)
        new_cost_2swap = 0.4 * q * new_distance_2swap + 0.4 * new_time_2swap + 0.2 * violationsLate2swap # + 0.02*total_waiting_time  + 0.03*violationsEarly       #violations = sum(early_violations_duration) + sum(late_violations_duration)

        solution_tuple = Tuple(new_solution_2swap)
#=
        # Step 6: Check for unvisited solutions and update rewards
        if !(solution_tuple in visited_solutions)
            push!(visited_solutions, solution_tuple) # mark sol as visited

            now_time = time() - start_time  # Calculate elapsed time

            if new_cost_2opt < best_cost   
                # Global best found
                best_solution = deepcopy(new_solution_2opt) # Always preserve the global best solution
                best_cost = new_cost_2opt                   # Always preserve the global best cost
                #println("New global best found with cost: ", best_cost)
                destruction_outcomes[destruction_index][1] += 1  # Increment global best counter e.g. destruction_outcomes[2][1] += 1 --> [[0, 0, 0], [1, 0, 0], [0, 0, 0], [0, 0, 0]]  
                construction_outcomes[construction_index][1] += 1
                current_solution = deepcopy(best_solution)  # Always accept global best
                current_cost = best_cost

                # Log the global best outcome
                now_time = time() - start_time  # Calculate elapsed time
                push!(tracker.global_best, HeuristicOutcome(iter, now_time, destruction_index, construction_index, new_cost_2opt))
                #println("New global best found with cost: $best_cost at iteration $iter and time $(round(now_time, digits=2)) seconds.")


            elseif new_cost_2opt < current_cost
                # Better solution found
                #println("Better unvisited solution accepted with cost: ", new_cost_2opt)
                destruction_outcomes[destruction_index][2] += 1  # Increment better solution counter
                construction_outcomes[construction_index][2] += 1

                current_solution = deepcopy(new_solution_2opt)  # Always accept better solutions
                current_cost = new_cost_2opt

                # Better solution found
                now_time = time() - start_time  # Calculate elapsed time
                push!(tracker.better, HeuristicOutcome(iter, now_time, destruction_index, construction_index, new_cost_2opt))
                #println("Better unvisited solution accepted with cost: $new_cost_2opt.")
            else
                # Worse but unvisited solution accepted
                #println("Worse unvisited solution accepted with cost: ", new_cost_2opt)
                destruction_outcomes[destruction_index][3] += 1  # Increment worse solution counter
                construction_outcomes[construction_index][3] += 1


                # Worse but unvisited solution accepted
                now_time = time() - start_time  # Calculate elapsed time
                push!(tracker.worse, HeuristicOutcome(iter, now_time, destruction_index, construction_index, new_cost_2opt))
                #println("Worse unvisited solution accepted with cost: $new_cost_2opt.")


                delta = new_cost_2opt - current_cost
                acceptance_probability = exp(-delta / T)

                if rand() < acceptance_probability
                    # Accept the solution
                    current_solution = deepcopy(new_solution_2opt)
                    current_cost = new_cost_2opt
                    #println("Accepted worse solution with probability $acceptance_probability.")
                else
                    # Reject the solution
                    #println("Rejected worse solution with probability $acceptance_probability.")
                end
            end
        else
            # Solution already visited
            delta = new_cost_2opt - current_cost
            acceptance_probability = exp(-delta / T)

            if rand() < acceptance_probability
                # Allow SA to accept visited solutions
                current_solution = deepcopy(new_solution_2opt)
                current_cost = new_cost_2opt
                #println("Accepted previously visited solution with probability $acceptance_probability.")
            else
                #println("Rejected previously visited solution with probability $acceptance_probability.")
            end
        end
=#
        # Step 6': Check for unvisited solutions and update rewards
        if !(solution_tuple in visited_solutions)
            push!(visited_solutions, solution_tuple) # mark sol as visited

            if new_cost_2swap < best_cost   
                # Global best found
                best_solution = deepcopy(new_solution_2swap) # Always preserve the global best solution
                best_cost = new_cost_2swap                   # Always preserve the global best cost
                #println("New global best found with cost: ", best_cost)
                destruction_outcomes[destruction_index][1] += 1  # Increment global best counter e.g. destruction_outcomes[2][1] += 1 --> [[0, 0, 0], [1, 0, 0], [0, 0, 0], [0, 0, 0]]  
                construction_outcomes[construction_index][1] += 1
                current_solution = deepcopy(best_solution)  # Always accept global best
                current_cost = best_cost

                # Log the global best outcome
                now_time = time() - start_time  # Calculate elapsed time
                push!(tracker.global_best, HeuristicOutcome(iter, now_time, destruction_index, construction_index, new_cost_2swap))
                #println("New global best found with cost: $best_cost at iteration $iter and time $(round(now_time, digits=2)) seconds.")


            elseif new_cost_2swap < current_cost
                # Better solution found
                #println("Better unvisited solution accepted with cost: ", new_cost_2swap)
                destruction_outcomes[destruction_index][2] += 1  # Increment better solution counter
                construction_outcomes[construction_index][2] += 1

                current_solution = deepcopy(new_solution_2swap)  # Always accept better solutions
                current_cost = new_cost_2swap

                # Better solution found
                now_time = time() - start_time  # Calculate elapsed time
                push!(tracker.better, HeuristicOutcome(iter, now_time, destruction_index, construction_index, new_cost_2swap))
                #println("Better unvisited solution accepted with cost: $new_cost_2swap.")
            else
                # Worse but unvisited solution accepted
                #println("Worse unvisited solution accepted with cost: ", new_cost_2swap)
                destruction_outcomes[destruction_index][3] += 1  # Increment worse solution counter
                construction_outcomes[construction_index][3] += 1


                # Worse but unvisited solution accepted
                now_time = time() - start_time  # Calculate elapsed time
                push!(tracker.worse, HeuristicOutcome(iter, now_time, destruction_index, construction_index, new_cost_2swap))
                #println("Worse unvisited solution accepted with cost: $new_cost_2swap.")


                delta = new_cost_2swap - current_cost
                acceptance_probability = exp(-delta / T)

                if rand() < acceptance_probability
                    # Accept the solution
                    current_solution = deepcopy(new_solution_2swap)
                    current_cost = new_cost_2swap
                    #println("Accepted worse solution with probability $acceptance_probability.")
                else
                    # Reject the solution
                    #println("Rejected worse solution with probability $acceptance_probability.")
                end
            end
        else
            # Solution already visited
            delta = new_cost_2swap - current_cost
            acceptance_probability = exp(-delta / T)

            if rand() < acceptance_probability
                # Allow SA to accept visited solutions
                current_solution = deepcopy(new_solution_2swap)
                current_cost = new_cost_2swap
                #println("Accepted previously visited solution with probability $acceptance_probability.")
            else
                #println("Rejected previously visited solution with probability $acceptance_probability.")
            end
        end

        # Step 7: Update weights at the end of each segment
        if iter % segment_size == 0

            #println("Iteration: ", iter)
            segment = iter ÷ segment_size  # current segment number

            for i in eachindex(destruction_scores)   
                destruction_scores[i] = σ1 * destruction_outcomes[i][1] + σ2 * destruction_outcomes[i][2] + σ3 * destruction_outcomes[i][3]
            end
            for i in eachindex(construction_scores) 
                construction_scores[i] = σ1 * construction_outcomes[i][1] + σ2 * construction_outcomes[i][2] + σ3 * construction_outcomes[i][3]
            end

            for i in 1:5, j in 1:3
                cumulative_destruction_outcomes[i][j] += destruction_outcomes[i][j]
                #println("for i = ", i, " and for j = ", j, "the cumulative_destruction_outcomes[i][j] are: ", cumulative_destruction_outcomes[i][j])
            end
            for i in 1:3, j in 1:3
                cumulative_construction_outcomes[i][j] += construction_outcomes[i][j]
                #println("for i = ", i, " and for j = ", j, "the cumulative_construction_outcomes[i][j] are: ", cumulative_construction_outcomes[i][j])
            end



            destruction_weights = update_weights_normalized(destruction_weights, destruction_scores, destruction_usage_counts, r)
            construction_weights = update_weights_normalized(construction_weights, construction_scores, construction_usage_counts, r)
            push!(weight_evolution, WeightEvolution(iter, deepcopy(destruction_weights), deepcopy(construction_weights)))


            # Log statistics for this segment
            push!(stats_c, ALNS_Stats_Constructors(segment, deepcopy(construction_weights)))
            push!(stats_d, ALNS_Stats_Destructors(segment, deepcopy(destruction_weights)))


            destruction_scores .= 0.0
            destruction_usage_counts .= 0
            destruction_outcomes .= [[0, 0, 0] for _ in 1:5]

            construction_scores .= 0.0
            construction_usage_counts .= 0
            construction_outcomes .= [[0, 0, 0] for _ in 1:3]

        end

        # Step 8: Update temperature
        T *= cooling_rate
        push!(weight_evolution, WeightEvolution(iter, deepcopy(destruction_weights), deepcopy(construction_weights)))   # Update every iteraton

        # Stop early if temperature is too low
        if T < 1e-8
            println("Temperature too low, stopping early at iteration $iter")
            break
        end
    end

    elapsed_time = time() - start_time

    println("Execution Time: $(round(elapsed_time, digits=2)) seconds")
    println("Best Solution Cost: $best_cost")

    # Print summary
    println("Summary of Global Best Solutions Found:")
    for outcome in tracker.global_best
        println("Iteration: $(outcome.iteration), Time: $(round(outcome.time, digits=2)) seconds, Cost: $(round(outcome.cost, digits=2))")
    end

    println("\nTotal Number of Iterations: $iterations")
    println("Total Time to Run Algorithm: $(round(elapsed_time, digits=2)) seconds")

    return best_solution, best_cost, stats_c, stats_d, cumulative_destruction_outcomes, cumulative_construction_outcomes, tracker
end

#=
# Step 1: Generate initial solution using the greedy NN-based algorithm
visited, early_violations, early_violations_duration, late_violations, late_violations_duration, total_distance, final_time = greedy_distance(n, d, t, ei, li, h)

# Run ALNS with Greedy insertion or 2-Opt or 2-Swap
best_solution, best_cost, stats_c, stats_d, cumulative_destruction_outcomes, cumulative_construction_outcomes, tracker = ALNS_with_2swap(visited, 1000, 500, 0.99, d, t, h, ei, li, 0.5, q, 0.4, 100)

arrival_times, waiting_times, wait_nodes, early_violations, early_violation_node_indices, early_violations_duration, late_violations, late_violation_node_indices, late_violations_duration, violations, violationsEarly, violationsLate, total_waiting_time, total_cost = compute_arrival_times_weighted_step(best_solution, t, h, ei, li)
total_distance = compute_total_distance(best_solution, d)
println("The route is: ", visited)
println("The total distance is: ", total_distance)
println("Arrival times at each node (including handling times): ", arrival_times)
println("Waiting times at nodes: ", waiting_times)
println("Nodes where waiting was chosen: ", wait_nodes)

println("\nEarly violations:")
println("Nodes with early violations: ", early_violations)
println("Indices of nodes with early violations in the route: ", early_violation_node_indices)
println("Duration of early violations at each node: ", early_violations_duration)

println("\nLate violations:")
println("Nodes with late violations: ", late_violations)
println("Indices of nodes with late violations in the route: ", late_violation_node_indices)
println("Duration of late violations at each node: ", late_violations_duration)

println("\nTotal violations and waiting times:")
println("Total violation time (sum of early and late violations): ", violations)
println("Total waiting time across all nodes: ", total_waiting_time)


# Plot the weight evolution graph
plot_weights_evolution_constructors(stats_c)
savefig("constructors_plot.png")

plot_weights_evolution_destructors(stats_d)
savefig("destructors_plot.png")

# Plot cumulative outcomes for destructors
plot_cumulative_outcomes_destructors(cumulative_destruction_outcomes)
savefig("cumulative_outcomes_destructors_plot.png")

# Plot cumulative outcomes for constructors
plot_cumulative_outcomes_constructors(cumulative_construction_outcomes)
savefig("cumulative_outcomes_constructors_plot.png")

# Plot cost evolution with iterations
plot_cost_vs_iterations(tracker)
savefig("cost_evolution_with_iteerations_plot.png")
=#


