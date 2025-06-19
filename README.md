# 📖 Quran Player

A simple and elegant Flutter application to play audio for each surah in the Holy Quran.

![Platform](https://img.shields.io/badge/Flutter-3.24.3-blue)  
Built using [Flutter](https://flutter.dev) and [just_audio](https://pub.dev/packages/just_audio) for seamless Quran recitation playback.

---

## ✨ Features

- 🎧 Stream and play surah audio directly.
- 🔎 Search surahs by Latin name.
- ⏯️ Play, pause, seek, and navigate between surahs.
- 📜 View surah name, location of revelation.
- 🔁 Auto-reset audio when finished.
- 💡 Smooth and clean UI using `StatelessWidget` with `FutureBuilder` and `Bloc`.
- 📱 Compatible with both Android and iOS.

---

## 🛠️ Technologies Used

- [Flutter](https://flutter.dev/)
- [Bloc](https://pub.dev/packages/flutter_bloc) — untuk state management
- [Just Audio](https://pub.dev/packages/just_audio) — untuk pemutaran audio
- [Flutter Spinkit](https://pub.dev/packages/flutter_spinkit) — untuk animasi loading
- [Flutter Launcher Icons](https://pub.dev/packages/flutter_launcher_icons) — untuk mengganti icon aplikasi
- [HTTP](https://pub.dev/packages/http) — untuk fetch data dari API
- [Equatable](https://pub.dev/packages/equatable) — mempermudah perbandingan state di Bloc

---

## 📷 Screenshots

> *(Add your screenshots here if needed)*

---

## 🚀 Getting Started

### 1. Clone the repository
https://github.com/bagusrivaldi/quran_player
cd quran_player

### 2. Get dependencies
flutter pub get

### 3. Run the app
flutter run


📁 Folder Structure

lib/

├── bloc/                 # Bloc for fetching surah data

├── models/               # Surah model

├── screen/               # All UI components (home, player, widgets)

├── services/             # AudioPlayerService logic

└── main.dart             # Entry point


📚 API Source
This app fetches Quran and audio data from:
👉 https://open-api.my.id/quran