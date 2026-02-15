# Project Structure

This project follows feature-first organization.

```text
lib/
  core/
    constants/
    theme/
    widgets/
  features/
    emplyee/
      presentation/
        views/
        widgets/
      application/
        bloc/
      domain/
        entities/
        repositories/
      data/
        datasources/
        models/
        repositories/
  app.dart
  main.dart
```

Notes:
- `core/` contains reusable app-level building blocks.
- `features/emplyee/` is intentionally scaffolded for incremental TDD commits.
