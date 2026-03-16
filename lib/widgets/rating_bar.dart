import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class StarRatingBar extends StatelessWidget {
  final double rating;
  final double size;
  final bool showLabel;
  final int reviewCount;

  const StarRatingBar({
    super.key,
    required this.rating,
    this.size = 18,
    this.showLabel = true,
    this.reviewCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(5, (i) {
          final filled = i < rating.floor();
          final half = !filled && i < rating;
          return Icon(
            filled
                ? Icons.star_rounded
                : half
                    ? Icons.star_half_rounded
                    : Icons.star_outline_rounded,
            size: size,
            color: AppTheme.gold,
          );
        }),
        if (showLabel) ...[
          const SizedBox(width: 6),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: size * 0.8,
              fontWeight: FontWeight.w700,
              color: AppTheme.dark,
            ),
          ),
          if (reviewCount > 0)
            Text(
              ' ($reviewCount reviews)',
              style: TextStyle(
                fontSize: size * 0.72,
                color: AppTheme.grey,
              ),
            ),
        ],
      ],
    );
  }
}
