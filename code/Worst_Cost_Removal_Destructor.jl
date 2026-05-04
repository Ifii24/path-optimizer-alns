"""
removeCost function
Calculates the impact on total cost (distance, time, and time window violations) when a node is removed from the route

Input:
- route: Vector{Int64} - the current route (including depot at the start and end)
- i: Int - the index of the node to remove
- d: Matrix{Int64} - distance matrix (n x n)
- t: Matrix{Int64} - time matrix (n x n)
- h: Vector{Int64} - handling times vector (size n)
- ei: Vector{Int64} - earliest time windows vector (size n)
- li: Vector{Int64} - latest time windows vector (size n)

Output:
- cost_impact: Int - the total cost impact of removing the node at i
"""
function removeCost(route::Vector{Int64}, i::Int, d::Matrix{Int64}, t::Matrix{Int64}, h::Vector{Int64}, ei::Vector{Int64}, li::Vector{Int64})
    # Extract nodes before and after the node to be removed
    prev_node = route[i - 1]
    current_node = route[i]
    next_node = route[i + 1]

    # Calculate Distance Impact
    original_distance = d[prev_node, current_node] + d[current_node, next_node]
    new_distance = d[prev_node, next_node]
    distance_impact = new_distance - original_distance   # positive or negative
                                                         # positive means new > old --> not a good node to remove
                                                         # negative means new < old --> a good node to remove

    # Calculate Time Impact
    original_time = t[prev_node, current_node] + h[current_node] + t[current_node, next_node]
    new_time = t[prev_node, next_node]
    time_impact = new_time - original_time

    # Calculate Violation Impact
    # Create a temporary route without the current node
    temp_route = deepcopy(route)
    deleteat!(temp_route, i)

    # Calculate arrival times and violations for the original route and the modified route
    _, _, _, _, _, _, _, _, _, original_violations, _, _, _, _ = compute_arrival_times_weighted_step(route, t, h, ei, li)
    _, _, _, _, _, _, _, _, _, temp_violations, _, _, _, _ = compute_arrival_times_weighted_step(temp_route, t, h, ei, li)

    violation_impact = temp_violations - original_violations

    # Combine distance impact, time impact, and violation impact

    # ************************************************HERE Adjust the weghts***********************************************************
    cost_impact = 0.1 * distance_impact + 0.1 * time_impact + 0.8 * violation_impact
    # *********************************************************************************************************************************

    return cost_impact
end



function Worst_Cost_Removal(solution::Vector{Int64}, percentage_to_remove::Float64, d::Matrix{Int64}, t::Matrix{Int64}, h::Vector{Int64}, ei::Vector{Int64}, li::Vector{Int64}, Pworst::Int = 3)

    #println("Using Worst Cost Removal")

    # Step 1: Calculate the number of nodes to remove
    num_nodes_to_remove = floor(Int, percentage_to_remove * (length(solution) - 2))  # Exclude depot nodes
    k = num_nodes_to_remove

    # Step 2: Calculate the cost associated with removing each node in the route
    removal_costs = []
    for i in 2:(length(solution) - 1)
        cost = removeCost(solution, i, d, t, h, ei, li)  # Calculate the cost impact of removing node at index i
        push!(removal_costs, (i, cost))                            # Store the node index and cost as a tuple
    end # by the end of this loop we have the cost impacts of removing each node, separately, from the route

    # Step 3: Sort the removal costs by the cost value (second item in each tuple) in ascending order
    sorted_costs = sort(removal_costs, by = x -> x[2])  # for a solution of 103 (depot counted twice), sorted_costs has length 101 and it's the cost of removing each node apart from the depot
 
    # Step 4: Extract only the indices of nodes in sorted order
    sorted_indices = []
    for item in sorted_costs
        push!(sorted_indices, item[1])  # store only the node index from each tuple in asending order - same as above with length 101
    end

    # Step 5: Select unique positions of nodes to remove using Vector
    selected_positions = Vector{Int64}()  # Vector to track selected positions

    while length(selected_positions) < k
        y = rand()
        pos = floor(Int, y * Pworst * length(sorted_indices))  # tends to choose larger pos and therefore removes nodes associated with larger costs

        # Make sure pos is within bounds (for 103 element solution, pos <= 102)
        if pos < 1
            pos = 1
        elseif pos > length(sorted_indices)
            pos = length(sorted_indices)
        end

        # Add the position if it's not already in the vector
        if !(pos in selected_positions)
            #println("pos is: ", pos) 
            push!(selected_positions, pos)
        end
    end

    # Step 6: Convert positions to indices of nodes to remove
    i_to_remove = [sorted_indices[pos] for pos in selected_positions]

    # Step 7: Determine removed nodes and remaining solution
    removed_nodes = [solution[i] for i in i_to_remove]  # Nodes to remove
    remaining_solution = solution[setdiff(1:length(solution), i_to_remove)]  # Remaining solution

    return remaining_solution, removed_nodes
end


