# StudyBuddy 📚

A comprehensive Flutter-based language learning application that combines interactive study tools with gamified learning experiences. StudyBuddy helps users master new languages through flashcards, translation exercises, matching games, and community features.

## ✨ Features

### 🎯 Core Learning Tools
- **Flashcards System**: Create, manage, and study personalized flashcards with spaced repetition
- **Translation Exercises**: Practice translating words and phrases with interactive feedback
- **Matching Games**: Memory-based games to reinforce vocabulary connections
- **Word Lists**: Organized vocabulary management with categorization

### 🏆 Gamification & Progress
- **Ranking System**: Compete with other learners on leaderboards
- **Progress Tracking**: Monitor your learning journey with detailed statistics
- **Achievement System**: Unlock rewards as you reach learning milestones

### 👥 Social Features
- **Community Page**: Connect with other language learners
- **User Profiles**: Customize your learning experience and share progress
- **External User Discovery**: Find and connect with new study partners

### 🔧 Technical Features
- **Cross-Platform**: Works on Android, iOS, Web, Windows, and macOS
- **Real-time Sync**: Cloud-based data storage with Firebase
- **Offline Support**: Continue learning even without internet connection
- **Multi-language Support**: Internationalization ready with ARB files

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (>=3.0.6)
- [Dart SDK](https://dart.dev/get-dart) (>=3.0.6)
- [Android Studio](https://developer.android.com/studio) (for Android development)
- [Xcode](https://developer.apple.com/xcode/) (for iOS development, macOS only)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/Study-Buddy.git
   cd Study-Buddy
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase** (Required for full functionality)
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable Authentication and Firestore
   - Download `google-services.json` for Android and `GoogleService-Info.plist` for iOS
   - Place them in the appropriate platform directories
   - Update `lib/firebase_options.dart` with your Firebase configuration

4. **Run the app**
   ```bash
   flutter run
   ```

## 🏗️ Project Structure

```
lib/
├── src/
│   ├── app.dart                 # Main app configuration
│   ├── constants/               # App-wide constants (colors, styles)
│   ├── data_structures/        # Custom data structures and algorithms
│   ├── functions/              # Utility functions
│   ├── localization/           # Internationalization files
│   ├── pages/                  # App screens and views
│   │   ├── auth_management/    # Login and signup
│   │   ├── comunity/          # Community features
│   │   ├── flashcards/        # Flashcard management
│   │   ├── palabras/          # Word list management
│   │   ├── parejas/           # Matching games
│   │   ├── ranking/           # Leaderboards
│   │   ├── traduccion/        # Translation exercises
│   │   └── user/              # User profile management
│   ├── services/              # Business logic and API calls
│   ├── settings/              # App settings and configuration
│   └── widgets/               # Reusable UI components
├── firebase_options.dart       # Firebase configuration
└── main.dart                  # App entry point
```

## 🎮 How to Use

### Creating Flashcards
1. Navigate to the Flashcards section
2. Tap the floating action button (+)
3. Enter the word, definition, and optional notes
4. Save and start studying!

### Playing Matching Games
1. Go to the Parejas (Matching) section
2. Tap "Iniciar" to begin
3. Match terms with their definitions
4. Complete the game to see your score

### Translation Practice
1. Access the Traducción section
2. Choose your difficulty level
3. Translate the given words/phrases
4. Get instant feedback on your answers

## 🛠️ Technologies Used

- **Frontend**: Flutter, Dart
- **Backend**: Firebase (Authentication, Firestore)
- **State Management**: Provider
- **UI Components**: Material Design, Custom Widgets
- **Data Structures**: Custom implementations (AVL Trees, Heaps, Graphs, etc.)
- **Localization**: Flutter Internationalization (ARB files)

## 📱 Supported Platforms

- ✅ Android (API 21+)
- ✅ iOS (12.0+)
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🔧 Configuration

### Firebase Setup
The app requires Firebase for authentication and data storage. Ensure you have:
- Firebase project created
- Authentication enabled (Email/Password)
- Firestore database configured
- Proper security rules set

### Environment Variables
No additional environment variables are required beyond Firebase configuration.

## 🧪 Testing

Run the test suite with:
```bash
flutter test
```

The project includes comprehensive tests for:
- Data structures and algorithms
- Utility functions
- Widget components
- Unit tests

## 📦 Dependencies

Key dependencies include:
- `firebase_core`: Firebase initialization
- `firebase_auth`: User authentication
- `cloud_firestore`: Cloud database
- `provider`: State management
- `flutter_svg`: SVG image support
- `flip_card`: Flashcard animations
- `auto_size_text`: Responsive text sizing

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Team

StudyBuddy was developed by Team 5 as part of the ED-Proy project. Check the `docs/` folder for detailed project documentation and reports.

## 📞 Support

If you encounter any issues or have questions:
1. Check the existing issues in the repository
2. Create a new issue with detailed information
3. Contact the development team

## 🚀 Roadmap

- [ ] Advanced analytics and learning insights
- [ ] AI-powered study recommendations
- [ ] Voice recognition for pronunciation practice
- [ ] Offline-first architecture improvements
- [ ] Additional language support
- [ ] Social learning features enhancement

---

**Happy Learning! 🎓✨**
