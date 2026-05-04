"""
Longest Distance Removal Destroy Operator
Removes nodes from a route based on the highest distance sum to their neighboring nodes.

Input:
- solution: Vector{Int64} - the current route (including depot at the start and end)
- d: Matrix{Int64} - distance matrix (n x n)
- k: Int - number of nodes to remove

Output:
- remaining_solution: Vector{Int64} - the route with nodes removed
- removed_nodes: Vector{Int64} - the list of removed nodes
"""
function Distance_Based_Removal(solution::Vector{Int64}, d::Matrix{Int64}, percentage_to_remove::Float64)
    
    #println("we use worst distance removal")
    # Calculate the number of nodes to remove based on the percentage
    num_nodes_to_remove = floor(Int, percentage_to_remove * (length(solution) - 2))  # Exclude depot nodes
    k = num_nodes_to_remove

    removed_nodes = Int64[]
    remaining_solution = deepcopy(solution)  # Start with a copy of the solution

    # Loop until we've removed the desired number of nodes
    while length(removed_nodes) < k
        worstD = 0
        iWorst = 0  # Track the index of the node with the highest distance sum

        # Iterate over each node in the route, excluding depot at start and end
        for i in 2:(length(remaining_solution) - 1)
            prior_node = remaining_solution[i - 1]
            current_node = remaining_solution[i]
            next_node = remaining_solution[i + 1]

            # Calculate the distance sum for the current node
            priorD = d[prior_node, current_node]
            nextD = d[current_node, next_node]
            sumD = priorD + nextD

            # Update worst_distance and iWorst if this node has a higher distance sum
            if sumD > worstD
                worstD = sumD
                iWorst = i
            end
        end

        # Remove the node with the highest distance sum
        push!(removed_nodes, remaining_solution[iWorst])  # Add to removed nodes list
        deleteat!(remaining_solution, iWorst)  # Remove from the route
    end

    return remaining_solution, removed_nodes
end

#=
route = [1, 73, 47, 21, 42, 55, 3, 59, 64, 25, 24, 29, 57, 65, 61, 71, 72, 66, 67, 91, 44, 56, 62, 60, 76, 75, 74, 63, 18, 78, 77, 79, 68, 69, 70, 81, 80, 82, 83, 84, 85, 86, 87, 88, 90, 89, 92, 93, 94, 95, 97, 96, 102, 98, 99, 100, 101, 38, 28, 30, 31, 32, 37, 33, 34, 35, 36, 27, 39, 20, 23, 26, 22, 19, 13, 15, 14, 7, 8, 9, 10, 11, 12, 40, 41, 43, 45, 46, 48, 49, 53, 54, 4, 5, 58, 16, 17, 6, 50, 51, 52, 2, 1]
remaining_solution, removed_nodes = Distance_Based_Removal(route, d, 0.5)

println("The remaining solution is: ", remaining_solution)
println("The removed nodes are: ", removed_nodes)
=#