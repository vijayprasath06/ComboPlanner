import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../domain/enums/engine_category.dart';

class GroqService {
  String get _apiKey => dotenv.env['GROQ_API_KEY'] ?? '';

  Future<List<EngineCategory>> getWhitelistedCategories() async {
    final now = DateTime.now();
    final currentHour = now.hour;

    if (_apiKey.isEmpty) {
      return _localFallback(currentHour);
    }

    try {
      final response = await http.post(
        Uri.parse('https://api.groq.com/openai/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'llama3-8b-8192',
          'messages': [
            {
              'role': 'system',
              'content': 'You are a food court categorization assistant. Output ONLY a JSON array of categories based on the time of day. Possible categories: ["main", "side", "beverage"]. Rules: Lunch/Dinner (12-15, 19-22): all. Snack (15-18): ["side", "beverage"].'
            },
            {
              'role': 'user',
              'content': 'Current hour is $currentHour.'
            }
          ],
          'response_format': {'type': 'json_object'}
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices'][0]['message']['content'];
        final parsed = jsonDecode(content);
        List<dynamic> categories = [];
        if (parsed is Map && parsed.containsKey('categories')) {
          categories = parsed['categories'];
        } else if (parsed is List) {
          categories = parsed;
        }
        
        final result = <EngineCategory>[];
        for (var c in categories) {
          final str = c.toString().toLowerCase();
          if (str == 'main') result.add(EngineCategory.main);
          if (str == 'side') result.add(EngineCategory.side);
          if (str == 'beverage') result.add(EngineCategory.beverage);
        }
        if (result.isNotEmpty) return result;
      }
    } catch (e) {
      // ignore and fallback
    }

    return _localFallback(currentHour);
  }

  List<EngineCategory> _localFallback(int hour) {
    if (hour >= 15 && hour < 19) {
      // Snack / High Tea window
      return [EngineCategory.side, EngineCategory.beverage];
    }
    // Default / Lunch / Dinner
    return [EngineCategory.main, EngineCategory.side, EngineCategory.beverage];
  }
}
