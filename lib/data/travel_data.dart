// ─────────────────────────────────────────────────────────────────────────────
// travel_data.dart
// All hard-coded data for the WanderNest travel app.
// ─────────────────────────────────────────────────────────────────────────────

class Destination {
  final String id;
  final String title;
  final String location;
  final String country;
  final String category;
  final double rating;
  final int reviewCount;
  final double pricePerNight;
  final String description;
  final String longDescription;
  final String heroImage;
  final List<String> galleryImages;
  final List<String> amenities;
  final bool isFeatured;

  const Destination({
    required this.id,
    required this.title,
    required this.location,
    required this.country,
    required this.category,
    required this.rating,
    required this.reviewCount,
    required this.pricePerNight,
    required this.description,
    required this.longDescription,
    required this.heroImage,
    required this.galleryImages,
    required this.amenities,
    this.isFeatured = false,
  });
}

class BookingInfo {
  final String destinationId;
  final String guestName;
  final String checkIn;
  final String checkOut;
  final int guests;
  final int nights;
  final double pricePerNight;
  final double serviceFee;
  final double taxes;

  const BookingInfo({
    required this.destinationId,
    required this.guestName,
    required this.checkIn,
    required this.checkOut,
    required this.guests,
    required this.nights,
    required this.pricePerNight,
    required this.serviceFee,
    required this.taxes,
  });

  double get subtotal => pricePerNight * nights;
  double get total => subtotal + serviceFee + taxes;
}

// ─────────────────────────────────────────────────────────────────────────────
// Image URLs (Unsplash – free to use)
// ─────────────────────────────────────────────────────────────────────────────
class AppImages {
  // Hero / banner
  static const String heroBanner =
      'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=900';

  // Cottages & Houses
  static const String cottage1 =
      'https://images.unsplash.com/photo-1510798831971-661eb04b3739?w=800';
  static const String cottage2 =
      'https://images.unsplash.com/photo-1449158743715-0a90ebb6d2d8?w=800';
  static const String cottage3 =
      'https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=800';
  static const String cottage4 =
      'https://images.unsplash.com/photo-1558036117-15d82a90b9b1?w=800';

  // Apartments & Condos
  static const String apartment1 =
      'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800';
  static const String apartment2 =
      'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800';
  static const String apartment3 =
      'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800';

  // Villas
  static const String villa1 =
      'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=800';
  static const String villa2 =
      'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800';
  static const String villa3 =
      'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800';

  // Beaches
  static const String beach1 =
      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800';
  static const String beach2 =
      'https://images.unsplash.com/photo-1473116763249-2faaef81ccda?w=800';
  static const String beach3 =
      'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=800';

  // Mountains
  static const String mountain1 =
      'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800';
  static const String mountain2 =
      'https://images.unsplash.com/photo-1522163182402-834f871fd851?w=800';

  // Interiors (for gallery)
  static const String interior1 =
      'https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?w=800';
  static const String interior2 =
      'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800';
  static const String interior3 =
      'https://images.unsplash.com/photo-1484101403633-562f891dc89a?w=800';
  static const String interior4 =
      'https://images.unsplash.com/photo-1540518614846-7eded433c457?w=800';
  static const String interior5 =
      'https://images.unsplash.com/photo-1600121848594-d8644e57abab?w=800';
  static const String interior6 =
      'https://images.unsplash.com/photo-1616594039964-ae9021a400a0?w=800';
  static const String poolView =
      'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800';
  static const String gardenView =
      'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=800';
  static const String nightView =
      'https://images.unsplash.com/photo-1501183638710-841dd1904471?w=800';
}

// ─────────────────────────────────────────────────────────────────────────────
// Categories
// ─────────────────────────────────────────────────────────────────────────────
const List<Map<String, dynamic>> kCategories = [
  {'label': 'All',        'icon': '🌍'},
  {'label': 'Houses',     'icon': '🏡'},
  {'label': 'Apartments', 'icon': '🏢'},
  {'label': 'Villas',     'icon': '🏖️'},
  {'label': 'Cottages',   'icon': '🌲'},
  {'label': 'Beaches',    'icon': '🌊'},
  {'label': 'Mountains',  'icon': '⛰️'},
];

