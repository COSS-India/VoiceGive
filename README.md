
# VoiceGive Flutter Application - Setup & Authentication Guide

This document provides a unified guide for setting up your environment, configuring authentication, and following best practices for the VoiceGive Flutter application.

---

## 1. Environment Setup

### Flutter Version
Flutter 3.27.1 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 17025dd882 (10 months ago) • 2024-12-17 03:23:09 +0900
Engine • revision cb4b5fff73
Tools • Dart 3.6.0 • DevTools 2.40.2


### Environment Files
- `.env` (default/development)
- `.env.development` (development)
- `.env.staging` (staging)
- `.env.production` (production)
- `.env.example` (template)

# API Specification Document

Ref Backend installation guide : https://github.com/COSS-India/VoiceGive/blob/dev_api_spec/backend/README.md
Swagger UI : http://43.205.235.156:9000/docs

## Code Structure

### Key Directories

```
VoiceGive/
├── android/                 # Android-specific configuration
├── ios/                     # iOS-specific configuration
├── lib/                     # Main Dart code
│   ├── common_widgets/      # Reusable UI components
│   ├── config/              # App configuration
│   ├── constants/           # App constants
│   ├── l10n/               # Localization files
│   ├── models/             # Data models
│   ├── providers/          # State management
│   ├── screens/            # App screens
│   ├── services/           # API and business logic
│   └── util/               # Utility functions
├── assets/                 # Images, icons, animations
├── build_scripts/          # Build automation scripts
├── documentation/          # Project documentation
└── test/                   # Test files
```

### Key Files

- `pubspec.yaml` - Project dependencies and configuration
- `main.dart` - App entry point
- `android/app/build.gradle` - Android build configuration
- `android/app/src/main/AndroidManifest.xml` - Android permissions and configuration
- `build_scripts/build.sh` - Build automation script
- `l10n.yaml` - Localization configuration

**Variables:**
```
API_BASE_URL=...
ENVIRONMENT=development
```

**Instructions:**
- Verify API URLs for each environment.
- Never commit sensitive tokens to version control.
- Use `.env.local` for local overrides (auto-ignored by git).

**Steps to run the app:**
- flutter clean
- flutter pub get
- flutter pub run build_runner build --delete-conflicting-outputs
- flutter run


**Switch Environment:**
```
flutter run --dart-define=ENVIRONMENT=development
flutter run --dart-define=ENVIRONMENT=staging
flutter run --dart-define=ENVIRONMENT=production
```

**Access in Code:**
```dart
String baseUrl = AppConfig.instance.apiBaseUrl;
String env = AppConfig.instance.environment;
bool isProduction = AppConfig.instance.isProduction;
```

---



### Token Management
- Tokens are stored securely using `flutter_secure_storage`.
- `ApiService` automatically injects tokens into API requests.
- Use `AuthManager` for manual token access if needed.

---

## 2. Best Practices & Security
- **Never commit sensitive tokens** or production API keys to version control.
- Use environment-specific tokens and endpoints.
- Use `.env.local` for local development secrets.
- Validate all input before making API requests.
- Handle token expiration and errors gracefully.
- Use secure storage for all sensitive data.

---

## 3. Troubleshooting
- **Missing environment file:** Ensure `.env` exists in the project root.
- **Missing variables:** Check all required variables are defined.
- **Build errors:** Run `flutter pub get` after adding dependencies.
- **Token issues:** Verify tokens and permissions.
- **Authentication errors:** Check API endpoints and request formats.

---

## 4. Support
- For more details, see code comments and the `AppConfig`, `AuthManager`, and `AuthProvider` classes.
- Contact the development team for further help.
