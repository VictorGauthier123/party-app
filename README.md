# Party App - Flutter Party Mini-Games

This Flutter project is a mobile application in french providing several classic party games in a single interface. It is designed for quick use and a customized UI, making it ideal for casual group settings.

## Screenshots

<div style="display: flex; gap: 10px;">
  <img width="270" height="520" alt="image1" src="https://github.com/user-attachments/assets/fd950b20-6957-4286-a2e9-a26b2c78c7fa" />
  <img width="270" height="520" alt="image2" src="https://github.com/user-attachments/assets/90a05219-a24b-48c5-b0d9-39b4098199d5" />
  <img width="270" height="520" alt="image" src="https://github.com/user-attachments/assets/280409d3-6512-448c-bd46-456170e0c17b" />

  <img width="270" height="520" alt="image" src="https://github.com/user-attachments/assets/1a1890dc-20f8-4624-9682-ca03b0891664" />
  
  <img width="270" height="520" alt="image" src="https://github.com/user-attachments/assets/59f28315-a63d-490f-b019-765b91f17468" />
  
  <img width="270" height="520" alt="image" src="https://github.com/user-attachments/assets/602f13a8-9c31-4497-8f2a-ae2613926ca0" />
</div>









## Features

- **Never Have I Ever**: Randomized statements across three themes: normal, party, and hot.
- **Truth or Dare**: Choose from multiple categories and get random questions or dares.
- **Would You Rather**: Fun or provocative dilemmas depending on the selected type.
- **Palmier**: Draw cards randomly with associated rules.
- **Plus or Minus**: Guess a number between 1 and 50 in five attempts.
- **Russian Roulette**: Visual spinning wheel to pick one player at random.
- **Dice Game (Biskit)**: Dice rolling animation with custom logic.

## Installation & Build

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Stable version)
- Android Studio or any IDE that supports Flutter
- Android emulator or a physical Android device

### Steps

1. Clone the repository:
   ```bash
   git clone https://github.com/VictorGauthier123/party-app.git
   cd party-app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app on a device or emulator:
   ```bash
   flutter run
   ```

4. Build a debug APK:
   ```bash
   flutter build apk --debug
   ```

   The APK will be located at:
   ```
   build/app/outputs/flutter-apk/app-debug.apk
   ```

## Project Structure

```
lib/
├── home_page.dart
├── never_have_i_ever.dart
├── truth_or_dare.dart
├── would_you_rather.dart
├── palmier.dart
├── plus_ou_moins.dart
├── roulette_russe.dart
├── jeu_des_des.dart
assets/
├── emoji_normal.png
├── emoji_soiree.png
├── emoji_sexe.png
├── cards/
├── dice/
```

## Customization

- Add new game types or categories easily
- Modify rules via code or potential future backend
- Multi-language support not currently implemented

## Technology Stack

- Flutter 3.x
- Dart
- No major third-party dependencies

## License

This project is licensed under the MIT License.

## Author

Developed by Victor Gauthier as part 
