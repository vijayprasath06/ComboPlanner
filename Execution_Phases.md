# Combo Planner: Execution Phases (The 22-Point Blueprint)

This document breaks down the 22-point master blueprint into 4 logical, sequential phases. **Use this document to guide your execution in your next chat session.**

---

## 🛠️ Phase 1: Real Data Pipeline
*We must build the data foundation before touching the math or UI.*

- [ ] **Task 1.1:** Create `scripts/data_pipeline.py` to scrape/generate realistic Chennai mall vendor data (e.g., VR Mall stalls like A2B, KFC, Taco Bell, Kailash Parbat).
- [ ] **Task 1.2:** Execute the python script to generate `assets/real_menu_data.json`.
- [ ] **Task 1.3:** Update `lib/domain/models/stall.dart` to include `packagingCharge` (double) and `isPureVeg` (bool).
- [ ] **Task 1.4:** Update `lib/domain/models/menu_item.dart` to include `isVendorCombo` (bool) and `estimatedPrepTimeMins` (int).
- [ ] **Task 1.5:** Update `lib/data/repositories/local_menu_repository.dart` to ingest the new JSON schema into Isar.

---

## 🧮 Phase 2: Algorithm Engine Fixes & DB Performance
*Fixing the core logic and making it lightning fast.*

- [ ] **Task 2.1:** **Database Isolate Bottleneck:** Move Isar database queries directly *into* the Dart isolate to fix the memory passing bottleneck. Use `.filter().tags()` directly on disk.
- [ ] **Task 2.2:** **The "Impossible Budget" Bug:** Update `KnapsackService` to include a "Snack Mode" fallback if Mains cannot fit the budget.
- [ ] **Task 2.3:** **Hidden Takeaway Tax:** Factor `stall.packagingCharge` into the knapsack total cost calculation.
- [ ] **Task 2.4:** **Vendor Combo & Prep Times:** Prioritize `isVendorCombo = true` items. Reject any meal plan combination where the delta between stall prep times is > 10 mins.
- [ ] **Task 2.5:** **Shared Plate Ignorance:** Allocate ~20% of the budget for shared plates (sides/appetizers) before assigning individual mains.
- [ ] **Task 2.6:** **Pure Veg Stall Ignorance:** If the user checks "Strict Pure Veg Only", the algorithm must blacklist any stall where `isPureVeg == false` for vegetarian assignments.

---

## ✨ Phase 3: UX & User Delight
*Making the app viral, localized, and beautiful.*

- [ ] **Task 3.1:** **Food Tinder Onboarding:** Build `onboarding_tinder_screen.dart` with swipeable cards to generate `likedTags` and `dislikedTags`.
- [ ] **Task 3.2:** **Budget Slider Granularity:** Fix `input_screen.dart` so the budget slider caps at ₹3,000 and steps smoothly in ₹50 increments.
- [ ] **Task 3.3:** **Discount Aggregation:** Add checkboxes for Zomato Gold / Swiggy Dineout on `input_screen.dart` and apply a global 15% discount multiplier to the budget.
- [ ] **Task 3.4:** **The Pre-Planning Paradox:** Add a "When are you eating?" dropdown (Now, Lunch, Dinner, Snack) to the Input Screen that defaults to "Now".
- [ ] **Task 3.5:** **The Single-Stall Paradox:** Add logic to disable the Generate button if `Max Stalls = 1`, `Strict Pure Veg = true`, and both Veg & Non-Veg eaters are present.
- [ ] **Task 3.6:** **Localized Hot-Swaps:** Fix `plan_detail_screen.dart` so swiping an item pops up a bottom sheet with alternatives from the *same stall* rather than rerunning the whole Knapsack.
- [ ] **Task 3.7:** **The Bill Splitter & UPI Generator:** Replace the QR code with a button that generates a WhatsApp-friendly breakdown ("Rahul owes ₹250") and a UPI payment link.
- [ ] **Task 3.8:** **Localization & Accessibility (a11y):** Setup `flutter_localizations` (en.arb) and add `Semantics` wrappers to the Tinder Swiper and Slider.

---

## 🏗️ Phase 4: Architecture (Offline & Auth)
*Making the app robust, battery-friendly, and offline-capable.*

- [ ] **Task 4.1:** **Geofencing Battery Drain:** Update `geofence_service.dart` to use `Geolocator.getLastKnownPosition()` for instant loading instead of pinging GPS.
- [ ] **Task 4.2:** **Auth Offline Deadlock:** Update `auth_screen.dart` with a network check on `initState`. If offline, disable login and show a "Continue as Guest" banner.
- [ ] **Task 4.3:** **Fragile Cloud Preferences Sync:** Cache preferences locally in `SharedPreferences` as the source of truth, syncing to Supabase only when online.
- [ ] **Task 4.4:** **The Guest Onboarding Trap:** Implement a "Merge on Login" strategy in `UserProvider` to retain local Tinder swipe preferences when authenticating.
- [ ] **Task 4.5:** **Remove LLM Dependency:** Delete `groq_service.dart`. Replace completely with the local time engine.
- [ ] **Task 4.6:** **Remove Crowdsourced Friction:** Delete the "Report Mismatch" UI from the Plan Detail screen.
