# Code

All Julia source files for the LNS/ALNS framework.

## Main Solvers

| File | Description |
|------|-------------|
| `LNS.jl` | Base Large Neighbourhood Search: builds initial solution |
| `ALNS.jl` | Adaptive LNS: adaptively weights operators |
| `ALNS_with_SA.jl` | ALNS + Simulated Annealing acceptance criterion |
| `ALNS_with_SA_scores.jl` | ALNS + SA with adaptive operator scoring |
| `ALNS_with_SA_timelimit.jl` | Time-limited version of ALNS+SA |
| `ALNS_with_reheating.jl` | ALNS with SA reheating (for longer runs) |

## Constructors (build initial routes)

| File | Description |
|------|-------------|
| `Constructor_function.jl` | Main constructor dispatcher |
| `Find initial solution.jl` | Entry point for initial solution building |
| `Cheapest_Insertion_Constructor.jl` | Cheapest insertion heuristic |
| `Cheapest_insertion_heuristic.jl` | Cheapest insertion helper |
| `NN_based_greedy_algorithm.jl` | Nearest-neighbour greedy constructor |
| `regret_insertion_k2_struct.jl` | Regret-2 insertion |
| `regret_insertion_k3_struct.jl` | Regret-3 insertion |

## Destructors (remove nodes from route)

| File | Description |
|------|-------------|
| `Random_destructor_function.jl` | Random removal |
| `Worst_Cost_Removal_Destructor.jl` | Remove highest-cost nodes |
| `Worst_Distance_Removal_Destructor.jl` | Remove nodes by worst distance |
| `Worst_TW_Removal_Narrow_Destructor.jl` | Remove nodes with tightest time windows |
| `Worst_TW_Removal_Wide_Destructor.jl` | Remove nodes with widest time windows |
| `LNS random destructor.jl` | Random destructor (LNS version) |
| `LNS Worst Cost.jl` | Worst cost destructor (LNS version) |
| `LNS Worst Distance.jl` | Worst distance destructor (LNS version) |
| `LNS TW Narrow.jl` | TW narrow destructor (LNS version) |
| `LNS TW Wide.jl` | TW wide destructor (LNS version) |
| `LNS_RD_K2.jl` | Random destructor removing k=2 nodes |
| `LNS_WITH_RD_K2_AND_K3.jl` | Combined k2/k3 random destruction |

## Post-Optimization & Utilities

| File | Description |
|------|-------------|
| `LP.jl` | Linear program for optimal route start time |
| `Compute_Arrival_Times_Weighted_Step.jl` | Arrival time calculation with weighted penalties |
| `LNS_with_2_opt.jl` | 2-opt local search improvement |
| `Data_Read.jl` | Reads Orders, Distances, VehiclesandTerminals CSVs |
| `Plotting_functions.jl` | Visualisation: cost evolution, operator selection |
