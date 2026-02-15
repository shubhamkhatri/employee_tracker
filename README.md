# Employee App

Feature-first Flutter app with employee module using BLoC and SQLite persistence.

## Current Scope

- Employee domain entity and repository contract
- Employee BLoC with load/add/update/delete events
- SQLite local storage with `sqflite`
- Initial seed data loaded from JSON asset when database is empty
- Employee list screen with add/edit/delete interactions
- Dedicated UI widgets for loading, empty, list, card, form, and FAB
- Country picker integration and INR salary input labels

## Structure

```text
lib/
  core/
    constants/
    theme/
    widgets/
  features/
    employee/
      presentation/
      application/
      domain/
      data/
  app.dart
  main.dart
```

## Tests Included

- BLoC tests for load/add/update/failure states
- Form widget test for default country and INR label
- Employee card rendering test
- App shell widget test with injected fake repository

## Run

```bash
flutter pub get
flutter run
```

## Test

```bash
flutter test
```
