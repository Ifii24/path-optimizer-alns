using Random
using Pkg
using CSV
using DataFrames
using Dates
#Pkg.add("StatsBase")
using StatsBase

include("NN_based_greedy_algorithm.jl")
include("Random_destructor_function.jl")
include("Constructor_function.jl")
include("Data_Read.jl")
include("Compute_Arrival_Times_Weighted_Step.jl")


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


function compute_total_distance(solution::Vector{Int64}, d::Matrix{Int64})
    total_distance = 0
    for i in 2:(length(solution))
        total_distance += d[solution[i-1], solution[i]]
    end
    return total_distance
end


function compute_total_time(solution::Vector{Int64}, t::Matrix{Int64}, h::Vector{Int64})
    total_time = 0
    for i in 2:(length(solution))
        total_time += t[solution[i-1], solution[i]] + h[solution[i]]
    end
    return total_time
end


function LNS(
    initial_solution::Vector{Int64},              # NN based greedy solution
    time_limit::Float64,                          # 
    initial_temperature::Float64,                 #
    cooling_rate::Float64,                        #
    d::Matrix{Int64},                             #
    t::Matrix{Int64},                             #
    h::Vector{Int64},                             #
    ei::Vector{Int64},                            # 
    li::Vector{Int64},                            #
    q::Float64,                                   #
    percentage_to_destroy::Float64,               #
    wd::Float64,                                  #
    wt::Float64,                                  #
    wv::Float64                                   #
    )               

    # Step to avoid No method matching errors later on
    #early_violations_duration = Vector{Int64}()
    #late_violations_duration = Vector{Int64}()

    # Initialize the current solution and cost
    current_solution = deepcopy(initial_solution)
    current_time = compute_total_time(current_solution, t, h)
    current_distance = compute_total_distance(current_solution, d)

    arrival_times, waiting_times, wait_nodes, early_violations, early_violation_node_indices, early_violations_duration, late_violations, late_violation_node_indices, late_violations_duration, violations, violationsEarly, violationsLate, total_waiting_time = compute_arrival_times_weighted_step(current_solution, t, h, ei, li)
    current_cost = wd * q * current_distance + wt * current_time + wv * violationsLate  # + 0.02*violationsEarly + 0.03*total_waiting_time

    # Set the initial best solution and cost
    best_solution = deepcopy(current_solution)
    best_cost = current_cost

    # Initialize the temperature
    T = initial_temperature
    iterations = 0

    # Start tracking execution time
    start_time = time() 

    # ALNS Main Loop
    while time() - start_time < time_limit

        iterations += 1
        
        # Step 1: Apply the random destruction
        remaining_solution, removed_nodes = random_destructor(current_solution, percentage_to_destroy)

        # Step 2: Reinsert removed nodes using the construct function
        new_solution, early_violations, early_violations_duration, early_violation_node_indices, late_violations, late_violations_duration, late_violation_node_indices, violations, violationsEarly, violationsLate, total_waiting_time = construct(remaining_solution, removed_nodes, length(initial_solution), d, t, h, ei, li, q)
        new_distance = compute_total_distance(new_solution, d)

        # Step 3: Perform **Single Iteration** Local Search using 2-swap on the new solution
        new_distance_2swap, new_solution_2swap = SingleIterationLocalSearch2Swap(new_solution, new_distance, d)

        # Step 4: Compute the cost of the new solution
        new_time_2swap = compute_total_time(new_solution_2swap, t, h)
        
        arrival_times, waiting_times, wait_nodes, early_violations, early_violation_node_indices, early_violations_duration, late_violations, late_violation_node_indices, late_violations_duration, violations, violationsEarly, violationsLate, total_waiting_time = compute_arrival_times_weighted_step(new_solution_2swap, t, h, ei, li)
        new_cost_2swap = wd * q * new_distance_2swap + wt * new_time_2swap + wv * violationsLate # + 0.02*total_waiting_time  + 0.03*violationsEarly       #violations = sum(early_violations_duration) + sum(late_violations_duration)

        # Step 5: Determine whether to accept the new solution
        if new_cost_2swap < current_cost 
            # If the new solution is better, accept it
            current_solution = deepcopy(new_solution_2swap)
            current_cost = new_cost_2swap
            #println("Accepted better solution with cost: $current_cost")
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
           # println("New best solution found with cost: $best_cost")
        end

        # Step 7: Decrease the temperature
        #println(" T before: ", T)
        T *= cooling_rate
        #println(" T after: ", T)

        # Optionally: Break if temperature is too low or if cost improvement is minimal
        if T < 1e-8
            println("Temperature too low, stopping early.")
            break
        end
    end

    return best_solution, best_cost
