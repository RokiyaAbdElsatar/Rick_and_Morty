# 🛸 Rick and Morty Explorer

A modern Flutter application that integrates with the **Rick and Morty API** to browse, search, filter, view, and export character data.

This project was developed as part of a **Flutter Internship Technical Assessment**.

---

## 📱 Project Overview

**Rick and Morty Explorer** provides a clean and user-friendly experience for exploring characters from the Rick and Morty universe.

The application consumes data from the public **Rick and Morty API** and provides users with the ability to:

- Browse all available characters
- Search characters by name
- Filter character results
- View detailed character information
- Export character data to an **Excel (.xlsx)** file
- Handle loading, empty, and error states gracefully

The project focuses on clean code, reusable components, organized architecture, and a consistent UI/UX.

---

## ✨ Features

### 👽 Characters

- Fetch characters from the Rick and Morty API
- Display character images and information
- Show character status, species, gender, origin, and location
- Open a dedicated character details screen

### 🔍 Search & Filter

- Search characters by name
- Filter API results based on the selected criteria
- Update the UI dynamically as the search/filter state changes
- Handle empty search results with a dedicated empty state

### 📊 Excel Export

Users can export the available character data into an **Excel (.xlsx)** file.

The exported data can include information such as:

- Character name
- Status
- Species
- Gender
- Origin
- Location
- Image URL

### ⚡ State Management

The application uses **Bloc/Cubit** for predictable and reactive state management.

The state layer handles:

- Initial state
- Loading state
- Success state
- Empty state
- Error state
- Search/filter updates

### 🎨 UI/UX

The application was designed with a focus on:

- Clean and consistent visual design
- User-friendly navigation
- Responsive layouts
- Reusable UI components
- Clear loading indicators
- Meaningful empty states
- User-friendly error messages
- Smooth interaction between screens

---

## 🏗️ Architecture

The project follows an MVVM-inspired architecture to separate UI, business logic, and data-related responsibilities.
```text
lib/
│
├── core/
│   ├── constants/      # App-wide constants
│   ├── network/        # Network configuration and API handling
│   ├── router/         # Application navigation
│   ├── theme/          # App theme and styling
│   ├── utils/          # Helper and utility functions
│   └── widgets/        # Reusable UI components
│
├── models/             # Data models
│
├── repositories/       # Data access and repository logic
│
├── services/           # API and external services
│
├── viewmodels/         # Business logic and state management
│
├── views/              # Screens and UI
│
└── main.dart           # Application entry point
```

## 🧠 State Management

The project uses **Flutter Bloc / Cubit** for state management.

Cubit is responsible for managing the application state and notifying the UI whenever the state changes.

Typical flow:

```text
User Action
     ↓
    Cubit
     ↓
Use Case / Repository
     ↓
   API Call
     ↓
Response / Result
     ↓
    Cubit
     ↓
    UI Update
```

This approach keeps business logic outside the UI and makes the application easier to maintain.

---

## 🌐 API Integration

The application integrates with the official **Rick and Morty API**.

### API Documentation

https://rickandmortyapi.com/documentation

### Main API Resource

```text
GET /api/character
```

The application uses the Character endpoints to retrieve and filter character data.

Example:

```text
https://rickandmortyapi.com/api/character
```

Search/filter example:

```text
https://rickandmortyapi.com/api/character/?name=rick
```

---

## 📦 Technologies & Packages

### Core Technologies

- **Flutter**
- **Dart**
- **REST API**
- **Bloc / Cubit**

### Main Packages

| Package | Purpose |
|---|---|
| `flutter_bloc` | State management |
| `dio` | HTTP/API requests |
| `equatable` | State and model comparison |
| `go_router` | Application navigation |
| `excel` | Excel file generation |
| `path_provider` | File system paths |
| `permission_handler` | Runtime permissions |
| `cached_network_image` | Network image caching |
| `flutter_svg` | SVG asset support |

> The exact package versions are available in `pubspec.yaml`.

---

## 📂 Project Structure

A simplified view of the project structure:

```text
Rick_and_Morty/
│
├── android/
├── ios/
├── web/
├── assets/
│
├── lib/
│ └── core/
│   ├── constants/
│   ├── network/
│   ├── router/
│   ├── theme/
│   ├── utils/
│   └── widgets/
│
├── models/
├── repositories/
├── services/
├── viewmodels/
├── views/
│
└── main.dart
│
├── test/
├── pubspec.yaml
├── analysis_options.yaml
└── README.md
```

---

## 📸 Screenshots

### 🏠 Characters Screen


```md
![Splash Screen](screenshots/home.png)
```

### 🏠 Characters Screen


```md
![Characters Screen](screenshots/home.png)
```

