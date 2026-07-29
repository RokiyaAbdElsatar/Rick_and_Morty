# Rick & Morty Explorer

A Flutter application built for a Flutter Internship assessment. This app consumes the [Rick and Morty API](https://rickandmortyapi.com/) to browse and search characters from the show.

## Features

- Browse all Rick and Morty characters
- Infinite scroll pagination (20 characters per page)
- Search characters by name with 500ms debounce
- Character detail screen with full information
- Export displayed characters to Excel (.xlsx)
- Responsive Material 3 design
- Cached network images for optimal performance

## Architecture

**MVVM** (Model-View-ViewModel) with Repository Pattern.

```
lib/
├── core/               # Foundation layer
│   ├── constants/      # API constants
│   ├── network/        # Dio client setup
│   ├── router/         # GoRouter configuration
│   ├── theme/          # Material 3 theme
│   ├── utils/          # Helpers & extensions
│   └── widgets/        # Reusable widgets
├── models/             # Data models (Equatable)
├── services/           # API service layer
├── repositories/       # Repository pattern
├── viewmodels/         # Cubit state management
└── views/              # UI screens & widgets
```

### Data Flow

```
UI (Views) → Cubit (ViewModels) → Repository → Service → API
```

## Packages

| Package | Purpose |
|---|---|
| `flutter_bloc` | State management (Cubit) |
| `dio` | HTTP client |
| `go_router` | Navigation & routing |
| `equatable` | Value equality |
| `cached_network_image` | Image caching |
| `excel` | Excel file generation |
| `path_provider` | File system paths |
| `intl` | Date formatting |

## Screenshots

| Home Screen | Details Screen |
|---|---|
| ![Home](screenshots/home.png) | ![Details](screenshots/details.png) |

## Video Demo

*Add demo video link here*

## How to Run

1. Ensure Flutter SDK is installed (latest stable)
2. Clone the repository
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```
5. Build APK:
   ```bash
   flutter build apk --release
   ```

## API Documentation

This app uses the [Rick and Morty API](https://rickandmortyapi.com/documentation) Character endpoints:

- `GET /api/character` - Fetch all characters (supports pagination via `?page=`)
- `GET /api/character/?name={name}` - Search characters by name
- `GET /api/character/{id}` - Get single character details

## Project Structure

```
rick_and_morty_app/
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   │   └── api_constants.dart
│   │   ├── network/
│   │   │   ├── api_client.dart
│   │   │   └── endpoints.dart
│   │   ├── router/
│   │   │   ├── app_router.dart
│   │   │   └── routes.dart
│   │   ├── theme/
│   │   │   └── app_theme.dart
│   │   ├── utils/
│   │   │   ├── date_formatter.dart
│   │   │   └── status_helper.dart
│   │   └── widgets/
│   │       └── app_error_widget.dart
│   ├── models/
│   │   └── character_model.dart
│   ├── services/
│   │   └── character_service.dart
│   ├── repositories/
│   │   └── character_repository.dart
│   ├── viewmodels/
│   │   └── character/
│   │       ├── character_cubit.dart
│   │       ├── character_state.dart
│   │       └── search_debounce.dart
│   ├── views/
│   │   ├── home/
│   │   │   ├── home_screen.dart
│   │   │   └── widgets/
│   │   │       ├── character_card.dart
│   │   │       ├── search_field.dart
│   │   │       ├── loading_widget.dart
│   │   │       ├── empty_widget.dart
│   │   │       └── error_widget.dart
│   │   └── details/
│   │       └── character_details_screen.dart
│   └── main.dart
├── pubspec.yaml
└── README.md
```
