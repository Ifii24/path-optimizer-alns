# Data

Benchmark instances provided by AMCS. Each instance consists of three paired CSV files.

## File Naming Convention

```
Orders<set>_<id>.csv              — order list
Distances<set>_<id>.csv          — distance matrix
VehiclesandTerminals<set>_<id>.csv  — vehicle and depot info
```

## Instance Sets

| Set | IDs | Notes |
|-----|-----|-------|
| 01 | A, B, C, D, Large | Small to large scale, set A–D + a large instance |
| 02 | — | Single instance |
| 03 | — | Single instance |
| 04 | A, B | Two variants |
| 05 | 01–18 | 18 instances |
| 06 | 01–16 | 16 instances |
| 07 | 01–17 (+modified) | 17 instances, some with modified versions |
| 08 | 01–04 (+modified) | 4 instances, some with modified versions |
| 09 | — | Single instance |
| 10 | — | Single instance |

**Total: 73 instances**

## File Contents

**Orders file** — one row per order:
- Order ID, location coordinates, time window (earliest/latest), demand, service time

**Distances file** — pairwise distance matrix between all locations (depot + orders)

**VehiclesandTerminals file** — vehicle capacity, depot location, number of vehicles
