# Employee App

Feature-first Flutter app with employee module using BLoC and CRUD-ready UI flow.

## Current Scope

- Employee domain entity and repository contract
- Employee BLoC with load/add/update/delete events
- In-memory repository for local development flow
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
    emplyee/
      presentation/
      application/
      domain/
      data/
  app.dart
  main.dart
```

## Run

```bash
flutter pub get
flutter run
```
