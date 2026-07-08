import 'package:share_plus/share_plus.dart';

/// Thin wrapper so any screen can call share without importing share_plus directly.
class PlanShareService {
  static Future<void> share(String text) async {
    await SharePlus.instance.share(ShareParams(text: text));
  }
}
