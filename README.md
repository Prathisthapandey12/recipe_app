# Flutter Recipe App

A modern and clean **Recipe App** built with **Flutter** and **Firebase**.  
Users can browse delicious recipes, add their favorites, and securely log in/out using Firebase Authentication.

---

## Features

- **View Recipes**  
  Browse a variety of dishes with beautiful UIs and descriptions.

- **Add to Favorites**  
  Save your favorite recipes to your profile for quick access later.

- **User Authentication**  
  Sign in and log out securely using Firebase Auth.

- **Firestore Integration**  
  All recipes and user favorites are stored and retrieved from **Cloud Firestore**.

---

## Built With

- [Flutter](https://flutter.dev/) – UI framework for building native apps
- [Firebase Authentication](https://firebase.google.com/products/auth) – Handles user login/logout
- [Cloud Firestore](https://firebase.google.com/products/firestore) – Stores recipes and favorites
- [SharedPreferences](https://pub.dev/packages/shared_preferences) – Stores local user state

---

## Screenshots

> _You can add screenshots here of your app UI_

- Login Screen  
- Recipe List  
- Favorite Recipes  
- Profile Page with Logout

---

## Getting Started

### 1. Clone the repo
```bash
git clone https://github.com/yourusername/recipe-app-flutter.git
cd recipe-app-flutter
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Set up Firebase
- Create a Firebase project
- Enable Firebase Authentication (Email/Password)
- Set up Cloud Firestore
- Download `google-services.json` or `GoogleService-Info.plist` and place it in the correct directory

### 4. Run the app
```bash
flutter run
```

---

## Folder Structure

```
lib/
├── main.dart
├── screens/
│   ├── login_screen.dart
│   ├── home_screen.dart
│   └── profile_screen.dart
├── services/
│   ├── auth_service.dart
│   └── firestore_service.dart
├── widgets/
│   └── recipe_card.dart
```

---

## Future Features (Ideas)

- Search for recipes by keyword
- Upload images for custom recipes
- Add your own recipe
- Comments or ratings

---

## Contributing

Feel free to open an issue or submit a pull request. Contributions are welcome!

---

## License

This project is open-source and available under the [MIT License](LICENSE).

---

## Contact

Built by [Your Name]  
GitHub: [@yourusername](https://github.com/yourusername)

