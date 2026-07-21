# 🛍️ Modern E-Commerce Application

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
[![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com/)
[![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)](https://supabase.com/)
[![BLoC](https://img.shields.io/badge/State--Management-BLoC%2FCubit-blueviolet?style=for-the-badge)](https://bloclibrary.dev/)
[![Architecture](https://img.shields.io/badge/Architecture-Clean%20%2B%20Feature--First-success?style=for-the-badge)](#-app-architecture)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)

A production-ready, feature-rich **E-Commerce Mobile Application** built with **Flutter**, following **Feature-First Clean Architecture**, **BLoC/Cubit** for state management, and **GetIt** for dependency injection. Supports scalable cloud backends via **Firebase** and **Supabase**, with local offline caching powered by **Hive** and **SharedPreferences**.

---

## 📌 Table of Contents

- [Overview](#-overview)
- [Key Features](#-key-features)
- [App Architecture](#-app-architecture)
- [Tech Stack & Libraries](#-tech-stack--libraries)
- [Directory Structure](#-directory-structure)
- [Getting Started](#-getting-started)
- [Configuration](#-configuration)
- [Contributing](#-contributing)
- [License](#-license)

---

## 📖 Overview

This application provides a seamless shopping experience for users with high-performance UI components, smooth micro-animations, theme toggling (Light/Dark mode), robust error handling, and offline-first data caching capabilities.

### Key Highlights:
- **Clean Architecture & Feature-First**: High separation of concerns, high testability, and modular maintainability.
- **Dual Cloud Integrations**: Scalable backend solutions utilizing Firebase Auth, Firestore, and Supabase database services.
- **Offline Caching**: Fast loading speeds via Hive key-value storage and SharedPreferences.
- **Reactive UI & Micro-Animations**: Built with Lottie, Shimmer loading placeholders, and responsive layouts.

---

## ✨ Key Features

### 🔐 Authentication & User Onboarding
- **Onboarding Flow**: Smooth introduction screens with interactive page indicators.
- **Flexible Authentication**: Email & Password registration, Google Sign-In, and Firebase/Supabase Auth support.
- **Account Verification**: Email verification and password recovery mechanisms.

### 🏬 Store & Product Discovery
- **Home Dashboard**: Dynamic promotional banners, categories carousel, and featured brand cards.
- **Product Catalog**: Grid and List views with pagination support.
- **Product Details**: Comprehensive view with image carousels, expandable descriptions (`ReadMore`), ratings & reviews, and attribute selections (size, color, etc.).
- **Search & Filtering**: Search products by category, brand, or query keywords.

### 💖 Wishlist & Favorites
- **Favorite Products**: Toggle favorites instantly with local offline sync via Hive.
- **Persistent Wishlist**: Quick access to saved items.

### 🛒 Cart & Checkout Flow
- **Real-Time Cart Management**: Add, update quantity, or remove items dynamically.
- **Cart Calculations**: Automated calculation of subtotals, shipping fees, tax, and discount promo codes.
- **Multi-Step Checkout**: Shipping address management, payment method selection (PayPal, Credit Card), and order preview.

### 📦 Order Tracking & History
- **Order Management**: Active order status, historical receipts, and itemized summaries.
- **Order Status Flow**: Pending, Processing, Shipped, Delivered, and Cancelled updates.

### 👤 Personalization & Settings
- **Profile Management**: Profile picture updates, user details editing, and address book management.
- **Theme Settings**: Light and Dark mode options.
- **App Settings**: Language/localization toggles and notification preferences.

---

## 🏗️ App Architecture

The project strictly follows **Feature-First Clean Architecture**. Each feature module is self-contained into distinct layers:

```
                          ┌────────────────────────────────┐
                          │       Presentation Layer       │
                          │   (Widgets, Pages, Cubits)    │
                          └───────────────┬────────────────┘
                                          │
                                          ▼
                          ┌────────────────────────────────┐
                          │          Domain Layer          │
                          │   (Entities, UseCases, Repos)  │
                          └───────────────┬────────────────┘
                                          │
                                          ▼
                          ┌────────────────────────────────┐
                          │           Data Layer           │
                          │  (Models, DataSources, Repos) │
                          └────────────────────────────────┘
```

### Layer Breakdown:
1. **Presentation Layer**: UI screens (`Pages`), reusable UI components (`Widgets`), and state handlers (`Cubits`). Presentation never directly executes API calls or database mutations.
2. **Domain Layer**: Core business logic containing `Entities`, `UseCases`, and repository contract interfaces. Completely independent of frameworks or data sources.
3. **Data Layer**: Contains `Models` (JSON serialization), repository implementations, and data sources (`RemoteDataSource` & `LocalDataSource`). Converts low-level exceptions into domain `Failures` using `Dartz` (`Either<Failure, T>`).

---

## 🛠️ Tech Stack & Libraries

| Domain | Technology / Library | Description |
| :--- | :--- | :--- |
| **Framework** | [Flutter](https://flutter.dev/) (SDK ^3.9.0) | Cross-platform UI toolkit |
| **Language** | [Dart](https://dart.dev/) | Strongly typed programming language |
| **State Management** | [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) | Predictable state management via BLoC & Cubit |
| **Dependency Injection**| [`flutter_getit`](https://pub.dev/packages/flutter_getit) | Service Locator for loose coupling |
| **Functional Programming**| [`dartz`](https://pub.dev/packages/dartz) | Functional programming & `Either<Failure, T>` error handling |
| **Cloud Backends** | [`firebase_core`](https://pub.dev/packages/firebase_core)<br>[`cloud_firestore`](https://pub.dev/packages/cloud_firestore)<br>[`supabase_flutter`](https://pub.dev/packages/supabase_flutter) | Authentication, Cloud Firestore & Supabase DB integration |
| **Local Storage** | [`hive_flutter`](https://pub.dev/packages/hive_flutter)<br>[`shared_preferences`](https://pub.dev/packages/shared_preferences) | Fast key-value local storage & preferences |
| **UI Components & Icons**| [`iconsax`](https://pub.dev/packages/iconsax)<br>[`google_fonts`](https://pub.dev/packages/google_fonts)<br>[`flutter_svg`](https://pub.dev/packages/flutter_svg)<br>[`shimmer`](https://pub.dev/packages/shimmer)<br>[`lottie`](https://pub.dev/packages/lottie) | Custom typography, vectors, shimmer loaders, and micro-animations |
| **Networking & Media** | [`cached_network_image`](https://pub.dev/packages/cached_network_image)<br>[`http`](https://pub.dev/packages/http) | Network requests and optimized image caching |

---

## 📁 Directory Structure

```text
lib/
├── app.dart                   # Application root widget & theme configuration
├── main.dart                  # Entry point (Initializes services, Firebase, Supabase, GetIt)
├── firebase_options.dart      # Auto-generated Firebase platform configuration
├── navigation_menu.dart       # Main bottom navigation bar setup
│
├── core/                      # Shared core modules & utilities
│   ├── constants/             # API constants, asset strings, enums, colors
│   ├── di/                    # Dependency injection setup (service_locator.dart)
│   ├── layout/                # Responsive layout helpers
│   ├── routes/                # Navigation & routing definitions
│   ├── style/                 # App colors, themes, and typography styles
│   ├── utils/                 # Helpers (NetworkManager, LocalStorage, Validators, Formatters)
│   └── widgets/               # Custom reusable UI widgets (Buttons, Cards, Loaders, Headers)
│
└── features/                  # Feature modules (Feature-First Architecture)
    ├── auth/                  # Authentication feature module
    │   ├── data/              # Auth DataSources & Models
    │   ├── domain/            # Auth Entities & UseCases
    │   └── modules/features/  # Screens: Login, Signup, Onboarding, Forgot Password
    │
    ├── personlization/        # User Profile & Customization feature module
    │   ├── data/              # Profile Data Layer
    │   ├── domain/            # Profile Domain Layer
    │   └── presentation/      # Profile Pages & Settings Widgets
    │
    └── shop/                  # E-Commerce Core Shop feature module
        └── modules/           # All Shop Sub-modules:
            ├── home/          # Home Screen & Banners
            ├── store/         # Store Catalog & Categories
            ├── brand/         # Brand filtering & displays
            ├── products/      # Product Details & Reviews
            ├── favourites/    # Saved Favorite items
            ├── cart/          # Cart management
            ├── checkout/      # Multi-step Checkout
            ├── order/         # Order History & Tracking
            └── wishlist/      # Wishlist Management
```

---

## 🚀 Getting Started

Follow these steps to set up and run the project on your local environment.

### Prerequisites

Ensure you have the following installed:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.9.0 or higher)
- [Dart SDK](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) with Flutter extensions
- Java Development Kit (JDK 17 or higher)

### Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-username/ecommerce_app.git
   cd ecommerce_app
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Environment / Credentials**
   - Ensure `firebase_options.dart` is populated with your Firebase project credentials.
   - Update Supabase URL & Anon Key inside `lib/main.dart` if using your custom Supabase instance.

4. **Run the Application**
   ```bash
   # Run on connected mobile device or emulator
   flutter run

   # Or run specific target
   flutter run -d chrome
   ```

---

## ⚙️ Configuration

### Firebase & Supabase Setup
- **Firebase Core & Auth**: Pre-configured in `firebase_options.dart`. Update rules in Firebase Console for Cloud Firestore.
- **Supabase Client**: Initialized in `lib/main.dart`:
  ```dart
  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL',
    anonKey: 'YOUR_SUPABASE_ANON_KEY',
  );
  ```

### Assets & Fonts
All icons, images, and brand assets are declared under the `assets/` folder and configured inside `pubspec.yaml`.

---

## 🤝 Contributing

Contributions are welcome! Please follow these guidelines:

1. Fork the repository.
2. Create a feature branch (`git checkout -b feat/amazing-feature`).
3. Commit your changes following [Conventional Commits](https://www.conventionalcommits.org/) (`git commit -m 'feat(shop): add product search filter'`).
4. Push to the branch (`git push origin feat/amazing-feature`).
5. Open a Pull Request.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
