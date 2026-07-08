import 'dart:math';
import 'package:geolocator/geolocator.dart';
import '../domain/models/mall.dart';

class GeofenceService {
  static const double _radiusMeters = 500.0;

  /// Returns the detected [Mall] if the user is within 500m of it, else null.
  static Future<Mall?> detectNearestMall(List<Mall> malls) async {
    try {
      // Check if location service is enabled
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return null;

      // Check permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          return null;
        }
      }

      // Get current position with a timeout
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 8),
        ),
      );

      // Find nearest mall within radius
      Mall? nearest;
      double shortestDistance = double.infinity;

      for (final mall in malls) {
        final distance = _haversineDistance(
          position.latitude, position.longitude,
          mall.lat, mall.lng,
        );
        if (distance <= _radiusMeters && distance < shortestDistance) {
          shortestDistance = distance;
          nearest = mall;
        }
      }

      return nearest;
    } catch (_) {
      // Timeout, permission error, etc. — silently fall back
      return null;
    }
  }

  /// Haversine formula: distance in meters between two lat/lng points
  static double _haversineDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371000; // metres
    final dLat = _toRad(lat2 - lat1);
    final dLon = _toRad(lon2 - lon1);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRad(lat1)) * cos(_toRad(lat2)) *
            sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  static double _toRad(double deg) => deg * pi / 180;
}
