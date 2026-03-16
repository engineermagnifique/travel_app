import 'package:flutter/material.dart';
import '../data/travel_data.dart';
import '../theme/app_theme.dart';

class DestinationCard extends StatefulWidget {
  final Destination destination;
  final VoidCallback? onTap;
  final double height;
  final bool showFullInfo;

  const DestinationCard({
    super.key,
    required this.destination,
    this.onTap,
    this.height = 240,
    this.showFullInfo = true,
  });

  @override
  State<DestinationCard> createState() => _DestinationCardState();
}

class _DestinationCardState extends State<DestinationCard>
    with SingleTickerProviderStateMixin {
  bool _isFavorite = false;
  late AnimationController _heartController;
  late Animation<double> _heartScale;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _heartScale = Tween<double>(begin: 1.0, end: 1.4).animate(
      CurvedAnimation(parent: _heartController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() => _isFavorite = !_isFavorite);
    _heartController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.destination;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: AppTheme.cardShadows,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // ── Hero Image ────────────────────────────────────────
              SizedBox(
                height: widget.height,
                width: double.infinity,
                child: Image.network(
                  d.heroImage,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: AppTheme.greyLight,
                    child: const Icon(Icons.image_not_supported,
                        color: AppTheme.grey),
                  ),
                  loadingBuilder: (_, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      color: AppTheme.greyLight,
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppTheme.primary,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // ── Gradient Overlay ──────────────────────────────────
              Positioned.fill(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    gradient: AppTheme.cardOverlay,
                  ),
                ),
              ),

              // ── Favorite Button ───────────────────────────────────
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: _toggleFavorite,
                  child: AnimatedBuilder(
                    animation: _heartScale,
                    builder: (_, child) => Transform.scale(
                      scale: _heartScale.value,
                      child: child,
                    ),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.white.withOpacity(0.3), width: 1),
                      ),
                      child: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        size: 18,
                        color: _isFavorite ? AppTheme.accent : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              // ── Category Badge ────────────────────────────────────
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    d.category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // ── Bottom Info ───────────────────────────────────────
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        d.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 12, color: Colors.white70),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              '${d.location}, ${d.country}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      if (widget.showFullInfo) ...[
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Rating
                            Row(
                              children: [
                                const Icon(Icons.star_rounded,
                                    size: 14, color: AppTheme.gold),
                                const SizedBox(width: 3),
                                Text(
                                  d.rating.toStringAsFixed(1),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  ' (${d.reviewCount})',
                                  style: const TextStyle(
                                    color: Colors.white60,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            // Price
                            Text(
                              '\$${d.pricePerNight.toStringAsFixed(0)}/night',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
