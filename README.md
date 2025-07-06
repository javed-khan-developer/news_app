📱 News App
A Flutter application that fetches and displays news articles by category,
allows users to search, bookmark, and browse headlines,
with support for dark/light mode and offline detection.

🚀 Getting Started

🔧 Prerequisites
Ensure you have the following installed:

Flutter SDK v3.29.0

Dart SDK >=3.2.0

Android Studio / VS Code

Emulator or Physical Device

📥 Installation & Run
Clone the repository
git clone https://github.com/javed-khan-developer/news_app.git

Install dependencies
flutter pub get

Run the app
flutter run

📦 Dependencies
Package	Purpose
get	State management: routing
http: Network requests
cached_network_image: Optimized image loading
flutter_screenutil: Responsive UI
connectivity_plus: Network status monitoring
shared_preferences: Store bookmarks locally

📂 Folder Structure
lib/
│
├── controller/         # GetX controllers
│   ├── category_controller.dart
│   ├── bookmark_controller.dart
│   └── theme_controller.dart
│   └── network_controller.dart
│
├── data/
│   ├── model/          # Article model
│   └── provider/       # API service
│
├── core/
│   └── utils/          # Logger, constants, snackbars, theme
│   └── widget/         # Reusable widgets (text, buttons, etc.)
│
├── view/
│   ├── home/           # Home screen
│   ├── category/       # Category screen + search
│   ├── article/        # Article detail screen
│   ├── bookmark/       # Bookmarked articles
│
├── routes/
│   ├── app_pages.dart  # GetX routing
│   └── app_routes.dart
│
└── main.dart
└── app.dart

🎯 Features
✅ Top headlines by category
✅ Infinite scroll & pull-to-refresh
✅ Bookmark/save articles locally
✅ Search news by keywords
✅ Theme toggle: Dark & Light
✅ Offline support with "No Internet" screen
✅ Smooth navigation using GetX
✅ Clean architecture & separation of concerns

🧠 Architecture
State Management: GetX

API Layer: ApiService interacts with NewsAPI

UI Logic: Separated using Controllers 

Routing: Managed using GetMaterialApp and named routes

Persistence: Uses SharedPreferences for bookmarks

🌐 API Used
NewsAPI.org

static const _apiKey = '24aa7134f9724e60a8ab9c255fc4fe83';

❗ Notes
API has request limits; avoid sending excessive search queries.

If offline, the app shows a friendly NoInternetWidget.

Search includes debounce logic to reduce API calls.

👨‍💻 Author
Javed Khan

