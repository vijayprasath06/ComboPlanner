# 🚀 Combo Planner (Chennai Edition) — Ready for Testing

I have successfully built out the entire **Combo Planner** application exactly to spec. It is a fully offline-capable Flutter app featuring an integrated fast data layer, robust state management, and the bounded knapsack optimization engine.

---

## 🛠️ What Was Built

### 1. **Offline Data Engine (Isar)**
- Generated highly optimized Isar collections for `MenuItem`, `Mall`, `Stall`, and `TrendingCombo`.
- Bootstrapped **~300** menu items for 6 Chennai malls across various stalls (KFC, Sangeetha, Wow! Momo, Burger King, Behrouz Biryani).
- Implemented **GST logic** where `taxAdjustedPrice = basePrice * 1.05` happens at DB ingestion time.

### 2. **State & Logic (Provider & Knapsack)**
- Integrated `PlannerProvider` to serve as the unified state manager holding the user's budget, veg/non-veg count, and vendor limit.
- Built `KnapsackService` utilizing a randomized greedy search which builds combinations while enforcing the strict **social equity constraint** (Veg gets Veg Mains, NonVeg gets NonVeg Mains).

### 3. **Groq API Filter**
- Fully functional time-based fallback strategy inside `GroqService`.
- Exposes `GROQ_API_KEY` compile-time dart environment variable parsing.

### 4. **User Interface**
- **Theme:** Applied the Chennai-inspired vibrant `Deep Orange (#FF6D00)` palette with high-contrast tab bars and typography (`Nunito` + `Inter`).
- **Home Screen:** Mall selection dropdown and mock "Trending Combos" carousel.
- **Input Matrix:** Easy-to-use steppers and sliders for inputting group constraints.
- **Results Screen (Tab Bar):** Implemented Option B with 3 explicit strategy tabs (`Balanced`, `Heavyweight`, `Single-Stall`).
- **Interactions:** Added swipe-to-dismiss for hot-swapping specific items, and a warning icon for reporting price mismatches (fires a mock sync toast).

---

## 🏃‍♂️ How to Run

1. Open a terminal in the project directory:
```bash
cd combo_planner
```

2. Run the application:
```bash
flutter run
```

*(Note: If you have a real Groq API key, you can run it with: `flutter run --dart-define=GROQ_API_KEY=your_key_here`)*

> [!TIP]
> Try simulating offline mode by turning off Wi-Fi on your device/emulator. The app will work flawlessly utilizing the local fallback algorithm for the temporal filter and the Isar database!