// ─────────────────────────────────────────────────────────────────────────────
// Destinations
// ─────────────────────────────────────────────────────────────────────────────
const List<Destination> kDestinations = [
  // ── Houses ──────────────────────────────────────────────────────────────
  Destination(
    id: 'h001',
    title: 'Classic Forest House',
    location: 'Vermont',
    country: 'USA',
    category: 'Houses',
    rating: 4.9,
    reviewCount: 128,
    pricePerNight: 1290,
    description: 'A stunning classic house surrounded by lush forest greenery.',
    longDescription:
        'Escape to this breathtaking classic forest house nestled among towering trees in Vermont. '
        'This charming property features beautifully crafted stonework, a wraparound porch, and floor-to-ceiling windows that frame the spectacular woodland views. '
        'The interior blends rustic warmth with modern luxury — think exposed timber beams, a grand stone fireplace, and a chef\'s kitchen. '
        'Wake up to birdsong and misty mornings, and spend evenings on the deck stargazing. '
        'Perfect for families, couples, or anyone who wants to reconnect with nature without sacrificing comfort. '
        'Close to hiking trails, skiing resorts, and quaint Vermont villages.',
    heroImage: AppImages.cottage1,
    galleryImages: [
      AppImages.cottage1,
      AppImages.interior1,
      AppImages.interior2,
      AppImages.gardenView,
      AppImages.interior3,
      AppImages.nightView,
    ],
    amenities: ['WiFi', 'Fireplace', 'Kitchen', 'Parking', 'Garden', 'BBQ'],
    isFeatured: true,
  ),
  Destination(
    id: 'h002',
    title: 'Golden Countryside Villa',
    location: 'Napa Valley',
    country: 'USA',
    category: 'Houses',
    rating: 4.8,
    reviewCount: 94,
    pricePerNight: 1850,
    description: 'Sun-drenched villa set amidst rolling vineyards and hills.',
    longDescription:
        'This golden countryside villa offers an unparalleled wine-country experience in the heart of Napa Valley. '
        'The property spans over 3 acres of manicured gardens and private vineyard. '
        'Inside, you\'ll find 5 spacious bedrooms, a gourmet kitchen, a home theater, and a wine cellar stocked with local vintages. '
        'The expansive terrace overlooks the valley and is perfect for al fresco dining as the sun sets over the vines. '
        'Guests enjoy complimentary wine tastings from the neighboring estate, a private chef option, and concierge services. '
        'An unforgettable sanctuary for wine lovers and those seeking refined countryside living.',
    heroImage: AppImages.cottage2,
    galleryImages: [
      AppImages.cottage2,
      AppImages.interior4,
      AppImages.interior5,
      AppImages.poolView,
      AppImages.gardenView,
      AppImages.interior6,
    ],
    amenities: ['Pool', 'Wine Cellar', 'Chef', 'WiFi', 'Spa', 'Vineyard'],
    isFeatured: true,
  ),
  Destination(
    id: 'h003',
    title: 'Mountain Ridge Cabin',
    location: 'Aspen',
    country: 'USA',
    category: 'Houses',
    rating: 4.7,
    reviewCount: 67,
    pricePerNight: 980,
    description: 'Cozy cabin perched high with panoramic mountain views.',
    longDescription:
        'High above the valley floor, this mountain ridge cabin offers some of the most spectacular views in Aspen. '
        'With 360-degree mountain panoramas, a hot tub on the deck, and ski-in/ski-out access to world-class slopes, this is the ultimate winter retreat. '
        'The cabin sleeps 8 comfortably, with a roaring fireplace, heated floors, and a fully-equipped kitchen. '
        'Summer visitors enjoy hiking, mountain biking, and wildflower meadows right from the doorstep. '
        'The property includes a private sauna, game room, and high-speed internet throughout.',
    heroImage: AppImages.mountain1,
    galleryImages: [
      AppImages.mountain1,
      AppImages.mountain2,
      AppImages.interior1,
      AppImages.interior3,
      AppImages.interior4,
      AppImages.nightView,
    ],
    amenities: ['Hot Tub', 'Sauna', 'Ski Access', 'Fireplace', 'WiFi', 'Game Room'],
  ),

  // ── Apartments ──────────────────────────────────────────────────────────
  Destination(
    id: 'a001',
    title: 'Downtown Skyline Loft',
    location: 'New York City',
    country: 'USA',
    category: 'Apartments',
    rating: 4.8,
    reviewCount: 212,
    pricePerNight: 890,
    description: 'Chic high-rise loft with breathtaking Manhattan skyline views.',
    longDescription:
        'Step into this ultra-modern loft on the 38th floor of a luxury Manhattan tower and be immediately captivated by the spectacular New York skyline. '
        'Floor-to-ceiling windows flood the space with natural light, showcasing the iconic cityscape from dawn to dusk. '
        'The open-plan living space features designer furniture, a fully-equipped kitchen, and a private balcony. '
        'Located in Midtown, you\'re steps from Central Park, Times Square, world-class restaurants, and Broadway shows. '
        'Building amenities include a rooftop pool, fitness center, and 24-hour concierge. '
        'Perfect for both business travelers and those exploring everything New York has to offer.',
    heroImage: AppImages.apartment1,
    galleryImages: [
      AppImages.apartment1,
      AppImages.apartment2,
      AppImages.apartment3,
      AppImages.interior5,
      AppImages.interior6,
      AppImages.nightView,
    ],
    amenities: ['Gym', 'Pool', 'Concierge', 'WiFi', 'Doorman', 'Balcony'],
    isFeatured: true,
  ),
  Destination(
    id: 'a002',
    title: 'Modern Beachfront Condo',
    location: 'Miami Beach',
    country: 'USA',
    category: 'Apartments',
    rating: 4.6,
    reviewCount: 155,
    pricePerNight: 1100,
    description: 'Sleek beachfront condo with direct ocean access.',
    longDescription:
        'This sleek and sophisticated beachfront condo places you directly on the sands of Miami Beach. '
        'Wake up to the sound of waves and fall asleep to ocean breezes from your private oceanfront balcony. '
        'The condo is designed in a contemporary style with a neutral palette, open kitchen, and premium finishes throughout. '
        'Building amenities include a beach club, three pools, a spa, and multiple dining options. '
        'South Beach\'s iconic Art Deco district, nightlife, and world-famous restaurants are just steps away. '
        'Ideal for sun-seekers wanting the full Miami Beach experience with luxury accommodations.',
    heroImage: AppImages.apartment2,
    galleryImages: [
      AppImages.apartment2,
      AppImages.beach1,
      AppImages.apartment3,
      AppImages.interior2,
      AppImages.poolView,
      AppImages.beach2,
    ],
    amenities: ['Beach Access', 'Pool', 'Spa', 'WiFi', 'Gym', 'Restaurant'],
  ),
  Destination(
    id: 'a003',
    title: 'Architect\'s Glass Penthouse',
    location: 'Los Angeles',
    country: 'USA',
    category: 'Apartments',
    rating: 4.9,
    reviewCount: 89,
    pricePerNight: 2400,
    description: 'Award-winning glass penthouse with stunning LA views.',
    longDescription:
        'Perched atop the Hollywood Hills, this award-winning glass penthouse is a masterpiece of modern architecture. '
        'Designed by a renowned LA architect, the home features walls of glass that dissolve the boundary between indoors and out. '
        'The 5,000 sq ft residence includes 4 bedrooms, a private infinity pool, a professional-grade kitchen, and a rooftop terrace with 360° city views. '
        'Sunsets from this property are truly unforgettable — the entire city of Los Angeles glitters beneath you. '
        'Conveniently located near the Sunset Strip, Beverly Hills, and premier shopping and dining.',
    heroImage: AppImages.apartment3,
    galleryImages: [
      AppImages.apartment3,
      AppImages.apartment1,
      AppImages.interior6,
      AppImages.poolView,
      AppImages.interior5,
      AppImages.nightView,
    ],
    amenities: ['Infinity Pool', 'Home Theater', 'Chef\'s Kitchen', 'WiFi', 'Terrace', 'Gym'],
    isFeatured: true,
  ),

  // ── Villas ──────────────────────────────────────────────────────────────
  Destination(
    id: 'v001',
    title: 'Tuscan Dream Villa',
    location: 'Tuscany',
    country: 'Italy',
    category: 'Villas',
    rating: 4.9,
    reviewCount: 203,
    pricePerNight: 3200,
    description: 'Iconic Tuscan villa with private pool and vineyard.',
    longDescription:
        'Live la dolce vita in this iconic Tuscan villa, set among rolling cypress-lined hills and ancient vineyards. '
        'Dating back to the 16th century, this estate has been lovingly restored to combine historic grandeur with contemporary luxury. '
        'The 8-bedroom villa accommodates up to 16 guests with opulent bedrooms, frescoed ceilings, and antique furnishings. '
        'Outside, a 20-meter private pool overlooks the valley, surrounded by manicured gardens, olive groves, and lavender fields. '
        'A private chef, daily housekeeping, and wine sommelier are included. '
        'The perfect venue for family gatherings, weddings, or an unforgettable Italian holiday.',
    heroImage: AppImages.villa1,
    galleryImages: [
      AppImages.villa1,
      AppImages.villa2,
      AppImages.villa3,
      AppImages.poolView,
      AppImages.interior1,
      AppImages.gardenView,
    ],
    amenities: ['Pool', 'Chef', 'Vineyard', 'Wine Cellar', 'Garden', 'Concierge'],
    isFeatured: true,
  ),
  Destination(
    id: 'v002',
    title: 'Bali Jungle Retreat',
    location: 'Ubud',
    country: 'Indonesia',
    category: 'Villas',
    rating: 4.8,
    reviewCount: 176,
    pricePerNight: 1450,
    description: 'Serene jungle villa with infinity pool and rice terrace views.',
    longDescription:
        'Hidden among the lush jungles of Ubud, this Balinese villa is a sanctuary for the soul. '
        'Traditional Balinese architecture meets modern luxury — hand-carved teak furniture, open-air pavilions, and a stunning infinity pool that seemingly merges with the forest below. '
        'The 4-bedroom villa includes an outdoor bathroom, a private spa, a yoga pavilion, and a meditation garden. '
        'Wake up to the sound of a nearby waterfall and the songs of tropical birds. '
        'Your villa manager will arrange temple tours, cooking classes, and traditional healers. '
        'A deeply immersive, transformative Balinese experience.',
    heroImage: AppImages.villa2,
    galleryImages: [
      AppImages.villa2,
      AppImages.villa1,
      AppImages.poolView,
      AppImages.gardenView,
      AppImages.interior3,
      AppImages.beach2,
    ],
    amenities: ['Infinity Pool', 'Spa', 'Yoga', 'Butler', 'Garden', 'Chef'],
  ),
  Destination(
    id: 'v003',
    title: 'Santorini Cliffside Villa',
    location: 'Oia, Santorini',
    country: 'Greece',
    category: 'Villas',
    rating: 5.0,
    reviewCount: 98,
    pricePerNight: 4100,
    description: 'Iconic whitewashed villa carved into the volcanic caldera.',
    longDescription:
        'Perched dramatically on the edge of Santorini\'s famous caldera, this whitewashed villa offers views that define the word "breathtaking". '
        'The Cycladic architecture — brilliant white walls, blue domes, and arched doorways — is as iconic as any image of Greece. '
        'The villa features a private heated pool, an outdoor terrace for watching Santorini\'s legendary sunsets, and three elegantly appointed bedrooms. '
        'Inside, curved walls are adorned with local artwork, and every window frames a postcard view of the Aegean Sea. '
        'A personal concierge arranges private boat tours, wine tastings at local wineries, and fine dining reservations. '
        'This is romance and luxury at its absolute zenith.',
    heroImage: AppImages.villa3,
    galleryImages: [
      AppImages.villa3,
      AppImages.villa1,
      AppImages.beach1,
      AppImages.beach3,
      AppImages.interior2,
      AppImages.nightView,
    ],
    amenities: ['Heated Pool', 'Concierge', 'Sea View', 'Terrace', 'WiFi', 'Breakfast'],
    isFeatured: true,
  ),

  // ── Cottages ────────────────────────────────────────────────────────────
  Destination(
    id: 'c001',
    title: 'Scottish Highlands Cottage',
    location: 'Inverness',
    country: 'Scotland',
    category: 'Cottages',
    rating: 4.7,
    reviewCount: 112,
    pricePerNight: 750,
    description: 'Charming stone cottage with moorland views and peat fireplace.',
    longDescription:
        'Nestled in the dramatic landscapes of the Scottish Highlands, this traditional stone cottage is a true Highland escape. '
        'With its thick stone walls, peat-burning fireplace, and tartan soft furnishings, the cottage exudes authentic Scottish warmth. '
        'The cottage accommodates 4 guests across 2 bedrooms, with a cozy sitting room, well-equipped kitchen, and a garden that backs onto open moorland. '
        'Loch Ness is just 15 minutes away, and the Cairngorms National Park offers world-class hiking and wildlife spotting. '
        'In the evening, watch the Northern Lights from the garden on clear winter nights. '
        'A magical, unforgettable Scottish experience.',
    heroImage: AppImages.cottage3,
    galleryImages: [
      AppImages.cottage3,
      AppImages.cottage4,
      AppImages.mountain2,
      AppImages.interior3,
      AppImages.gardenView,
      AppImages.nightView,
    ],
    amenities: ['Fireplace', 'Garden', 'Parking', 'Kitchen', 'WiFi', 'Pets OK'],
  ),
  Destination(
    id: 'c002',
    title: 'Lakeside Nordic Retreat',
    location: 'Rovaniemi',
    country: 'Finland',
    category: 'Cottages',
    rating: 4.9,
    reviewCount: 84,
    pricePerNight: 1150,
    description: 'Glass-roofed Nordic cottage for Northern Lights viewing.',
    longDescription:
        'This extraordinary glass-roofed Nordic cottage in Finnish Lapland is the world\'s finest Northern Lights viewing experience. '
        'Lying in the warmth of your heated, insulated glass bedroom, watch the aurora borealis dance across the sky in a private celestial theater. '
        'The cottage sits directly on a frozen lake, surrounded by snow-laden pine forests. '
        'Daytime activities include snowmobile safaris, reindeer sleigh rides, and ice fishing. '
        'A wood-burning sauna is available for post-adventure relaxation, and a private chef prepares traditional Finnish cuisine. '
        'A bucket-list experience unlike anything else on Earth.',
    heroImage: AppImages.cottage4,
    galleryImages: [
      AppImages.cottage4,
      AppImages.mountain1,
      AppImages.interior1,
      AppImages.interior4,
      AppImages.nightView,
      AppImages.cottage3,
    ],
    amenities: ['Glass Roof', 'Sauna', 'Lake View', 'Chef', 'WiFi', 'Snowmobiles'],
    isFeatured: true,
  ),

  // ── Beaches ─────────────────────────────────────────────────────────────
  Destination(
    id: 'b001',
    title: 'Maldives Water Bungalow',
    location: 'North Malé Atoll',
    country: 'Maldives',
    category: 'Beaches',
    rating: 5.0,
    reviewCount: 342,
    pricePerNight: 5500,
    description: 'Overwater bungalow on a pristine turquoise lagoon.',
    longDescription:
        'Welcome to paradise. This iconic overwater bungalow sits above a crystal-clear turquoise lagoon in the Maldives, surrounded by nothing but ocean in every direction. '
        'Step directly from your private deck into warm water teeming with tropical fish, sea turtles, and manta rays. '
        'The bungalow features a glass floor panel for viewing marine life below, a king bedroom with ocean-view bathtub, and a personal butler who caters to your every need. '
        'Sunrises and sunsets are otherworldly, and the Milky Way blazes overhead at night. '
        'Snorkeling, diving, dolphin safaris, and private island picnics are all arranged by the resort. '
        'The most romantic destination on Earth.',
    heroImage: AppImages.beach1,
    galleryImages: [
      AppImages.beach1,
      AppImages.beach2,
      AppImages.beach3,
      AppImages.poolView,
      AppImages.interior5,
      AppImages.nightView,
    ],
    amenities: ['Private Beach', 'Butler', 'Snorkeling', 'Spa', 'Overwater Deck', 'Diving'],
    isFeatured: true,
  ),
  Destination(
    id: 'b002',
    title: 'Amalfi Coast Beach House',
    location: 'Positano',
    country: 'Italy',
    category: 'Beaches',
    rating: 4.8,
    reviewCount: 167,
    pricePerNight: 2800,
    description: 'Colorful cliffside house with steps to the Mediterranean.',
    longDescription:
        'Cling to the dramatic cliffs of the Amalfi Coast in this beautifully decorated Italian beach house in Positano. '
        'The house cascades down the cliff with multiple terraces, each offering a different, equally stunning view of the sparkling Mediterranean. '
        'Inside, hand-painted Vietri tiles, vaulted ceilings, and whitewashed walls create a quintessentially Southern Italian atmosphere. '
        'Private steps lead directly to a secluded rocky beach below. '
        'Explore the UNESCO-listed Amalfi Coast by boat, visit the ruins of Pompeii, or simply sip limoncello on the terrace as fishing boats drift by. '
        'Romance and beauty in equal measure.',
    heroImage: AppImages.beach2,
    galleryImages: [
      AppImages.beach2,
      AppImages.beach1,
      AppImages.villa1,
      AppImages.interior2,
      AppImages.beach3,
      AppImages.gardenView,
    ],
    amenities: ['Sea View', 'Private Beach', 'Terrace', 'WiFi', 'Kitchen', 'Boat Access'],
  ),
  Destination(
    id: 'b003',
    title: 'Tropical Surf Villa',
    location: 'Seminyak',
    country: 'Bali',
    category: 'Beaches',
    rating: 4.7,
    reviewCount: 221,
    pricePerNight: 1200,
    description: 'Trendy beachfront villa steps from world-class surf breaks.',
    longDescription:
        'Ride the waves and return home to this stunning tropical beachfront villa in Seminyak, Bali\'s most fashionable beach destination. '
        'The villa features 3 open-plan bedrooms wrapped around a central tropical garden and pool. '
        'Warm golden sands and consistent waves for surfing are a 2-minute walk away. '
        'The villa\'s design integrates local Balinese craftsmanship with a contemporary tropical aesthetic — thatched roofs, bamboo accents, and lush greenery throughout. '
        'Your villa team includes a cook, driver, and daily housekeeping. '
        'Seminyak\'s world-famous beach clubs, restaurants, and boutiques are all within walking distance.',
    heroImage: AppImages.beach3,
    galleryImages: [
      AppImages.beach3,
      AppImages.beach1,
      AppImages.villa2,
      AppImages.poolView,
      AppImages.interior3,
      AppImages.gardenView,
    ],
    amenities: ['Pool', 'Cook', 'Surfboards', 'Beach Access', 'Driver', 'Garden'],
  ),
];

