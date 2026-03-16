import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AmenityBadge extends StatelessWidget {
  final String label;

  const AmenityBadge({super.key, required this.label});

  static const Map<String, IconData> _icons = {
    'WiFi': Icons.wifi_rounded,
    'Pool': Icons.pool_rounded,
    'Fireplace': Icons.fireplace_rounded,
    'Kitchen': Icons.kitchen_rounded,
    'Parking': Icons.local_parking_rounded,
    'Garden': Icons.grass_rounded,
    'BBQ': Icons.outdoor_grill_rounded,
    'Gym': Icons.fitness_center_rounded,
    'Spa': Icons.spa_rounded,
    'Sauna': Icons.hot_tub_rounded,
    'Butler': Icons.room_service_rounded,
    'Chef': Icons.restaurant_rounded,
    'Beach Access': Icons.beach_access_rounded,
    'Sea View': Icons.waves_rounded,
    'Terrace': Icons.deck_rounded,
    'Balcony': Icons.balcony_rounded,
    'Concierge': Icons.room_service_rounded,
    'Hot Tub': Icons.hot_tub_rounded,
    'Vineyard': Icons.wine_bar_rounded,
    'Wine Cellar': Icons.wine_bar_rounded,
    'Yoga': Icons.self_improvement_rounded,
    'Snorkeling': Icons.scuba_diving_rounded,
    'Diving': Icons.scuba_diving_rounded,
    'Surfboards': Icons.surfing_rounded,
    'Doorman': Icons.security_rounded,
    'Driver': Icons.drive_eta_rounded,
    'Game Room': Icons.sports_esports_rounded,
    'Ski Access': Icons.downhill_skiing_rounded,
    'Snowmobiles': Icons.snowmobile_rounded,
    'Glass Roof': Icons.roofing_rounded,
    'Lake View': Icons.landscape_rounded,
    'Pets OK': Icons.pets_rounded,
    'Breakfast': Icons.free_breakfast_rounded,
    'Infinity Pool': Icons.pool_rounded,
    'Home Theater': Icons.movie_rounded,
    'Overwater Deck': Icons.deck_rounded,
    'Boat Access': Icons.directions_boat_rounded,
    'Private Beach': Icons.beach_access_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final icon = _icons[label] ?? Icons.check_circle_outline_rounded;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: AppTheme.cardShadows,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 22, color: AppTheme.primary),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppTheme.dark,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
