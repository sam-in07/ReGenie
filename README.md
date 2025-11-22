# ReGenie 🌍✨

## 💡 Meaning of **"ReGenie"**

It’s a blend of two powerful ideas:

* **"Regen"** — short for *Regenerate*, *Renewal*, *Green Energy* 🌿

    * Represents nature’s ability to restore, heal, and grow.
* **"Genie"** 🧞‍♂️ — a magical helper that guides and assists.

### 🌱 **ReGenie = "A smart, magical helper that helps regenerate the planet."** 💚

---

# 🚀 How to Run This Project

## **1️⃣ Clone the Repository**

```bash
git clone https://github.com/sam-in07/ReGenie.git
cd ReGenie
```

## **2️⃣ Install Dependencies**

```bash
flutter pub get
```

## **3️⃣ Setup Firebase (Required)**

### Install FlutterFire CLI:

```bash
dart pub global activate flutterfire_cli
```

### Configure Firebase:

```bash
flutterfire configure
```

## **4️⃣ Run the App**

### For Android:

```bash
flutter run
```

### For Web:

```bash
flutter run -d chrome
```

---

# 📦 Dependencies Used

```yaml
dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.8
  google_mobile_ads: ^6.0.0

  # State management
  flutter_bloc: ^9.1.1
  equatable: ^2.0.7

  # Fonts
  google_fonts: ^6.3.2

  # HTTP client
  http: ^1.5.0

  # Firebase
  firebase_core: ^4.2.1
  cloud_firestore: ^6.1.0
  firebase_auth: ^6.1.2
  google_sign_in: ^7.2.0
  firebase_storage: ^13.0.4

  # Functional programming
  dartz: ^0.10.1

  # Local Database
  sqflite: ^2.4.2
  isar: ^3.1.0+1

  # Connectivity
  connectivity_plus: ^7.0.0

  # Paths
  path: ^1.9.1
  path_provider: ^2.1.5
  shared_preferences: ^2.5.3

  # UI Enhancements
  pinput: ^5.0.2
  animations: ^2.1.0
  flutter_animate: ^4.5.2
  simple_animations: ^5.2.0
  lottie: ^3.3.2
  loading_animation_widget: ^1.3.0
  shimmer: ^3.0.0
  flutter_svg: ^2.2.2
  fluttertoast: ^9.0.0

  # Maps & Location
  google_maps_flutter: ^2.13.1
  geolocator: ^14.0.2

  # Env
  flutter_dotenv: ^6.0.0

  # Formatting
  intl: ^0.20.2

  # AI
  google_generative_ai: ^0.4.7
  flutter_markdown_plus: ^1.0.5

  # Charts
  fl_chart: ^1.1.1

  # Device Info
  device_info_plus: ^12.2.0
```

---

# 📂 Folder Structure

This project follows **Clean Architecture**, ensuring scalability, maintainability, and testability.

```
lib/
├── core/                        # Core utilities and shared functionality
│   ├── error/                   # Custom exceptions & failures
│   ├── firebase/                # Firebase services
│   ├── storage/                 # Local storage tools
│   └── utils/                   # Helpers & formatters
├── data/                        # Data Layer (Remote & Local)
│   ├── datasources/             # Firebase & API data sources
│   ├── models/                  # DTO Models
│   └── repositories/            # Repository Implementations
├── domain/                      # Business Logic Layer
│   ├── entities/                # Business Models
│   ├── repositories/            # Repository Contracts
│   └── usecases/                # UseCases for business rules
├── presentation/                # UI Layer
│   ├── FeatureName/             # Screens + BLoC
│   ├── navigation/              # App Routes & Navigation
│   └── widgets/                 # Reusable Widgets
├── main.dart                    # App Entry Point
└── bugisugi.txt                 # Placeholder
```

---

# ⭐ Additional Sections Coming Soon

This README will continue to grow with:

* 🔥 Feature list
* 🧠 AI chatbot explanation
* 📸 UI screenshots
* 🏗️ Architecture diagram
* 🏆 Leaderboard system overview
* 🚀 Future improvements

---



# 📄 License

# MIT License © 2025 Team- ECHOBLOC
