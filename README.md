# Travel App UI in Flutter

A professional multi-screen Flutter Travel App UI with complex layouts, widget composition, and smooth navigation.

---

## Demo

<!-- ─────────────────────────────────────────────────────────────
  HOW TO MAKE THE VIDEO PLAY INLINE:
  1. Go to https://github.com/engineermagnifique/travel_app/issues/new
  2. Drag and drop demo/demo.mp4 into the comment box
  3. Wait for it to upload — GitHub gives you a URL like:
     https://github.com/user-attachments/assets/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
  4. Replace the src below with that URL and delete this comment
───────────────────────────────────────────────────────────────── -->

https://github.com/engineermagnifique/travel_app/blob/main/demo/demo.mp4

> **Can't see the video?** [Click here to watch](https://github.com/engineermagnifique/travel_app/blob/main/demo/demo.mp4)

---

## Screenshots

| Home                                                                                        | Home 2                                                                                        |
| ------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| ![Home](https://raw.githubusercontent.com/engineermagnifique/travel_app/main/demo/Home.png) | ![Home2](https://raw.githubusercontent.com/engineermagnifique/travel_app/main/demo/Home2.png) |

| Detail                                                                                        | Detail 2                                                                                        |
| --------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| ![Detail](https://raw.githubusercontent.com/engineermagnifique/travel_app/main/demo/view.png) | ![Detail2](https://raw.githubusercontent.com/engineermagnifique/travel_app/main/demo/view1.png) |

| Booking                                                                                        | Booking 2                                                                                        |
| ---------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| ![Booking](https://raw.githubusercontent.com/engineermagnifique/travel_app/main/demo/book.png) | ![Booking2](https://raw.githubusercontent.com/engineermagnifique/travel_app/main/demo/book1.png) |

---

## Project Structure

```
travel_app/
├── demo/                          ← Demo video & screenshots
│   ├── demo.mp4
│   ├── Home.png
│   ├── Home2.png
│   ├── view.png
│   ├── view1.png
│   ├── book.png
│   └── book1.png
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

## Built With

- [Flutter](https://flutter.dev)
- [Poppins](https://fonts.google.com/specimen/Poppins) — Google Fonts
- [Unsplash](https://unsplash.com) — Destination images loaded via URL
