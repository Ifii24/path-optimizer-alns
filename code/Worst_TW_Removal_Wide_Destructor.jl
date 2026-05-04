"""
Worst Removal TW
Removes nodes from a route based on the width of their time windows, favoring those with wider windows for more scheduling flexibility.

Input:
- solution: Vector{Int64} - the current route (including depot at the start and end)
- k: Int - number of nodes to remove
- ei: Vector{Int64} - earliest time windows vector (size n, including depot as first element)
- li: Vector{Int64} - latest time windows vector (size n, including depot as first element)

Output:
- remaining_solution: Vector{Int64} - the route with nodes removed
- removed_nodes: Vector{Int64} - the list of removed nodes
"""
function Worst_Removal_Wide_TW(solution::Vector{Int64}, percentage_to_remove::Float64, ei::Vector{Int64}, li::Vector{Int64})

    #println("We use worst removal wide TW")
    # Calculate the number of nodes to remove based on the percentage
    num_nodes_to_remove = floor(Int, percentage_to_remove * (length(solution) - 2))  # Exclude depot nodes
    k = num_nodes_to_remove

    removed_nodes = Int64[]
    remaining_solution = deepcopy(solution)

    # Initialize an empty array to store the time window widths for each node (excluding depots)
    time_window_widths = []

    # Loop through each node in the route, excluding the depots at the start and end
    for i in 2:(length(remaining_solution) - 1)
        
        #println("index i is : ", i, " for node : ", remaining_solution[i])

        # Calculate the width of the time window for the current node
        width = li[remaining_solution[i]] - ei[remaining_solution[i]]
        #println("TW width for node ", remaining_solution[i], " is: ", width)

        # Store the node index and its time window width as a tuple
        push!(time_window_widths, (i, width))

    end

    #println("TW Widths are: ", time_window_widths)


    # Sort nodes by time window width in descending order
    sorted_nodes_by_tw = sort(time_window_widths, by = x -> -x[2])  # ''-'' x[2] is for descending order in Julia
    #println("Sorted nodes by TW Widths are: ", sorted_nodes_by_tw)

    # Extract only the nodes sorted by time window width
    sorted_nodes = [x[1] for x in sorted_nodes_by_tw]
    #println("Sorted nodes by TW Widths are: ", sorted_nodes)


    # Loop until we've removed the desired number of nodes
    while length(removed_nodes) < k

        # Select the next node with the widest time window
        node_to_remove = popfirst!(sorted_nodes)
        #println("we remove node: ", node_to_remove)

        # Remove the node from the route and add it to removed_nodes
        push!(removed_nodes, node_to_remove)
        #println("removed_nodes while length(removed_nodes) is: ", length(removed_nodes), " is : ", removed_nodes)

        # Find the index of the node to remove
        index_to_remove = findfirst(x -> x == node_to_remove, remaining_solution)

        # Check if the node exists (findfirst returns nothing if the element is not found)
        if index_to_remove !== nothing
            deleteat!(remaining_solution, index_to_remove)  # Remove the node at that index
        end
    end

    return remaining_solution, removed_nodes
end

#=
ei = [0,  10, 20, 30, 40, 50, 60,  0]
li = [100, 15, 30, 45, 60, 75, 90, 100]
route = [1, 3, 2, 5, 4, 7, 6, 1] 
remaining_solution, removed_nodes = Worst_Removal_Wide_TW(route, 0.3, ei, li)


println("The remaining solution is: ", remaining_solution)
println("The removed nodes are: ", removed_nodes)
=#