// ─────────────────────────────────────────────────────────────────────────────
// Featured Destinations (for hero section)
// ─────────────────────────────────────────────────────────────────────────────
List<Destination> get kFeaturedDestinations =>
    kDestinations.where((d) => d.isFeatured).toList();

// ─────────────────────────────────────────────────────────────────────────────
// Nearby / Recommended (first 6)
// ─────────────────────────────────────────────────────────────────────────────
List<Destination> get kNearbyDestinations => kDestinations.take(6).toList();

// ─────────────────────────────────────────────────────────────────────────────
// Filter by category
// ─────────────────────────────────────────────────────────────────────────────
List<Destination> destinationsByCategory(String category) {
  if (category == 'All') return kDestinations;
  return kDestinations.where((d) => d.category == category).toList();
}

// ─────────────────────────────────────────────────────────────────────────────
// Default BookingInfo builder
// ─────────────────────────────────────────────────────────────────────────────
BookingInfo defaultBooking(Destination dest) => BookingInfo(
      destinationId: dest.id,
      guestName: 'Alex Johnson',
      checkIn: 'Jun 14, 2025',
      checkOut: 'Jun 21, 2025',
      guests: 2,
      nights: 7,
      pricePerNight: dest.pricePerNight,
      serviceFee: dest.pricePerNight * 0.12,
      taxes: dest.pricePerNight * 0.08,
    );
