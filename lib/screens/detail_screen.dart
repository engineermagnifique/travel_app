import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/travel_data.dart';
import '../theme/app_theme.dart';
import '../widgets/image_slider.dart';
import '../widgets/rating_bar.dart';
import '../widgets/amenity_badge.dart';
import '../widgets/destination_card.dart';
import 'booking_screen.dart';

class DetailScreen extends StatefulWidget {
  final Destination destination;

  const DetailScreen({super.key, required this.destination});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  bool _isFavorite = false;
  bool _isDescriptionExpanded = false;
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
    _fabAnimation = CurvedAnimation(
      parent: _fabController,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  Destination get d => widget.destination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.greyLight,
      body: Stack(
        children: [
          // ── Scrollable Content ──────────────────────────────────────
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Slider (with back/share buttons overlaid)
                _buildImageHeader(context),

                // White card body
                _buildContentCard(context),

                const SizedBox(height: 110),
              ],
            ),
          ),

          // ── Sticky Bottom Bar ─────────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomBar(context),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildImageHeader(BuildContext context) {
    return Stack(
      children: [
        ImageSlider(images: d.galleryImages, height: 380),

        // Back button
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          left: 16,
          child: _CircleIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Navigator.pop(context),
          ),
        ),

        // Share + Favorite
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          right: 16,
          child: Row(
            children: [
              _CircleIconButton(
                icon: Icons.share_rounded,
                onTap: () {},
              ),
              const SizedBox(width: 10),
              _CircleIconButton(
                icon: _isFavorite ? Icons.favorite : Icons.favorite_border,
                iconColor: _isFavorite ? AppTheme.accent : null,
                onTap: () => setState(() => _isFavorite = !_isFavorite),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildContentCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      decoration: const BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Category + Rating row ─────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    d.category,
                    style: const TextStyle(
                      color: AppTheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                StarRatingBar(
                  rating: d.rating,
                  size: 16,
                  reviewCount: d.reviewCount,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ── Title ─────────────────────────────────────────────────
            Text(
              d.title,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 8),

            // ── Location ─────────────────────────────────────────────
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.location_on,
                      size: 14, color: AppTheme.primary),
                ),
                const SizedBox(width: 8),
                Text(
                  '${d.location}, ${d.country}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),

            // ── Stats row ─────────────────────────────────────────────
            _buildStatsRow(),
            const SizedBox(height: 24),

            // ── Description ───────────────────────────────────────────
            _buildDescription(context),
            const SizedBox(height: 24),

            // ── Amenities ─────────────────────────────────────────────
            _buildAmenities(),
            const SizedBox(height: 24),

            // ── Similar Destinations ──────────────────────────────────
            _buildSimilar(context),
          ],
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildStatsRow() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.greyLight,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
              icon: Icons.nights_stay_rounded,
              value: '7 nights',
              label: 'Min. stay'),
          _divider(),
          _StatItem(
              icon: Icons.people_alt_rounded,
              value: '1–8',
              label: 'Guests'),
          _divider(),
          _StatItem(
              icon: Icons.bed_rounded,
              value: '${(d.pricePerNight / 400).ceil()} bd',
              label: 'Bedrooms'),
        ],
      ),
    );
  }

  Widget _divider() => Container(
        height: 36,
        width: 1,
        color: AppTheme.grey.withOpacity(0.2),
      );

  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About this place',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 10),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          firstChild: Text(
            d.longDescription,
            style: Theme.of(context).textTheme.bodyLarge,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          secondChild: Text(
            d.longDescription,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          crossFadeState: _isDescriptionExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () =>
              setState(() => _isDescriptionExpanded = !_isDescriptionExpanded),
          child: Text(
            _isDescriptionExpanded ? 'Show less' : 'Read more',
            style: const TextStyle(
              color: AppTheme.primary,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildAmenities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Amenities',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.85,
          ),
          itemCount: d.amenities.length,
          itemBuilder: (_, i) => AmenityBadge(label: d.amenities[i]),
        ),
      ],
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildSimilar(BuildContext context) {
    final similar = kDestinations
        .where((x) => x.id != d.id && x.category == d.category)
        .take(4)
        .toList();

    if (similar.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Similar Places',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 14),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: similar.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (_, i) => SizedBox(
              width: 180,
              child: DestinationCard(
                destination: similar[i],
                height: 200,
                showFullInfo: false,
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        DetailScreen(destination: similar[i]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, 16, 20, MediaQuery.of(context).padding.bottom + 16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Price
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Price',
                style:
                    TextStyle(fontSize: 12, color: AppTheme.grey),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          '\$${d.pricePerNight.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.primary,
                      ),
                    ),
                    const TextSpan(
                      text: '/night',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: AppTheme.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),

          // Book Now
          ScaleTransition(
            scale: _fabAnimation,
            child: GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookingScreen(
                      destination: d,
                      booking: defaultBooking(d),
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 36, vertical: 16),
                decoration: BoxDecoration(
                  gradient: AppTheme.heroGradient,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: AppTheme.buttonShadows,
                ),
                child: const Text(
                  'Book Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Reusable widgets
// ─────────────────────────────────────────────────────────────────────────────

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon,
            size: 20, color: iconColor ?? AppTheme.dark),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatItem(
      {required this.icon,
      required this.value,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: AppTheme.primary),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppTheme.dark,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppTheme.grey),
        ),
      ],
    );
  }
}
