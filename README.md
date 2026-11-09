# TreeTales

TreeTales is a Flutter prototype for learning about trees, forests, and everyday conservation. The home screen features tree imagery and short conservation tips.

## Features

- Splash screen and onboarding flow
- Home screen with featured tree images and rotating conservation tips
- Shared bottom navigation for Home, Community, Encyclopedia, and Settings

## Getting started

Install Flutter with Dart 3.10 or later and have an emulator or device ready. From the project root, run:

```bash
flutter pub get
flutter run
```

The prototype uses bundled images and tips. No API keys are required to explore the current screens.

## Project structure

- `lib/core/` contains app routes, theme definitions, and shared constants.
- `lib/presentation/` contains screens and view models grouped by feature. The home screen uses a `ChangeNotifier` view model to track the active conservation tip.
- `lib/shared/widgets/` contains reusable widgets, including the bottom navigation.

## Roadmap

- Add a searchable tree encyclopedia.
- Build an interactive forest map.
- Add photo-based tree identification.
- Implement a carbon footprint calculator.
