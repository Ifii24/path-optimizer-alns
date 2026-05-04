
"""
Input: 
- solution: Vector{Int64} - the solution (route) we want to partly destroy (vector of all nodes including the return to the Depot so size = n+1)
- percentage: Float64 - percentage of the solution we want to destroy (decimal part)

Functionalty: removes a percentage of random nodes from the solution (not consecutive)

Output: 
- remaining_solution: a vector with the remaining part of the solution (Depot is not removed from 1st and last poition)
- removed_nodes:a vector with the removed nodes 
""" 
function random_destructor(solution::Vector{Int64}, percentage::Float64)

    # Ensure the solution starts and ends with the depot (node 1)
    if solution[1] != 1 || solution[end] != 1
        error("Solution must start and end with the depot (node 1).")
    end
    
    # Number of nodes to remove
    num_nodes_to_remove = ceil(Int, (length(solution)) * percentage)  
    #println("number of nodes to remove: ", num_nodes_to_remove)

    # Ensure at least one node is removed
    num_nodes_to_remove = max(1, num_nodes_to_remove) 
    #println("number of nodes to remove (is it more than 1?): ", num_nodes_to_remove)

    # These are the indices of the nodes we can remove from in the given solution (COLLECT gives me the indices and not the actual nodes!!!)
    indices_of_nodes_in_the_soution_we_can_remove_from = collect(2:length(solution)-1)  
    #println("Indices of middle nodes we can remove from: ", indices_of_nodes_in_the_soution_we_can_remove_from)

    # Get the actual node values of these indices
    middle_nodes = solution[indices_of_nodes_in_the_soution_we_can_remove_from]  

    # Now from the actual middle nodes, randomly sample nodes to remove
    nodes_to_remove = sample(middle_nodes, num_nodes_to_remove, replace=false)  
    #println("Nodes randomly selected for removal: ", nodes_to_remove)

    removed_nodes = Int64[]
    for i in 1:length(nodes_to_remove)
        push!(removed_nodes, nodes_to_remove[i])
    end
    #println("The removed nodes are: ", removed_nodes)

    remaining_solution = filter(x -> !(x in removed_nodes), solution)
    #println("The remaining solution is: ", remaining_solution)

    return remaining_solution, removed_nodes
end