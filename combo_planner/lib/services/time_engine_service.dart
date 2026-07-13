import '../domain/enums/engine_category.dart';

class TimeEngineService {
  /// Deterministically returns allowed food categories based on the current time of day.
  /// Replaces the old LLM GroqService for instant, offline-capable results.
  List<EngineCategory> getWhitelistedCategories() {
    final hour = DateTime.now().hour;
    
    // Snack / High Tea window (3:00 PM to 6:59 PM)
    if (hour >= 15 && hour < 19) {
      return [EngineCategory.side, EngineCategory.beverage];
    }
    
    // Default / Lunch / Dinner
    return [EngineCategory.main, EngineCategory.side, EngineCategory.beverage];
  }
}
