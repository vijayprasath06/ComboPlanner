# Product Specification: Food Court Combo Planner (Chennai Edition)

This document serves as the master, production-grade specification for the **Food Court Combo Planner**. It details the core product vision, system architecture, algorithmic constraints, and data flows designed for high-density mall food courts in Chennai.

---

## 1. Executive Summary & Product Vision

### The Problem
Group dining in crowded mall food courts (e.g., VR Chennai, Phoenix Marketcity) introduces high cognitive friction. Groups with mixed dietary preferences, tight budgets, and limited time struggle to find an optimal combination of dishes across multiple independent vendors. This leads to budget overruns, logistical delays (standing in too many lines), and social inequity (where some members get full meals and others get snacks/beverages due to mathematical resource allocation errors).

### The Solution
A context-aware, offline-first mobile platform that dynamically generates optimized meal combinations from pre-loaded mall food court data. The system enforces strict social equity rules, incorporates real-world checkout variables (such as local tax rates), mitigates hardware dead zones using a localized database architecture, and updates dynamically via a crowdsourced data engine.

---

## 2. Core Scope & Footprint

The platform targets the major high-traffic commercial shopping hubs across Chennai:
* **VR Chennai** (Anna Nagar)
* **Phoenix Marketcity & Palladium** (Velachery)
* **Express Avenue** (Royapettah)
* **Nexus Vijaya Mall** (Vadapalani)
* **The Marina Mall** (OMR, Egattur)
* **Ampa Skywalk** (Aminjikarai)

---

## 3. Input Matrix & User Flow

The interface prioritizes a **3-Tap User Path** to eliminate decision fatigue during high-volume peak hours:

1.  **Tap 1: Location Verification**
    * System utilizes geofencing to auto-detect the mall context.
    * Manual fallback via a localized selection sheet listing the supported Chennai hubs.
2.  **Tap 2: Group Matrix & Constraints**
    * **Total Budget:** Numeric input specifying the absolute price ceiling for the entire group (INR).
    * **Group Demographics:** Split counters separating the absolute number of Vegetarian (V_c) vs. Non-Vegetarian (N_c) consumers.
    * **Max Vendor Limit:** A slider interface allowing users to limit the maximum number of stall hops permitted (e.g., maximum of 2 stalls total) to prevent group separation and cold meals.
3.  **Tap 3: Generate Matrix**
    * Compiles inputs and instantly outputs the multi-plan strategic view.

---

## 4. Backend & Client-Side Engine Architecture

To ensure high availability in network dead zones (such as mall basements), the core computing architecture uses an **Offline-First Paradigm**.

```
[User Device Interface]
       │
       ├── Reads Contextual Parameters (Time, Budget, Headcount)
       ▼
[Groq API Context Layer(Llama 3)]──(Processes Time-of-Day Filter)──► [Category Whitelist]
                                                                      │
                                                                      ▼
[Local Client Database (Hive/Isar)] ◄──(Pulls Local Menu Schema)──────┤
                                                                      │
                                                                      ▼
[Client-Side Math Engine (Dart)] ◄────────────────────────────────────┘
       │
       └── Executes Bounded Knapsack Optimization
       ▼
[UI Strategy Cards] (Balanced, Heavyweight, Single-Stall Express)
```

### Layer 1: The Temporal Gatekeeper (Groq API Filter)
Before mathematical optimization runs, the app captures the current device timestamp. It passes the current time to the Groq API (via the zero-cost tier) to filter the target item types contextually.
* **Lunch/Dinner Windows (12:00 PM - 3:30 PM, 7:00 PM - 10:30 PM):** Whitelists heavy value meals, biryanis, platters, and full main courses.
* **Snack/High-Tea Window (3:30 PM - 6:30 PM):** Filters out heavy items; whitelists beverages, chaats, finger foods, and desserts to prevent highly inappropriate meal recommendations.

### Layer 2: The Infrastructure Tax Buffer
To insulate users from checkout sticker shock, all menu base prices pulled from the local schema are subjected to a local GST multiplier calculation prior to entering the optimization phase:

**Tax Adjusted Price = Base Price * 1.05**

The UI explicitly denotes that the final calculations include the standard 5% restaurant GST cushion.

### Layer 3: Bounded Knapsack Optimization Engine
To avoid server or UI freeze-ups from combinatorially explosive nested loops over hundreds of food court items, the math engine uses a localized dynamic programming approach.
* **Social Equity Constraint:** The algorithm is programmatically blocked from outputting a valid combination unless every individual in the group matrix is allocated at least one item flagged under the "Main" course category corresponding to their dietary tag.
* **Vendor Grouping:** Items are indexed by stall ID to satisfy the user-selected vendor threshold constraint.

---

## 5. Multi-Plan Strategy Outputs & Discovery

Users are provided three distinct options to address varying group dynamics:

* **Strategy A: The Balanced Meal (Default)**
    * Distributes resources uniformly across the group matrix, ensuring every person gets an optimized mix of one Main, one Side, and one Beverage.
* **Strategy B: The Heavyweight (Maximum Volume)**
    * Omits premium beverages and small sides; aggregates the entire budget pool toward the highest-calorie, mass-optimized Mains available within the vendor constraint limits.
* **Strategy C: The Single-Stall Express**
    * Overrides the vendor slider and restricts the mathematical search space to a single stall counter. This minimizes pickup delays when the food court is overcrowded.

### Discovery Discovery Carousel: "Trending Combos"
Upon selecting a venue, users see a horizontal carousel displaying pre-calculated combinations accepted by other platform users within that specific mall over the preceding 24 hours (e.g., *"Phoenix Value Trio under ₹700"*). This offers a zero-input shortcut to skip manual configuration.

---

## 6. Resilience & Self-Healing Data Loops

To mitigate real-world operational friction like sold-out inventory or sudden price adjustments, the platform features defensive data logic:

### Single-Item Hot-Swapping
If a group member arrives at a stall counter and discovers a specific item is out of stock, they can perform a left-swipe gesture on that item card. The local Dart engine instantly flags that specific item ID as blacklisted, consumes the remaining budget balance, and re-computes the localized knapsack algorithm to replace only that item without altering the rest of the group's meals.

### Crowdsourced Validation Engine
If a user notices a price discrepancy on the physical LED menu board compared to the cached database representation:
1.  They tap the **"Report Mismatch"** interface on the target item card.
2.  The device camera captures a photo of the menu board.
3.  When a network connection is re-established, a background worker pipes the image to an OCR extraction script.
4.  The server validates the pricing correction and pushes updated data deltas to all client nodes across Chennai, keeping the shared platform data fresh.