### 🔍 Search & Filter

```md
![Search Screen](screenshots/search.png)
```

### 👽 Character Details

```md
![Character Details](screenshots/details.png)
```

### 📊 Excel Export

```md
![Excel Export](screenshots/export.png)
```
---

## 🎥 Demo Video

A short demo video should demonstrate the complete application flow:

1. Launch the application
2. Browse characters
3. Search for a character
4. Apply filters
5. Open character details
6. Export character data to Excel
7. Show the generated `.xlsx` file

### Demo Video

**[▶️ Watch the App Demo](YOUR_VIDEO_LINK_HERE)**

>  

---

## 🚀 Getting Started

Follow these steps to run the project locally.

### 1. Clone the Repository

```bash
git clone https://github.com/RokiyaAbdElsatar/Rick_and_Morty.git
```

### 2. Navigate to the Project

```bash
cd Rick_and_Morty
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run the Application

```bash
flutter run
```

---

## ⚙️ Requirements

Before running the project, make sure you have:

- Flutter SDK installed
- Dart SDK compatible with the Flutter version
- Android Studio or VS Code
- Android Emulator / iOS Simulator or a physical device
- Internet connection for API requests

You can verify your Flutter installation using:

```bash
flutter doctor
```

---

## 📊 Excel Export Flow

The export functionality follows this general flow:

```text
Character Data
      ↓
Prepare Export Data
      ↓
Create Excel Workbook
      ↓
Add Character Rows
      ↓
Generate .xlsx File
      ↓
Save / Share File
```

The generated Excel file contains structured character information that can be opened using applications such as Microsoft Excel or other spreadsheet applications.

---

## 🔄 Application Flow

```text
Splash / App Launch
        ↓
Characters Screen
        ↓
Fetch Characters
        ↓
┌───────────────┬────────────────┐
│               │                │
Search       Select Character   Export
│               │                │
↓               ↓                ↓
Filtered      Details        Excel File
Results        Screen
```

---

## 🔥 Error & State Handling

The application provides dedicated handling for common API and UI states.

### Loading State

While characters are being fetched, the application displays a loading indicator instead of leaving the user with an empty screen.

### Success State

When the API request succeeds, the character list is displayed normally.

### Empty State

If a search or filter returns no results, the application displays a clear empty-state message.

### Error State

If the API request fails, the application displays an appropriate error message and provides a way to retry the request when applicable.

---

## ♻️ Reusable Components

The UI is built using reusable components to avoid unnecessary duplication.

Reusable components can include:

- Character cards
- Search fields
- Filter controls
- Buttons
- Loading widgets
- Empty-state widgets
- Error-state widgets
- App bars
- Common text styles

This makes the codebase easier to maintain and keeps the UI consistent across the application.

---

## 🎯 Requirements Checklist

The project covers the requirements specified in the technical assessment:

| Requirement | Status |
|---|:---:|
| Build using Flutter | ✅ |
| Integrate Rick and Morty API | ✅ |
| Fetch all characters | ✅ |
| Search / Filter characters | ✅ |
| State Management | ✅ |
| Bloc / Cubit | ✅ |
| Export data to Excel `.xlsx` | ✅ |
| Clean & readable code | ✅ |
| Organized project structure | ✅ |
| Reusable components | ✅ |
| Clean UI/UX | ✅ |
| Loading state | ✅ |
| Empty state | ✅ |
| Error state | ✅ |
| GitHub repository | ✅ |
| README documentation | ✅ |
| Demo video | 🎥 |

---

## 🧪 Testing the Main Features

### Fetch Characters

Open the application and wait for the character list to load from the API.

### Search

Enter a character name in the search field and verify that the displayed results match the search query.

### Character Details

Select any character card to open its detailed information.

### Export

Tap the export button and verify that the generated Excel file contains the expected character information.

---

## 🛠️ Possible Future Improvements

The project can be extended with additional features such as:

- Pagination / infinite scrolling
- Advanced multi-filter functionality
- Favorites
- Offline caching
- Dark mode
- Character episodes screen
- Sorting options
- Local database support
- Unit and widget tests
- Share exported Excel files directly from the app

---

## 👩‍💻 Developer

### Rokiya Abd Elsatar

Flutter Developer

**GitHub:**  
https://github.com/RokiyaAbdElsatar

**Repository:**  
https://github.com/RokiyaAbdElsatar/Rick_and_Morty

---

## 📄 License

This project was created as part of a Flutter Internship Technical Assessment.

It is intended for educational and evaluation purposes.

---

## 🙏 Acknowledgements

Special thanks to the creators and maintainers of the **Rick and Morty API** for providing the public API used in this project.

**API:**  
https://rickandmortyapi.com/
