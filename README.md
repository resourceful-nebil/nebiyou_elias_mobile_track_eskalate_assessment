# 🌍 Flutter Countries App

A beautiful Flutter app that lists countries with flags, population, and details, and allows users to search and favorite countries. Built using Clean Architecture and BLoC state management.

---

## 🚀 Features

- 🌐 Fetches data from the REST Countries API
- 🔍 Real-time search by country name
- ❤️ Add/remove favorites with local persistence (SharedPreferences)
- 📄 Country detail view with full info
- 🌓 Dark Mode support
- 🔄 Pull-to-refresh functionality

---

## 📁 Project Structure

This app uses **Clean Architecture** (simplified) with `flutter_bloc` and `injectable` for dependency injection.

lib/
├── core/ # Shared utilities/constants
├── data/ # API service, repository impl
├── domain/ # Entity, repository contract, use cases
├── presentation/ # Bloc, UI pages, widgets
├── injection.dart # DI entry point (GetIt + Injectable)
├── app_module.dart # Module for external dependencies
└── main.dart # App bootstrap



---

## 🧠 Why BLoC + Clean Architecture?

- **Separation of concerns**: Each layer has a clear role (data, domain, UI)
- **Testability**: Logic is isolated and easy to test
- **Scalability**: Great for adding new features like regions, filters, etc.
- **BLoC**: Makes state changes explicit and trackable

---

## 🛠 Setup & Run

### Prerequisites

- Flutter SDK installed (version 3.x or above)
- Android/iOS emulator or device
- Internet connection (uses REST Countries API)

### Steps

```bash
# 1. Clone the repository
git clone https://github.com/your-username/flutter-countries-app.git
cd flutter-countries-app

# 2. Install dependencies
flutter pub get

# 3. Generate dependency injection files
flutter pub run build_runner build --delete-conflicting-outputs

# 4. Run the app
flutter run


# 🎥 Demo




# 📦 Packages Used
- flutter_bloc

- get_it

- injectable

- shared_preferences

- http

- pull_to_refresh

- google_fonts

✨ Contributions
Feel free to fork this repo, submit PRs, or open issues. Contributions are welcome!

📝 License
This project is licensed under the MIT License.