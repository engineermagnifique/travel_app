# Travel App UI in Flutter ✈️

A professional multi-screen Flutter Travel App UI with complex layouts, widget composition, and smooth navigation.

## Demo

https://github.com/engineermagnifique/travel_app/blob/main/demo/demo.mp4

---

## Screenshots

| Home                                                                                         | Detail                                                                                         | Booking                                                                                         |
| -------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| ![Home](https://raw.githubusercontent.com/engineermagnifique/travel_app/main/demo/Home.png)  | ![Detail](https://raw.githubusercontent.com/engineermagnifique/travel_app/main/demo/view.png)  | ![Booking](https://raw.githubusercontent.com/engineermagnifique/travel_app/main/demo/book.png)  |
| Home                                                                                         | Detail                                                                                         | Booking                                                                                         |
| -------------------------------------------------------------------------------------------  | ---------------------------------------------------------------------------------------------  | ----------------------------------------------------------------------------------------------  |
| ![Home](https://raw.githubusercontent.com/engineermagnifique/travel_app/main/demo/Home2.png) | ![Detail](https://raw.githubusercontent.com/engineermagnifique/travel_app/main/demo/view1.png) | ![Booking](https://raw.githubusercontent.com/engineermagnifique/travel_app/main/demo/book1.png) |

---

## Project Structure

```
travel_app/
├── demo/                          ← Demo video & screenshots
│   ├── demo.mp4
│   ├── home.png
│   ├── detail.png
│   └── booking.png
├── assets/
│   ├── fonts/                     ← Poppins (400–800)
│   └── images/
├── lib/
│   ├── main.dart
│   ├── data/
│   │   └── travel_data.dart       ← All hard-coded destinations, categories, booking data
│   ├── theme/
│   │   └── app_theme.dart         ← Colors, gradients, shadows, typography
│   ├── screens/
│   │   ├── home_screen.dart       ← Dashboard: AppBar, search, categories, grid
│   │   ├── detail_screen.dart     ← Image slider, info, amenities, Book Now
│   │   └── booking_screen.dart    ← Form, price breakdown, confirmation dialog
│   └── widgets/
│       ├── destination_card.dart  ← Card with image overlay & favorite toggle
│       ├── category_chip.dart     ← Animated filter pill
│       ├── image_slider.dart      ← Prev/Next carousel with dot indicators
│       ├── rating_bar.dart        ← Star rating display
│       ├── section_header.dart    ← Titled section with action
│       └── amenity_badge.dart     ← Icon + label badge
└── pubspec.yaml
```

---

## Getting Started

### Prerequisites

- Flutter SDK `^3.10.8`
- Android Studio / VS Code
- Android emulator or physical device

### Setup

**1. Clone the repo**

```bash
git clone https://github.com/engineermagnifique/travel_app.git
cd travel_app
```

**2. Add Poppins fonts**

Download from [fonts.google.com/specimen/Poppins](https://fonts.google.com/specimen/Poppins) and place in `assets/fonts/`:

```
assets/fonts/
├── Poppins-Regular.ttf
├── Poppins-Medium.ttf
├── Poppins-SemiBold.ttf
├── Poppins-Bold.ttf
└── Poppins-ExtraBold.ttf
```

**3. Install dependencies**

```bash
flutter pub get
```

**4. Run the app**

```bash
flutter run
```

---

## Features

| Feature          | Details                                                  |
| ---------------- | -------------------------------------------------------- |
| **Screens**      | Home, Detail, Booking                                    |
| **Navigation**   | `Navigator.push` / `Navigator.pop` with data passing     |
| **Data**         | 12 hard-coded destinations across 6 categories           |
| **Image Slider** | Prev/Next arrows, dot indicators, photo counter          |
| **Animations**   | Heart scale, slide-in, fade-in, page transitions         |
| **Booking Flow** | Form → loading state → success dialog → back to Home     |
| **Theme**        | Teal-mint palette, Poppins font, gradients, glow shadows |
| **Widgets**      | 18+ Flutter widgets used                                 |

---

## Flutter Widgets Used

`CustomScrollView` · `SliverAppBar` · `FlexibleSpaceBar` · `PageView` · `ListView.builder` · `GridView.builder` · `AnimatedContainer` · `AnimatedCrossFade` · `Stack` · `Positioned` · `ClipRRect` · `GestureDetector` · `ScaleTransition` · `SlideTransition` · `FadeTransition` · `TextFormField` · `Dialog` · `CircularProgressIndicator`

---

## Navigation Flow

```
Home Screen  ──►  Detail Screen  ──►  Booking Screen
                                            │
                                    Confirmation Dialog
                                            │
                                   ◄── Back to Home
```

---

## Built With

- [Flutter](https://flutter.dev)
- [Poppins](https://fonts.google.com/specimen/Poppins) — Google Fonts
- [Unsplash](https://unsplash.com) — Destination images loaded via URL
