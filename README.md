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

## Implementation Details

### AI Usage Transparency

- **How AI was used**: AI assistance was used to speed up architecture setup, CRUD flow scaffolding, UI refactors, and test case drafting.
- **Tools used**: Primarily code generation/editing support and iterative prompt-based refinements during implementation.
- **Prompt style**: Short, task-focused prompts were used (for example: implement CRUD with SQLite, refactor to feature-first+BLoC, improve UI polish, add tests).
- **Rationale**: AI was used to accelerate repetitive coding tasks and explore UI/structure iterations quickly while keeping the final design and logic decisions manually reviewed.
- **Validation**: Final code paths, naming, architecture choices, and behavior were manually reviewed and adjusted to fit project requirements.

## Run

```bash
flutter pub get
flutter run
```

## Test

```bash
flutter test
```
