import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ImageSlider extends StatefulWidget {
  final List<String> images;
  final double height;
  final bool showCounter;

  const ImageSlider({
    super.key,
    required this.images,
    this.height = 380,
    this.showCounter = true,
  });

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    if (index < 0 || index >= widget.images.length) return;
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          // ── Page View ─────────────────────────────────────────────
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (i) => setState(() => _currentIndex = i),
            itemBuilder: (_, i) => Image.network(
              widget.images[i],
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (_, __, ___) => Container(
                color: AppTheme.greyLight,
                child: const Icon(Icons.image_not_supported,
                    size: 48, color: AppTheme.grey),
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

          // ── Bottom Gradient ───────────────────────────────────────
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: AppTheme.imageOverlay,
              ),
            ),
          ),

          // ── Prev Button ───────────────────────────────────────────
          if (_currentIndex > 0)
            Positioned(
              left: 16,
              top: 0,
              bottom: 0,
              child: Center(
                child: _NavButton(
                  icon: Icons.chevron_left_rounded,
                  onTap: () => _goTo(_currentIndex - 1),
                ),
              ),
            ),

          // ── Next Button ───────────────────────────────────────────
          if (_currentIndex < widget.images.length - 1)
            Positioned(
              right: 16,
              top: 0,
              bottom: 0,
              child: Center(
                child: _NavButton(
                  icon: Icons.chevron_right_rounded,
                  onTap: () => _goTo(_currentIndex + 1),
                ),
              ),
            ),

          // ── Counter ───────────────────────────────────────────────
          if (widget.showCounter)
            Positioned(
              bottom: 16,
              right: 16,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_currentIndex + 1} / ${widget.images.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

          // ── Dot Indicators ────────────────────────────────────────
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                (i) => GestureDetector(
                  onTap: () => _goTo(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: _currentIndex == i ? 22 : 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: _currentIndex == i
                          ? AppTheme.primary
                          : Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(4),
                    ),
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

// ── Reusable nav arrow button ─────────────────────────────────────────────────
class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NavButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, size: 26, color: AppTheme.dark),
      ),
    );
  }
}
