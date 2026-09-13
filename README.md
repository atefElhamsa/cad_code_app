# C&C Academy (CAD & Code Academy) 🎓

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)

C&C Academy is a premium e-learning platform built with Flutter. It provides an elegant, responsive, and seamless experience for students to access courses, video sessions, and interactive content.

## ✨ Features

- **📱 Fully Responsive UI:** Optimized for all screen sizes using `flutter_screenutil`.
- **🎨 Premium Design:** Modern aesthetic with a custom theme, dark/light element contrast, and smooth micro-animations.
- **🔐 Secure Access:** Course and folder locking mechanism with access codes.
- **▶️ Video Player Integration:** Seamless in-app video playback for course sessions.
- **🗂️ Clean Architecture:** Highly maintainable codebase structured using Clean Architecture principles (Data, Domain, Presentation).
- **🚀 State Management:** Powered by `flutter_bloc` (Cubits) for predictable and efficient state management.
- **☁️ Backend:** Integrated with Supabase for robust and fast backend services.
- **🧭 Routing:** Advanced navigation and deep-linking using `go_router`.

## 🛠️ Tech Stack

- **Framework:** Flutter
- **Language:** Dart
- **Backend:** Supabase
- **State Management:** Bloc / Cubit
- **Routing:** GoRouter
- **Responsiveness:** Flutter ScreenUtil
- **Animations:** Flutter Animate
- **Dependency Injection:** GetIt

## 📂 Project Structure

The project follows a feature-based Clean Architecture:

```text
lib/
├── core/               # App-wide core utilities (theme, routes, network, constants)
├── features/           # App features
│   ├── auth/           # Authentication feature
│   ├── courses/        # Courses and Folders browsing
│   ├── course_workspace/ # Video sessions and course content
│   └── splash/         # Splash screen and onboarding
├── widgets/            # Shared/Global widgets
└── main.dart           # App entry point
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Supabase Project (for backend configuration)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/cad_code_academy.git
   cd cad_code_academy
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure Environment Variables:**
   Ensure you have your Supabase URL and Anon Key configured in your environment or initialization setup.

4. **Run the app:**
   ```bash
   flutter run
   ```

## 🎨 UI / UX Highlights

- **RTL Support:** The application is fully optimized for Arabic (Right-to-Left) layout directionality.
- **Shimmer Loaders:** Elegant skeleton loading screens for a better user experience while fetching data.
- **Image Optimization:** Cached network images with proper aspect ratios to prevent clipping and memory bloat.

## 🤝 Contributing
Contributions, issues, and feature requests are welcome!

---
*Built with ❤️ for C&C Academy.*
