# 📰 Flutter News App

A modern news application built with Flutter, featuring real-time news updates, a clean Material Design interface, and seamless user experience.

![Last Commit](https://img.shields.io/github.com/eslamabid175/flutter_news_app)
![Flutter Version](https://img.shields.io/badge/Flutter-3.19.0-blue)
![License](https://img.shields.io/badge/License-MIT-green)

## 📱 Screenshots

<p align="center">
  <img src="assets/screenshots/home_screen.png" width="200" alt="Home Screen"/>
  <img src="assets/screenshots/details_screen.png" width="200" alt="Article Details"/>
  <img src="assets/screenshots/favorite_screen.png" width="200" alt="Favorite Screen"/>
</p>

## ✨ Features

- **🎯 Clean Architecture**: Following Clean Architecture principles for maintainable and scalable code
- **🔄 Real-time Updates**: Latest news with pull-to-refresh functionality
- **🎨 Modern UI**: Material Design with custom animations and transitions
- **🔍 Search**: Advanced search functionality with categories
- **📱 Responsive**: Works seamlessly across different screen sizes
- **🌙 Dark Mode**: Built-in dark mode support
- **💾 Offline Support**: Cache mechanism for offline reading

## 🏗️ Architecture

```
lib/
├── core/
│   ├── themeing/
│   ├── networking/
│   ├── utils/
│   ├── constants/
│   ├── errors/
│   ├── services/
│   └── widgets/
├── features/
│   └── home/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── main.dart
```

## 🛠️ Technologies Used

- **State Management**: BLoC Pattern
- **Dependency Injection**: GetIt
- **API Integration**: Dio
- **Local Storage**: Hive
- **Image Loading**: Cached Network Image
- **Navigation**: Go Router
- **Testing**: Unit & Widget Tests

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.19.0 or higher)
- Dart SDK (3.0.0 or higher)
- IDE (VS Code or Android Studio)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/eslamabid175/flutter_news_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## 🎯 Project Structure

- `lib/core/`: Core functionality and shared components
- `lib/features/`: Feature-specific modules
- `lib/domain/`: Business logic and entities
- `lib/data/`: Data handling and repositories
- `lib/presentation/`: UI components and screens

## 🔧 Configuration

1. Create a `.env` file in the root directory
2. Add your API key:
```env
API_KEY=your_api_key_here
```

## 📱 Key Features Breakdown

### Home Screen
- Dynamic news carousel
- Category-based tabs
- Pull-to-refresh functionality
- Infinite scroll pagination

### Article Details
- Rich text content
- Share functionality
- Bookmarking support
- Related articles

### Search
- Real-time search suggestions
- Category filters
- History tracking
- Advanced sorting options

## 🧪 Testing

Run tests using:
```bash
flutter test
```

## 📦 Dependencies

```yaml
dependencies:
  flutter_bloc: ^8.1.3
  dio: ^5.4.0
  get_it: ^7.6.4
  cached_network_image: ^3.3.1
  carousel_slider: ^4.2.1
  smooth_page_indicator: ^1.1.0
  # ... other dependencies
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👤 Author

**Eslam Abid**
- GitHub: [@eslamabid175](https://github.com/eslamabid175)

## 🙏 Acknowledgments

- [News API](https://newsapi.org/) for providing the news data
- Flutter team for the amazing framework
- All contributors who helped in this project

---
Last Updated: 2025-04-03 17:35:06 UTC by @eslamabid175