end


# Step 1: Generate initial solution using the greedy NN-based algorithm
#visited02, early_violations02, early_violations_duration02, late_violations02, late_violations_duration02, total_distance02, final_time02 = greedy_distance(n02, d02, t02, ei02, li02, h02)
#visited03, early_violations03, early_violations_duration03, late_violations03, late_violations_duration03, total_distance03, final_time03 = greedy_distance(n03, d03, t03, ei03, li03, h03)
visited01B, early_violations01B, early_violations_duration01B, late_violations01B, late_violations_duration01B, total_distance01B, final_time01B = greedy_distance(n01B, d01B, t01B, ei01B, li01B, h01B)
visited05_16, early_violations05_16, early_violations_duration05_16, late_violations05_16, late_violations_duration05_16, total_distance05_16, final_time05_16 = greedy_distance(n05_16, d05_16, t05_16, ei05_16, li05_16, h05_16)
visited06_16, early_violations06_16, early_violations_duration06_16, late_violations06_16, late_violations_duration06_16, total_distance06_16, final_time06_16 = greedy_distance(n06_16, d06_16, t06_16, ei06_16, li06_16, h06_16)
visited08_02_modified, early_violations08_02_modified, early_violations_duration08_02_modified, late_violations08_02_modified, late_violations_duration08_02_modified, total_distance08_02_modified, final_time08_02_modified = greedy_distance(n08_02_modified, d08_02_modified, t08_02_modified, ei08_02_modified, li08_02_modified, h08_02_modified)
#visited09, early_violations09, early_violations_duration09, late_violations09, late_violations_duration09, total_distance09, final_time09 = greedy_distance(n09, d09, t09, ei09, li09, h09)
#visited10, early_violations10, early_violations_duration10, late_violations10, late_violations_duration10, total_distance10, final_time10 = greedy_distance(n10, d10, t10, ei10, li10, h10)

time_limit = 15.0
initial_temperature = 100000000.0
cooling_rate = 0.99
percentage_to_destroy = 0.4


weights = [
    (0.3, 0.4, 0.3),
    (0.4, 0.4, 0.2),
    (0.5, 0.3, 0.2),
    (0.35, 0.35, 0.3),
    (0.45, 0.35, 0.2),
    (0.2, 0.4, 0.4),
    (0.15, 0.4, 0.45),
    (0.3, 0.3, 0.4),
    (0.25, 0.35, 0.4)
]

