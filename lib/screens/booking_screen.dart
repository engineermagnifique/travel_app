import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/travel_data.dart';
import '../theme/app_theme.dart';

class BookingScreen extends StatefulWidget {
  final Destination destination;
  final BookingInfo booking;

  const BookingScreen({
    super.key,
    required this.destination,
    required this.booking,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with TickerProviderStateMixin {
  int _guests = 2;
  bool _isLoading = false;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    _fadeAnimation = CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeIn,
    );
    _guests = widget.booking.guests;
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  Destination get d => widget.destination;
  BookingInfo get b => widget.booking;

  double get subtotal => d.pricePerNight * b.nights;
  double get serviceFee => subtotal * 0.12;
  double get taxes => subtotal * 0.08;
  double get total => subtotal + serviceFee + taxes;

  void _confirm() async {
    HapticFeedback.mediumImpact();
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() => _isLoading = false);
    if (!mounted) return;
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        insetPadding:
            const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success animation circle
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_rounded,
                    color: AppTheme.primary, size: 52),
              ),
              const SizedBox(height: 20),
              const Text(
                'Booking Confirmed! 🎉',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.dark,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Your stay at ${d.title} has been successfully booked.',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.grey,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppTheme.greyLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _ConfirmRow(
                        icon: Icons.calendar_today_rounded,
                        label: 'Check-in',
                        value: b.checkIn),
                    const SizedBox(height: 6),
                    _ConfirmRow(
                        icon: Icons.calendar_today_rounded,
                        label: 'Check-out',
                        value: b.checkOut),
                    const SizedBox(height: 6),
                    _ConfirmRow(
                        icon: Icons.attach_money_rounded,
                        label: 'Total',
                        value: '\$${total.toStringAsFixed(0)}'),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                      ..pop()   // close dialog
                      ..pop()   // close booking
                      ..pop();  // close detail → home
                  },
                  child: const Text('Back to Home'),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'View My Bookings',
                  style: TextStyle(
                      color: AppTheme.primary, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.greyLight,
      appBar: AppBar(
        backgroundColor: AppTheme.greyLight,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: AppTheme.cardShadows,
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 18, color: AppTheme.dark),
          ),
        ),
        title: const Text('Booking Details'),
        centerTitle: true,
      ),
      body: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Property Summary Card ─────────────────────────────
                _buildPropertyCard(),
                const SizedBox(height: 20),

                // ── Date Selection ────────────────────────────────────
                _buildSectionTitle('Trip Dates'),
                const SizedBox(height: 12),
                _buildDateRow(),
                const SizedBox(height: 20),

                // ── Guest Selection ───────────────────────────────────
                _buildSectionTitle('Guests'),
                const SizedBox(height: 12),
                _buildGuestSelector(),
                const SizedBox(height: 20),

                // ── Guest Info Form ───────────────────────────────────
                _buildSectionTitle('Guest Information'),
                const SizedBox(height: 12),
                _buildGuestInfoForm(),
                const SizedBox(height: 20),

                // ── Price Breakdown ───────────────────────────────────
                _buildSectionTitle('Price Breakdown'),
                const SizedBox(height: 12),
                _buildPriceBreakdown(),
                const SizedBox(height: 20),

                // ── Special Requests ──────────────────────────────────
                _buildSectionTitle('Special Requests'),
                const SizedBox(height: 12),
                _buildSpecialRequests(),
                const SizedBox(height: 32),

                // ── Confirm Button ────────────────────────────────────
                _buildConfirmButton(),
                const SizedBox(height: 20),

                // ── Policy Note ───────────────────────────────────────
                _buildPolicyNote(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildPropertyCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.cardShadows,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: SizedBox(
              width: 80,
              height: 80,
              child: Image.network(
                d.heroImage,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(color: AppTheme.greyLight),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  d.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.dark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 12, color: AppTheme.grey),
                    const SizedBox(width: 3),
                    Text(
                      '${d.location}, ${d.country}',
                      style: const TextStyle(
                          fontSize: 12, color: AppTheme.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        size: 14, color: AppTheme.gold),
                    const SizedBox(width: 3),
                    Text(
                      d.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.dark,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        d.category,
                        style: const TextStyle(
                          color: AppTheme.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildDateRow() {
    return Row(
      children: [
        Expanded(
          child: _DateCard(
            icon: Icons.flight_takeoff_rounded,
            label: 'Check-in',
            date: b.checkIn,
            color: AppTheme.primary,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${b.nights}N',
                  style: const TextStyle(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: _DateCard(
            icon: Icons.flight_land_rounded,
            label: 'Check-out',
            date: b.checkOut,
            color: AppTheme.primaryDark,
          ),
        ),
      ],
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildGuestSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.cardShadows,
      ),
      child: Row(
        children: [
          const Icon(Icons.people_alt_rounded,
              size: 22, color: AppTheme.primary),
          const SizedBox(width: 12),
          const Text(
            'Guests',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppTheme.dark),
          ),
          const Spacer(),
          _CounterButton(
            icon: Icons.remove,
            onTap: () {
              if (_guests > 1) setState(() => _guests--);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '$_guests',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppTheme.dark,
              ),
            ),
          ),
          _CounterButton(
            icon: Icons.add,
            onTap: () {
              if (_guests < 12) setState(() => _guests++);
            },
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildGuestInfoForm() {
    return Column(
      children: [
        _FormField(
          icon: Icons.person_outline_rounded,
          hint: 'Full Name',
          initial: b.guestName,
        ),
        const SizedBox(height: 12),
        _FormField(
          icon: Icons.email_outlined,
          hint: 'Email Address',
          initial: 'alex.johnson@email.com',
        ),
        const SizedBox(height: 12),
        _FormField(
          icon: Icons.phone_outlined,
          hint: 'Phone Number',
          initial: '+1 (555) 012-3456',
        ),
      ],
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildPriceBreakdown() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.cardShadows,
      ),
      child: Column(
        children: [
          _PriceRow(
            label:
                '\$${d.pricePerNight.toStringAsFixed(0)} × ${b.nights} nights',
            value: subtotal,
          ),
          const SizedBox(height: 10),
          _PriceRow(label: 'Service fee (12%)', value: serviceFee),
          const SizedBox(height: 10),
          _PriceRow(label: 'Taxes & fees (8%)', value: taxes),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: AppTheme.greyLight, height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.dark,
                ),
              ),
              Text(
                '\$${total.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildSpecialRequests() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.cardShadows,
      ),
      child: TextField(
        maxLines: 3,
        decoration: InputDecoration(
          hintText: 'Any special requests or notes for the host...',
          hintStyle: const TextStyle(
              color: AppTheme.grey, fontSize: 13, height: 1.6),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppTheme.white,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: _isLoading ? null : _confirm,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            gradient: AppTheme.heroGradient,
            borderRadius: BorderRadius.circular(18),
            boxShadow: AppTheme.buttonShadows,
          ),
          child: Center(
            child: _isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    'Confirm Booking',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildPolicyNote() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.primaryLight,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline_rounded,
              size: 18, color: AppTheme.primary),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'By confirming, you agree to the cancellation policy and house rules. Free cancellation up to 7 days before check-in.',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.primaryDark,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppTheme.dark,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Reusable sub-widgets
// ─────────────────────────────────────────────────────────────────────────────

class _DateCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String date;
  final Color color;

  const _DateCard({
    required this.icon,
    required this.label,
    required this.date,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.cardShadows,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppTheme.grey),
          ),
          const SizedBox(height: 2),
          Text(
            date,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppTheme.dark,
            ),
          ),
        ],
      ),
    );
  }
}

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CounterButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: AppTheme.primaryLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 18, color: AppTheme.primary),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final String initial;

  const _FormField({
    required this.icon,
    required this.hint,
    required this.initial,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: AppTheme.cardShadows,
      ),
      child: TextFormField(
        initialValue: initial,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppTheme.dark,
        ),
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, size: 20, color: AppTheme.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppTheme.white,
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final double value;

  const _PriceRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: AppTheme.grey),
        ),
        Text(
          '\$${value.toStringAsFixed(0)}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.dark,
          ),
        ),
      ],
    );
  }
}

class _ConfirmRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ConfirmRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppTheme.primary),
        const SizedBox(width: 6),
        Text(
          '$label:',
          style: const TextStyle(fontSize: 12, color: AppTheme.grey),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppTheme.dark,
          ),
        ),
      ],
    );
  }
}
