# Mx Flutter Components

---

## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Mx Flutter Components works on iOS, Android.

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---
## 🔥 Package Diagram
<img src="https://github.com/ThuyenPV/mx-flutter-components/blob/main/screenshots/system.png" alt="mx package diagram" width="100%" height="auto"/>


## 🔥 Demo Video
|                                                                                                                                                          |
| -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ![fullscreen](screenshots/demo_video.gif)
|                                                                                                                                                          |


We're genuinely happy when received the feedback from all ❤️