for (wd, wt, wv) in weights

    println("WEIGHTS ARE: wd = ", wd, " and wt = ", wt, " and wv = ", wv, "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    #=
    #Set 01B
    best_solution_01B_1, best_cost_01B_1 = LNS(visited01B, time_limit, initial_temperature, cooling_rate, d01B, t01B, h01B, ei01B, li01B, q01B, percentage_to_destroy, wd, wt, wv)
    best_solution_01B_2, best_cost_01B_2 = LNS(visited01B, time_limit, initial_temperature, cooling_rate, d01B, t01B, h01B, ei01B, li01B, q01B, percentage_to_destroy, wd, wt, wv)
    best_solution_01B_3, best_cost_01B_3 = LNS(visited01B, time_limit, initial_temperature, cooling_rate, d01B, t01B, h01B, ei01B, li01B, q01B, percentage_to_destroy, wd, wt, wv)

    arrival_times_01B_1, waiting_times_01B_1, _, _, _, early_violations_duration_01B_1, _, _, late_violations_duration_01B_1, violations_01B_1, _, _, total_waiting_time_01B_1, _ = compute_arrival_times_weighted_step(best_solution_01B_1, t01B, h01B, ei01B, li01B)
    arrival_times_01B_2, waiting_times_01B_2, _, _, _, early_violations_duration_01B_2, _, _, late_violations_duration_01B_2, violations_01B_2, _, _, total_waiting_time_01B_2, _ = compute_arrival_times_weighted_step(best_solution_01B_2, t01B, h01B, ei01B, li01B)
    arrival_times_01B_3, waiting_times_01B_3, _, _, _, early_violations_duration_01B_3, _, _, late_violations_duration_01B_3, violations_01B_3, _, _, total_waiting_time_01B_3, _ = compute_arrival_times_weighted_step(best_solution_01B_3, t01B, h01B, ei01B, li01B)

    total_distance_01B_1 = compute_total_distance(best_solution_01B_1, d01B)
    total_distance_01B_2 = compute_total_distance(best_solution_01B_2, d01B)
    total_distance_01B_3 = compute_total_distance(best_solution_01B_3, d01B)

    total_time_01B_1 = compute_total_time(best_solution_01B_1, t01B, h01B)
    total_time_01B_2 = compute_total_time(best_solution_01B_2, t01B, h01B)
    total_time_01B_3 = compute_total_time(best_solution_01B_3, t01B, h01B)

    println("Dataset: 01B")
    println("best_solutions for 01B: 1: ", best_solution_01B_1)
    println("best_costs for 01B: 1: ", best_cost_01B_1)
    println("total_distance for 01B: 1: ", total_distance_01B_1, " and 2: ", total_distance_01B_2, " and 3: ", total_distance_01B_3)
    println("total_time for 01B: 1: ", total_time_01B_1, " and 2: ", total_time_01B_2, " and 3: ", total_time_01B_3)
    println("arrival times for 01B: 1: ", arrival_times_01B_1[1], " and 2: ", arrival_times_01B_2[1], " and 3: ", arrival_times_01B_3[1])
    println("waiting times for 01B: 1: ", waiting_times_01B_1, " and 2: ", waiting_times_01B_2, " and 3: ", waiting_times_01B_3)
    println("Early violations durations for 01B: 1: ", early_violations_duration_01B_1, " and 2: ", early_violations_duration_01B_2, " and 3: ", early_violations_duration_01B_3)
    println("late violations durations for 01B: 1: ", late_violations_duration_01B_1, " and 2: ", late_violations_duration_01B_2, " and 3: ", late_violations_duration_01B_3)
    println("Total violations durations for 01B: 1: ", violations_01B_1, " and 2: ", violations_01B_2, " and 3: ", violations_01B_3)
    println("Total waiting times for 01B: 1: ", total_waiting_time_01B_1, " and 2: ", total_waiting_time_01B_2, " and 3: ", total_waiting_time_01B_3)


    #Set 05_16
    best_solution_05_16_1, best_cost_05_16_1 = LNS(visited05_16, time_limit, initial_temperature, cooling_rate, d05_16, t05_16, h05_16, ei05_16, li05_16, q05_16, percentage_to_destroy, wd, wt, wv)
    best_solution_05_16_2, best_cost_05_16_2 = LNS(visited05_16, time_limit, initial_temperature, cooling_rate, d05_16, t05_16, h05_16, ei05_16, li05_16, q05_16, percentage_to_destroy, wd, wt, wv)
    best_solution_05_16_3, best_cost_05_16_3 = LNS(visited05_16, time_limit, initial_temperature, cooling_rate, d05_16, t05_16, h05_16, ei05_16, li05_16, q05_16, percentage_to_destroy, wd, wt, wv)

    arrival_times_05_16_1, waiting_times_05_16_1, _, _, _, early_violations_duration_05_16_1, _, _, late_violations_duration_05_16_1, violations_05_16_1, _, _, total_waiting_time_05_16_1, _ = compute_arrival_times_weighted_step(best_solution_05_16_1, t05_16, h05_16, ei05_16, li05_16)
    arrival_times_05_16_2, waiting_times_05_16_2, _, _, _, early_violations_duration_05_16_2, _, _, late_violations_duration_05_16_2, violations_05_16_2, _, _, total_waiting_time_05_16_2, _ = compute_arrival_times_weighted_step(best_solution_05_16_2, t05_16, h05_16, ei05_16, li05_16)
    arrival_times_05_16_3, waiting_times_05_16_3, _, _, _, early_violations_duration_05_16_3, _, _, late_violations_duration_05_16_3, violations_05_16_3, _, _, total_waiting_time_05_16_3, _ = compute_arrival_times_weighted_step(best_solution_05_16_3, t05_16, h05_16, ei05_16, li05_16)

    total_distance_05_16_1 = compute_total_distance(best_solution_05_16_1, d05_16)
    total_distance_05_16_2 = compute_total_distance(best_solution_05_16_2, d05_16)
    total_distance_05_16_3 = compute_total_distance(best_solution_05_16_3, d05_16)

    total_time_05_16_1 = compute_total_time(best_solution_05_16_1, t05_16, h05_16)
    total_time_05_16_2 = compute_total_time(best_solution_05_16_2, t05_16, h05_16)
    total_time_05_16_3 = compute_total_time(best_solution_05_16_3, t05_16, h05_16)

    println("Dataset: 05_16")
    println("best_solutions for 05_16: 1: ", best_solution_05_16_1)
    println("best_costs for 05_16: 1: ", best_cost_05_16_1)
    println("total_distance for 05_16: 1: ", total_distance_05_16_1, " and 2: ", total_distance_05_16_2, " and 3: ", total_distance_05_16_3)
    println("total_time for 05_16: 1: ", total_time_05_16_1, " and 2: ", total_time_05_16_2, " and 3: ", total_time_05_16_3)
    println("arrival times for 05_16: 1: ", arrival_times_05_16_1[1], " and 2: ", arrival_times_05_16_2[1], " and 3: ", arrival_times_05_16_3[1])
    println("waiting times for 05_16: 1: ", waiting_times_05_16_1, " and 2: ", waiting_times_05_16_2, " and 3: ", waiting_times_05_16_3)
    println("Early violations durations for 05_16: 1: ", early_violations_duration_05_16_1, " and 2: ", early_violations_duration_05_16_2, " and 3: ", early_violations_duration_05_16_3)
    println("late violations durations for 05_16: 1: ", late_violations_duration_05_16_1, " and 2: ", late_violations_duration_05_16_2, " and 3: ", late_violations_duration_05_16_3)
    println("Total violations durations for 05_16: 1: ", violations_05_16_1, " and 2: ", violations_05_16_2, " and 3: ", violations_05_16_3)
    println("Total waiting times for 05_16: 1: ", total_waiting_time_05_16_1, " and 2: ", total_waiting_time_05_16_2, " and 3: ", total_waiting_time_05_16_3)


    #Set 06_16
    best_solution_06_16_1, best_cost_06_16_1 = LNS(visited06_16, time_limit, initial_temperature, cooling_rate, d06_16, t06_16, h06_16, ei06_16, li06_16, q06_16, percentage_to_destroy, wd, wt, wv)
    best_solution_06_16_2, best_cost_06_16_2 = LNS(visited06_16, time_limit, initial_temperature, cooling_rate, d06_16, t06_16, h06_16, ei06_16, li06_16, q06_16, percentage_to_destroy, wd, wt, wv)
    best_solution_06_16_3, best_cost_06_16_3 = LNS(visited06_16, time_limit, initial_temperature, cooling_rate, d06_16, t06_16, h06_16, ei06_16, li06_16, q06_16, percentage_to_destroy, wd, wt, wv)

    arrival_times_06_16_1, waiting_times_06_16_1, _, _, _, early_violations_duration_06_16_1, _, _, late_violations_duration_06_16_1, violations_06_16_1, _, _, total_waiting_time_06_16_1, _ = compute_arrival_times_weighted_step(best_solution_06_16_1, t06_16, h06_16, ei06_16, li06_16)
    arrival_times_06_16_2, waiting_times_06_16_2, _, _, _, early_violations_duration_06_16_2, _, _, late_violations_duration_06_16_2, violations_06_16_2, _, _, total_waiting_time_06_16_2, _ = compute_arrival_times_weighted_step(best_solution_06_16_2, t06_16, h06_16, ei06_16, li06_16)
    arrival_times_06_16_3, waiting_times_06_16_3, _, _, _, early_violations_duration_06_16_3, _, _, late_violations_duration_06_16_3, violations_06_16_3, _, _, total_waiting_time_06_16_3, _ = compute_arrival_times_weighted_step(best_solution_06_16_3, t06_16, h06_16, ei06_16, li06_16)

    total_distance_06_16_1 = compute_total_distance(best_solution_06_16_1, d06_16)
    total_distance_06_16_2 = compute_total_distance(best_solution_06_16_2, d06_16)
    total_distance_06_16_3 = compute_total_distance(best_solution_06_16_3, d06_16)

    total_time_06_16_1 = compute_total_time(best_solution_06_16_1, t06_16, h06_16)
    total_time_06_16_2 = compute_total_time(best_solution_06_16_2, t06_16, h06_16)
    total_time_06_16_3 = compute_total_time(best_solution_06_16_3, t06_16, h06_16)

    println("Dataset: 06_16")
    println("best_solutions for 06_16: 1: ", best_solution_06_16_1)
    println("best_costs for 06_16: 1: ", best_cost_06_16_1)
    println("total_distance for 06_16: 1: ", total_distance_06_16_1, " and 2: ", total_distance_06_16_2, " and 3: ", total_distance_06_16_3)
    println("total_time for 06_16: 1: ", total_time_06_16_1, " and 2: ", total_time_06_16_2, " and 3: ", total_time_06_16_3)
    println("arrival times for 06_16: 1: ", arrival_times_06_16_1[1], " and 2: ", arrival_times_06_16_2[1], " and 3: ", arrival_times_06_16_3[1])
    println("waiting times for 06_16: 1: ", waiting_times_06_16_1, " and 2: ", waiting_times_06_16_2, " and 3: ", waiting_times_06_16_3)
    println("Early violations durations for 06_16: 1: ", early_violations_duration_06_16_1, " and 2: ", early_violations_duration_06_16_2, " and 3: ", early_violations_duration_06_16_3)
    println("late violations durations for 06_16: 1: ", late_violations_duration_06_16_1, " and 2: ", late_violations_duration_06_16_2, " and 3: ", late_violations_duration_06_16_3)
    println("Total violations durations for 06_16: 1: ", violations_06_16_1, " and 2: ", violations_06_16_2, " and 3: ", violations_06_16_3)
    println("Total waiting times for 06_16: 1: ", total_waiting_time_06_16_1, " and 2: ", total_waiting_time_06_16_2, " and 3: ", total_waiting_time_06_16_3)
=#
    #Set 08_02_modified
    best_solution_08_02_1, best_cost_08_02_1 = LNS(visited08_02_modified, time_limit, initial_temperature, cooling_rate, d08_02_modified, t08_02_modified, h08_02_modified, ei08_02_modified, li08_02_modified, q08_02_modified, percentage_to_destroy, wd, wt, wv)
    best_solution_08_02_2, best_cost_08_02_2 = LNS(visited08_02_modified, time_limit, initial_temperature, cooling_rate, d08_02_modified, t08_02_modified, h08_02_modified, ei08_02_modified, li08_02_modified, q08_02_modified, percentage_to_destroy, wd, wt, wv)
    best_solution_08_02_3, best_cost_08_02_3 = LNS(visited08_02_modified, time_limit, initial_temperature, cooling_rate, d08_02_modified, t08_02_modified, h08_02_modified, ei08_02_modified, li08_02_modified, q08_02_modified, percentage_to_destroy, wd, wt, wv)

    arrival_times_08_02_1, waiting_times_08_02_1, _, _, _, early_violations_duration_08_02_1, _, _, late_violations_duration_08_02_1, violations_08_02_1, _, _, total_waiting_time_08_02_1, _ = compute_arrival_times_weighted_step(best_solution_08_02_1, t08_02_modified, h08_02_modified, ei08_02_modified, li08_02_modified)
    arrival_times_08_02_2, waiting_times_08_02_2, _, _, _, early_violations_duration_08_02_2, _, _, late_violations_duration_08_02_2, violations_08_02_2, _, _, total_waiting_time_08_02_2, _ = compute_arrival_times_weighted_step(best_solution_08_02_2, t08_02_modified, h08_02_modified, ei08_02_modified, li08_02_modified)
    arrival_times_08_02_3, waiting_times_08_02_3, _, _, _, early_violations_duration_08_02_3, _, _, late_violations_duration_08_02_3, violations_08_02_3, _, _, total_waiting_time_08_02_3, _ = compute_arrival_times_weighted_step(best_solution_08_02_3, t08_02_modified, h08_02_modified, ei08_02_modified, li08_02_modified)
       
    total_distance_08_02_1 = compute_total_distance(best_solution_08_02_1, d08_02_modified)
    total_distance_08_02_2 = compute_total_distance(best_solution_08_02_2, d08_02_modified)
    total_distance_08_02_3 = compute_total_distance(best_solution_08_02_3, d08_02_modified)

    total_time_08_02_1 = compute_total_time(best_solution_08_02_1, t08_02_modified, h08_02_modified)
    total_time_08_02_2 = compute_total_time(best_solution_08_02_2, t08_02_modified, h08_02_modified)
    total_time_08_02_3 = compute_total_time(best_solution_08_02_3, t08_02_modified, h08_02_modified)
  
    println("Dataset: 08_02")
    println("best_solutions for 08_02: 1: ", best_solution_08_02_1)
    println("best_costs for 08_02: 1: ", best_cost_08_02_1)
    println("total_distance for 08_02: 1: ", total_distance_08_02_1, " and 2: ", total_distance_08_02_2, " and 3: ", total_distance_08_02_3)
    println("total_time for 08_02: 1: ", total_time_08_02_1, " and 2: ", total_time_08_02_2, " and 3: ", total_time_08_02_3)
    println("arrival times for 08_02: 1: ", arrival_times_08_02_1[1], " and 2: ", arrival_times_08_02_2[1], " and 3: ", arrival_times_08_02_3[1])
    println("waiting times for 08_02: 1: ", waiting_times_08_02_1, " and 2: ", waiting_times_08_02_2, " and 3: ", waiting_times_08_02_3)
    println("Early violations durations for 08_02: 1: ", early_violations_duration_08_02_1, " and 2: ", early_violations_duration_08_02_2, " and 3: ", early_violations_duration_08_02_3)
    println("late violations durations for 08_02: 1: ", late_violations_duration_08_02_1, " and 2: ", late_violations_duration_08_02_2, " and 3: ", late_violations_duration_08_02_3)
    println("Total violations durations for 08_02: 1: ", violations_08_02_1, " and 2: ", violations_08_02_2, " and 3: ", violations_08_02_3)
    println("Total waiting times for 08_02: 1: ", total_waiting_time_08_02_1, " and 2: ", total_waiting_time_08_02_2, " and 3: ", total_waiting_time_08_02_3)
end

