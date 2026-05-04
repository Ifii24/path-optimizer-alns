using Random
using Pkg
using CSV
using DataFrames
using Dates
#Pkg.add("StatsBase")
using StatsBase

include("NN based greedy algorithm.jl")
include("Random destructor function.jl")
include("Constructor function.jl")
include("Data Read.jl")

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

# Exhaustive LS
function RecursiveLocalSearch(current_best_route::Vector{Int64}, current_best_dist::Int64, d::Matrix{Int64}, iteration = 1)
    neighborhood, dist = Two_Opt_Heuristic(current_best_route, d) # Generate neighbors and their distances
    updated_best_route, updated_best_dist = Select_Best_Neighbor(neighborhood, dist, current_best_route, current_best_dist) # find the best neighbor amongst the neighborhood and its total traveled cost
    if updated_best_dist < current_best_dist # Check for improvement
        return RecursiveLocalSearch(updated_best_route, updated_best_dist, d, iteration + 1) # Recurse with the improved solution
    else
        return current_best_dist, current_best_route # If no improvement, return the current best solution
    end
end

# Single Iteration LS
function SingleIterationLocalSearch(current_best_route::Vector{Int64}, current_best_dist::Int64, d::Matrix{Int64})
    # Generate neighbors and their distances in one pass
    neighborhood, dist = Two_Opt_Heuristic(current_best_route, d)
    
    # Select the best neighbor from the generated neighborhood
    current_best_route, current_best_dist = Select_Best_Neighbor(neighborhood, dist, current_best_route, current_best_dist)    # best_route = best_neighbor
    
    return current_best_dist, current_best_route
end


function LNS2Opt(
    initial_solution::Vector{Int64},              # NN based greedy solution
    #early_violations::Vector{Int64},              #      
    #early_violations_duration::Vector{Int64},     #
    #late_violations::Vector{Int64},               #
    #late_violations_duration::Vector{Int64},      #
    max_iterations::Int64,                        #
    initial_temperature::Float64,                 #
    cooling_rate::Float64,                        #
    d::Matrix{Int64},                             #
    t::Matrix{Int64},                             #
    h::Vector{Int64},                             #
    ei::Vector{Int64},                            # 
    li::Vector{Int64},                            #
    q::Float64,                                   #
    percentage_to_destroy::Float64)               #

    # Step to avoid No method matching errors later on
    #early_violations_duration = Vector{Int64}()
    #late_violations_duration = Vector{Int64}()

    # Initialize the current solution and cost
    current_solution = deepcopy(initial_solution)
    current_time = compute_total_time(current_solution, t, h)
    current_distance = compute_total_distance(current_solution, d)

    arrival_times, waiting_times, wait_nodes, early_violations, early_violation_node_indices, early_violations_duration, late_violations, late_violation_node_indices, late_violations_duration, violations, violationsEarly, violationsLate, total_waiting_time = compute_arrival_times_weighted_step(current_solution, t, h, ei, li)
    current_cost = 0.4 * q * current_distance + 0.4 * current_time + 0.2 * violationsLate  # + 0.02*violationsEarly + 0.03*total_waiting_time

    # Set the initial best solution and cost
    best_solution = deepcopy(current_solution)
    best_cost = current_cost

    # Initialize the temperature
    T = initial_temperature

    for iteration in 1:max_iterations
        println("Iteration: $iteration, Temperature: $T")
        
        # Step 1: Apply the random destruction
        remaining_solution, removed_nodes = random_destructor(current_solution, percentage_to_destroy)

        # Step 2: Reinsert removed nodes using the construct function
        new_solution, early_violations, early_violations_duration, early_violation_node_indices, late_violations, late_violations_duration, late_violation_node_indices, violations, violationsEarly, violationsLate, total_waiting_time = construct(remaining_solution, removed_nodes, length(initial_solution), d, t, h, ei, li, q)
        new_distance = compute_total_distance(new_solution, d)

        # Step 3: Perform **Single Iteration** Local Search using 2-Opt on the new solution
        new_distance_2opt, new_solution_2opt = SingleIterationLocalSearch(new_solution, new_distance, d)

        # Step 3: Perform **Recursive** Local Search using 2-Opt on the new solution
        #new_distance, new_solution = RecursiveLocalSearch(new_solution, new_distance, d)

        # Step 4: Compute the cost of the new solution
        new_distance = compute_total_distance(new_solution_2opt, d) # ????????????????????/ maybe redundant ?????????????????? check if the numbers align ??????????????????????????
        new_time = compute_total_time(new_solution_2opt, t, h)
        
        arrival_times, waiting_times, wait_nodes, early_violations, early_violation_node_indices, early_violations_duration, late_violations, late_violation_node_indices, late_violations_duration, violations, violationsEarly, violationsLate, total_waiting_time = compute_arrival_times_weighted_step(new_solution_2opt, t, h, ei, li)
        new_cost_2opt = 0.4 * q * new_distance + 0.4 * new_time + 0.2 * violationsLate # + 0.02*total_waiting_time  + 0.03*violationsEarly       #violations = sum(early_violations_duration) + sum(late_violations_duration)

        # Step 5: Determine whether to accept the new solution
        if new_cost_2opt < current_cost 
            # If the new solution is better, accept it
            current_solution = deepcopy(new_solution_2opt)
            current_cost = new_cost_2opt
            println("Accepted better solution with cost: $current_cost")
        end
#=
        else
            # If the new solution is worse, accept it with a probability based on the SA criterion
            accept_probability = exp((current_cost - new_cost) / T)
            if rand() < accept_probability
                current_solution = deepcopy(new_solution)
                current_cost = new_cost
                println("Accepted worse solution with cost: $current_cost, P(accept): $accept_probability")
            end
        end
=#
        # Step 6: Update the best solution found so far
        if current_cost < best_cost
            best_solution = deepcopy(current_solution)
            best_cost = current_cost
            println("New best solution found with cost: $best_cost")
        end

        # Step 7: Decrease the temperature
        T *= cooling_rate

        # Optionally: Break if temperature is too low or if cost improvement is minimal
        if T < 1e-8
            println("Temperature too low, stopping early.")
            break
        end
    end

    return best_solution, best_cost
end

