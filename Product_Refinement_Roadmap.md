# 🚀 Combo Planner: The 22-Point Master Blueprint (Final)

After a brutal audit of the initial architecture, a full mental simulation of the User Flow, and a deep-dive into the database performance and security layers, we have refined the concept into a highly feasible, viral, and mathematically sound product. 

This document serves as the canonical 22-point roadmap for building the 10/10 app.

---

## Part 1: Real Data Acquisition Pipeline (Priority 1)

### 1. The Data Scraper/Fetcher
*   **The Plan:** Build a Python ingestion script (`scripts/data_pipeline.py`) to scrape and format 100% real Indian vendor prices/combos into `assets/real_menu_data.json`. Mock data is banned.

### 2. Database Ingestion
*   **The Plan:** Update the Isar seeding logic in `LocalMenuRepository` to ingest the real JSON dataset on first launch.

---

## Part 2: Math Engine Overhauls (Algorithmic Fixes)

### 3. The "Impossible Budget" Bug (Graceful Degradation)
*   **The Flaw:** `KnapsackService` estimates the minimum budget based only on "Mains". It rejects small budgets even if users could afford "Sides" (like Samosas).
*   **The Fix:** Add a "Snack Mode" fallback. If it can't afford Mains, gracefully try to fill the budget using Sides and Beverages before failing.

### 4. The "Hidden Takeaway Tax" (Broken Budgets)
*   **The Flaw:** Indian food courts charge flat ₹10-₹30 takeaway/packaging fees per stall. The algorithm ignores this, leading to broken budgets at checkout.
*   **The Fix:** Add `packagingCharge` to the `Stall` model and factor it into the Knapsack total cost.

### 5. The "Vendor Combo" Fallacy & Prep Times
*   **The Flaw:** The algorithm buys à la carte items instead of cheaper vendor combo meals. It also ignores prep times, leading to cold food for group members.
*   **The Fix:** Add `isVendorCombo` and `estimatedPrepTimeMins` to `MenuItem`. Prioritize combos and reject plans with >10 min prep-time deltas.

### 6. The "Shared Plate" Ignorance
*   **The Flaw:** The algorithm forces every individual to get their own side dish.
*   **The Fix:** Allocate ~20% of the budget for shared plates (appetizers/sides) before distributing the rest for individual mains.

### 7. The "Pure Veg" Stall Ignorance (Cultural Flaw)
*   **The Flaw:** The algorithm assigns veg items to vegetarians, but ignores that strict vegetarians in India often refuse to eat from stalls that also serve meat (e.g., getting a Veg Burger from KFC).
*   **The Fix:** Add an `isPureVeg` boolean to the `Stall` model. Add a "Strict Pure Veg Only" toggle on the input screen. If enabled, the algorithm completely blacklists non-veg stalls for vegetarian assignments.

---

## Part 3: User Delight & UX Upgrades

### 8. "Food Tinder" Onboarding (Gamified Preferences)
*   **The Feature:** A Tinder-style swipe card stack (`onboarding_tinder_screen.dart`) where users swipe left/right on food images to train their `likedTags` and `dislikedTags` instantly without boring checkboxes.

### 9. Discount & Loyalty Aggregation
*   **The Feature:** Add checkboxes for Zomato Gold / Swiggy Dineout on the Input Screen. Apply a global 15% discount multiplier to stretch the budget further.

### 10. The Budget Slider Granularity Bug
*   **The Flaw:** The slider forces exact ₹100 increments up to an absurd ₹10,000 limit.
*   **The Fix:** Cap the max budget at a realistic ₹3,000 and increase divisions so the slider snaps smoothly in accurate ₹50 increments.

### 11. The Bill Splitter & UPI Generator
*   **The Flaw:** A "Universal QR Cart" is useless because vendor POS systems cannot read raw JSON without a merchant integration.
*   **The Fix:** Pivot to a "Bill Splitter". On the detail screen, add a "Split via WhatsApp/UPI" button. It generates a pre-filled message ("Rahul owes ₹250") with a direct UPI payment link to instantly pay the friend who swiped their card at the counter.

### 12. The Pre-Planning Paradox
*   **The Flaw:** With the new local time engine, a user cannot plan a dinner combo at 10:00 AM because the app forces breakfast items.
*   **The Fix:** Add a "When are you eating?" dropdown (Now, Lunch, Dinner, Snack) to the Input Screen that defaults to "Now".

### 13. The Single-Stall Paradox
*   **The Flaw:** If a group has Veg and Non-Veg eaters, sets Max Stalls = 1, and toggles "Strict Pure Veg Only", the algorithm crashes because a stall cannot be both purely veg and serve meat.
*   **The Fix:** Disable the Generate button and show a warning tooltip if these conflicting constraints are active.

### 14. The Butterfly Effect Swap (Localized Hot-Swaps)
*   **The Flaw:** Swiping to hot-swap an item currently blacklists it globally and reruns the entire Knapsack, completely scrambling the rest of the plan.
*   **The Fix:** Do not rerun the Knapsack on swipe. Instead, pop up a bottom sheet showing valid alternative items from the *already selected stalls* that match the exact same category and remaining per-person budget.

---

## Part 4: Deep Architectural Flaws

### 15. Geofencing Battery Drain & UI Block
*   **The Flaw:** `HomeScreen` pings high-accuracy GPS on every load, draining battery.
*   **The Fix:** Use `Geolocator.getLastKnownPosition()` for instant loading.

### 16. Authentication "Offline" Deadlocks
*   **The Flaw:** The Auth Screen hangs for 10 seconds if offline before throwing a timeout error.
*   **The Fix:** Add a network check on `initState`. If offline, disable login and show a prominent "Continue as Guest" banner.

### 17. Fragile Cloud Preferences Sync
*   **The Flaw:** If a user logs in while offline, their local food preferences are wiped to empty arrays because the Supabase fetch fails.
*   **The Fix:** Cache preferences locally in `SharedPreferences` as the source of truth, syncing to Supabase only when online.

### 18. The Guest Onboarding Trap
*   **The Flaw:** If a Guest sets up their preferences via "Food Tinder" and later logs in, the empty cloud profile overwrites and destroys their local preferences.
*   **The Fix:** Implement a "Merge on Login" strategy in `UserProvider` to retain local preferences when authenticating.

### 19. Remove the LLM Dependency
*   **The Flaw:** Using an LLM (Groq) for checking the time of day is massive overkill. 
*   **The Fix:** Delete `groq_service.dart`. Replace with a local time engine.

### 20. Remove Crowdsourced Data Friction
*   **The Flaw:** Relying on users to report price mismatches adds too much friction.
*   **The Fix:** Delete the "Report Mismatch" UI entirely now that we are using the real data Python pipeline.

### 21. Database Isolate Bottleneck (Isar Performance)
*   **The Flaw:** `KnapsackService` sends the entire massive menu database across the Isolate boundary and filters it slowly in Dart memory.
*   **The Fix:** Keep the Isar instance accessible *inside* the Isolate. Run an optimized `.filter().tags()` query inside the isolate directly on disk instead of sending lists across threads.

### 22. Total Lack of Localization & Accessibility (a11y)
*   **The Flaw:** The app is hardcoded entirely in English, and has zero semantic labels for screen readers. For an Indian market, this limits reach massively.
*   **The Fix:** Wrap `MaterialApp` in `flutter_localizations`. Extract all hardcoded strings into an `en.arb` file to prepare for Hindi/Tamil injection. Add `Semantics` wrappers to the Tinder Swiper and Input Slider.
