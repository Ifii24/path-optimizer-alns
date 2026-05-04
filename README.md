# Sequence Building for Routing with Narrow Time Windows

**Master Thesis — DTU Management, Technical University of Denmark**  
**Authors:** Ifigeneia Tziola
**Submitted:** February 2, 2025  
**Supervisor:** Jesper Larsen  
**Degrees:** MSc Business Analytics

---

## Overview

This repository contains the full code, data, and results for my master's thesis on the **Sequence Building with Narrow Time Windows** problem which is a variant of the Traveling Salesman Problem with Time Windows (TSPTW).

The objective is to construct a route starting and ending at a depot, visiting all orders exactly once while respecting (soft) time windows. Since violations are allowed but penalized, the goal is to minimize a weighted sum of:
- Total distance
- Travel duration
- Time window violations

### Approach

A two-stage solution framework:

1. **LNS** (Large Neighbourhood Search): builds an initial sequence using destruction/repair operators
2. **ALNS** (Adaptive Large Neighbourhood Search): refines the solution by adaptively selecting the best operators using a scoring mechanism with Simulated Annealing acceptance
3. **LP post-optimization**: a linear program determines the optimal route start time, further reducing waiting times and violations

### Key Results

Tested on all **73 instances** from AMCS:
- Finds feasible solutions for **all 73 instances**
- Improves total distance in **23/25 instances** (3 min) and **24/25** (5 min) vs. AMCS's Thorough mode
- Average distance reduction: **3.33%**
- Average travel time reduction: **5.85%**

---

## Repository Structure

```
path-optimizer-alns/
│
├── code/                        # All Julia source files
│   ├── ALNS.jl                  # Main ALNS solver
│   ├── ALNS_with_SA.jl          # ALNS with Simulated Annealing
│   ├── ALNS_with_reheating.jl   # ALNS with SA reheating
│   ├── ALNS_with_SA_scores.jl   # ALNS with adaptive scoring
│   ├── ALNS_with_SA_timelimit.jl
│   ├── LNS.jl                   # Base LNS solver
│   ├── LNS_*.jl                 # LNS variants (K2, K3, 2-opt)
│   ├── LNS *.jl                 # Destructor operators
│   ├── LP.jl                    # LP post-optimization
│   ├── Data_Read.jl             # Data loading
│   ├── Constructor_function.jl  # Solution constructors
│   ├── *_Constructor.jl         # Cheapest insertion, NN greedy, regret
│   ├── *_Destructor.jl          # Worst cost, worst distance, TW removal
│   ├── Plotting_functions.jl    # Result visualisation
│   └── ...
│
├── data/                        # Benchmark instance data (73 instances)
│   ├── Orders*.csv              # Order data (locations, time windows, demand)
│   ├── Distances*.csv           # Distance matrices
│   └── VehiclesandTerminals*.csv  # Vehicle and depot info
│
├── results/                     # Experimental results
│   ├── final_results.txt        # Final benchmark results
│   ├── ALNS_parameter_tuning.xlsx
│   ├── LNS_DESTRUCTORS_CONSTRUCTORS.xlsx
│   └── LNS_simulations_results.xlsx
│
└── docs/
    └── Thesis.pdf               # Full thesis document
```

---

## How to Run

### Requirements
- [Julia](https://julialang.org/downloads/) (tested with Julia 1.x)
- Packages: `JuMP`, `GLPK` (or another LP solver), `CSV`, `DataFrames`, `Plots`

Install packages in Julia:
```julia
using Pkg
Pkg.add(["JuMP", "GLPK", "CSV", "DataFrames", "Plots"])
```

### Running the ALNS

```julia
include("code/Data_Read.jl")
include("code/ALNS_with_SA.jl")

# Load an instance (e.g. instance set 06, instance 01)
data = read_data("data/Orders06_01.csv", "data/Distances06_01.csv", "data/VehiclesandTerminals06_01.csv")

# Run ALNS (time limit in seconds)
solution = run_ALNS(data, time_limit=180)
```

### Data Format

Each instance consists of three files:
- `Orders<set>_<id>.csv` : order list with time windows and demand
- `Distances<set>_<id>.csv` : pairwise distance matrix
- `VehiclesandTerminals<set>_<id>.csv` : vehicle capacity and depot info

---

DTU Management, Technical University of Denmark  
Akademivej, Building 358, 2800 Kgs. Lyngby, Denmark
