import 'package:flutter/material.dart';
import '../data/travel_data.dart';
import '../theme/app_theme.dart';
import '../widgets/destination_card.dart';
import '../widgets/category_chip.dart';
import '../widgets/section_header.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  int _bottomNavIndex = 0;

  List<Destination> get _filteredDestinations {
    var list = destinationsByCategory(_selectedCategory);
    if (_searchQuery.isNotEmpty) {
      list = list
          .where((d) =>
              d.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              d.location.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              d.country.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
    return list;
  }

  void _navigate(Destination dest) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailScreen(destination: dest)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final featured = kFeaturedDestinations;
    final all = _filteredDestinations;

    return Scaffold(
      backgroundColor: AppTheme.greyLight,
      body: CustomScrollView(
        slivers: [
          // ── App Bar ────────────────────────────────────────────────────
          _buildSliverAppBar(),

          // ── Search Bar ────────────────────────────────────────────────
          SliverToBoxAdapter(child: _buildSearchBar()),

          // ── Categories ────────────────────────────────────────────────
          SliverToBoxAdapter(child: _buildCategories()),

          // ── Featured Section ──────────────────────────────────────────
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                const SectionHeader(
                  title: 'Featured Places',
                  actionLabel: 'See All',
                ),
                const SizedBox(height: 14),
                _buildFeaturedCarousel(featured),
                const SizedBox(height: 28),
              ],
            ),
          ),

          // ── Nearby / All Places Header ─────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: SectionHeader(
                title: _searchQuery.isNotEmpty
                    ? 'Search Results (${all.length})'
                    : _selectedCategory == 'All'
                        ? 'Nearby Places'
                        : _selectedCategory,
                actionLabel: 'Filter',
                onAction: () {},
              ),
            ),
          ),

          // ── Grid of All Destinations ──────────────────────────────────
          all.isEmpty
              ? SliverToBoxAdapter(child: _buildEmptyState())
              : SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (_, i) => DestinationCard(
                        destination: all[i],
                        height: 220,
                        onTap: () => _navigate(all[i]),
                      ),
                      childCount: all.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.72,
                    ),
                  ),
                ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),

      // ── Bottom Nav ──────────────────────────────────────────────────────
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Sliver App Bar with hero gradient
  // ──────────────────────────────────────────────────────────────────────────
  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: AppTheme.primary,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // gradient bg
            Container(
              decoration: const BoxDecoration(gradient: AppTheme.heroGradient),
            ),
            // decorative circles
            Positioned(
              top: -40,
              right: -40,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.07),
                ),
              ),
            ),
            Positioned(
              bottom: -60,
              left: -30,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.07),
                ),
              ),
            ),
            // text content
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  color: Colors.white70, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                'California, USA',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.keyboard_arrow_down,
                                  color: Colors.white70, size: 16),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Find Your Dream\nHome Easily',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              height: 1.25,
                            ),
                          ),
                        ],
                      ),
                      // Avatar + notification
                      Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 2),
                                  color: Colors.white.withOpacity(0.2),
                                ),
                                child: const Icon(Icons.person_rounded,
                                    color: Colors.white, size: 24),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    color: AppTheme.accent,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined,
              color: Colors.white, size: 24),
          onPressed: () {},
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: AppTheme.cardShadows,
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _searchQuery = v),
                decoration: const InputDecoration(
                  hintText: 'Search destinations...',
                  prefixIcon:
                      Icon(Icons.search_rounded, color: AppTheme.grey),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: AppTheme.heroGradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: AppTheme.buttonShadows,
            ),
            child: IconButton(
              icon: const Icon(Icons.tune_rounded,
                  color: Colors.white, size: 22),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        height: 46,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: kCategories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (_, i) {
            final cat = kCategories[i];
            return CategoryChip(
              label: cat['label']!,
              emoji: cat['icon']!,
              isSelected: _selectedCategory == cat['label'],
              onTap: () =>
                  setState(() => _selectedCategory = cat['label']!),
            );
          },
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildFeaturedCarousel(List<Destination> featured) {
    return SizedBox(
      height: 260,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: featured.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (_, i) => SizedBox(
          width: 220,
          child: DestinationCard(
            destination: featured[i],
            height: 260,
            onTap: () => _navigate(featured[i]),
          ),
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(Icons.search_off_rounded,
              size: 64, color: AppTheme.grey.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(
            'No destinations found',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: AppTheme.grey),
          ),
          const SizedBox(height: 8),
          Text(
            'Try a different search or category',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildBottomNav() {
    const items = [
      {'icon': Icons.home_rounded, 'label': 'Home'},
      {'icon': Icons.explore_rounded, 'label': 'Explore'},
      {'icon': Icons.favorite_border_rounded, 'label': 'Saved'},
      {'icon': Icons.person_outline_rounded, 'label': 'Profile'},
    ];

    return Container(
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
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final isSelected = i == _bottomNavIndex;
              final item = items[i];
              return GestureDetector(
                onTap: () => setState(() => _bottomNavIndex = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.primaryLight
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item['icon'] as IconData,
                        color: isSelected ? AppTheme.primary : AppTheme.grey,
                        size: 22,
                      ),
                      if (isSelected) ...[
                        const SizedBox(width: 6),
                        Text(
                          item['label'] as String,
                          style: const TextStyle(
                            color: AppTheme.primary,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