#=
route = [1, 73, 47, 21, 42, 55, 3, 59, 64, 25, 24, 29, 57, 65, 61, 71, 72, 66, 67, 91, 44, 56, 62, 60, 76, 75, 74, 63, 18, 78, 77, 79, 68, 69, 70, 81, 80, 82, 83, 84, 85, 86, 87, 88, 90, 89, 92, 93, 94, 95, 97, 96, 102, 98, 99, 100, 101, 38, 28, 30, 31, 32, 37, 33, 34, 35, 36, 27, 39, 20, 23, 26, 22, 19, 13, 15, 14, 7, 8, 9, 10, 11, 12, 40, 41, 43, 45, 46, 48, 49, 53, 54, 4, 5, 58, 16, 17, 6, 50, 51, 52, 2, 1]
remaining_solution, removed_nodes = Worst_Cost_Removal(route, 0.3, 3)

println("The remaining solution is: ", remaining_solution)
println("The removed nodes are: ", removed_nodes)
=#



















































































#=
"""
Worst Cost Removal Function
Removes nodes from a route based on their impact on the route cost, favoring those with higher costs

Input:
- solution: Vector{Int64} - the current route (including depot at the start and end)
- k: Int - number of nodes to remove
- Pworst: Int - parameter to control the likelihood of removing higher-cost nodes (From Pisinger & Ropke 2006 -  set to 3)

Output:
- remaining_solution: Vector{Int64} - the route with nodes removed
- removed_nodes: Vector{Int64} - the list of removed nodes
"""
function Worst_Cost_Removal(solution::Vector{Int64}, percentage_to_remove::Float64, Pworst::Int = 3)
    
    println("we use worst cost removal")
    # Calculate the number of nodes to remove based on the percentage
    num_nodes_to_remove = floor(Int, percentage_to_remove * (length(solution) - 2))  # Exclude depot nodes
    k = num_nodes_to_remove

    removed_nodes = Int64[]
    remaining_solution = deepcopy(solution)

    # Step 1: Calculate the removal cost for each node in the route
    removal_costs = []
    for i in 2:(length(remaining_solution) - 1)
        cost = removeCost(remaining_solution, i, d, t, h, ei, li)  # Calculate the cost impact of removing node at index i
        push!(removal_costs, (i, cost))                            # Store the node index and cost as a tuple
    end # by the end of this loop we have the cost impacts of removing each node, separately, from the route

    # Step 2: Sort the removal costs by the cost value (second item in each tuple) in ascending order
    sorted_costs = sort(removal_costs, by = x -> x[2])  # for a solution of 103 (depot counted twice), sorted_costs has length 101 and it's the cost of removing each node apart from the depot
 
    # Step 3: Extract only the indices of nodes in sorted order
    sorted_indices = []
    for item in sorted_costs
        push!(sorted_indices, item[1])  # store only the node index from each tuple in asending order - same as above with length 101
    end
  
    #println("length sorted indices is: ", length(sorted_indices))

    # Loop until we've removed the desired percentage of nodes
    while length(removed_nodes) < k

        # Randomly select an index in the sorted list, favoring higher-cost nodes
        y = rand()  # between 0 and 1
        pos = floor(Int, y * Pworst * length(sorted_indices))

        # Make sure pos is within bounds (for 103 element solution, pos <= 102)
        pos = min(pos, (length(sorted_indices)))   # tends to choose larger pos and therefore removes nodes associated with larger costs
        println("pos is: ", pos)

        # Choose the index of the node at this position in sorted indices
        i_to_remove = sorted_indices[(pos == 0 ) ? 1 : pos]   # spanning from 2 to 102

        # Remove the node from the route and add it to removed_nodes
        push!(removed_nodes, remaining_solution[i_to_remove])
        deleteat!(remaining_solution, i_to_remove)
        deleteat!(sorted_indices, max(pos, 1))

        # Remove the node from the sorted_indices list to prevent removing it again
        #deleteat!(sorted_indices, pos == 0 ? 1 : pos)
        #sorted_indices = [i > i_to_remove ? i - 1 : i for i in sorted_indices] # every idx in sorted_indices > than i_to_remove is decreased by 1, reflecting the shifted positions in remaining_solution

    end

    return remaining_solution, removed_nodes
end

#removal_costs = [(node_index_1, cost_1), ...] = [(2, 5), (3, 20), (4, 10), (5, 25), (6, 15), (7, 30)]

sorted_indices = [2,4,6,3,5,7]
println("sorted indices before", sorted_indices)
i_to_remove = 3
sorted_indices = [i > i_to_remove ? i - 1 : i for i in sorted_indices]
sorted_indices
println("sorted indices after", sorted_indices)

route = [1, 73, 47, 21, 42, 55, 3, 59, 64, 25, 24, 29, 57, 65, 61, 71, 72, 66, 67, 91, 44, 56, 62, 60, 76, 75, 74, 63, 18, 78, 77, 79, 68, 69, 70, 81, 80, 82, 83, 84, 85, 86, 87, 88, 90, 89, 92, 93, 94, 95, 97, 96, 102, 98, 99, 100, 101, 38, 28, 30, 31, 32, 37, 33, 34, 35, 36, 27, 39, 20, 23, 26, 22, 19, 13, 15, 14, 7, 8, 9, 10, 11, 12, 40, 41, 43, 45, 46, 48, 49, 53, 54, 4, 5, 58, 16, 17, 6, 50, 51, 52, 2, 1]
remaining_solution, removed_nodes = Worst_Cost_Removal(route, 0.3, 3)

println("The remaining solution is: ", remaining_solution)
println("The removed nodes are: ", removed_nodes)
=#



