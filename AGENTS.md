# AGENTS.md

Flutter app (Dart) — "AI Student Assistant". Scaffolded with `flutter create`; app display name is "AI Student Assistant", package name `ai_student_assistant`.

## Commands

- `flutter run` — run the app (Windows desktop available on this machine)
- `flutter test` — run widget tests (`test/widget_test.dart`)
- `flutter analyze` — static analysis; run after code changes
- `dart format .` — formatting

## Structure

- `lib/main.dart` — single entrypoint; `AIStudentAssistantApp` (MaterialApp) → `HomeScreen`. No feature folders or state management yet; keep it simple until a real architecture is decided.
- `test/widget_test.dart` — smoke test asserting home screen renders; update when UI changes.

## Gotchas

- App display name is set per-platform ("AI Student Assistant"): `android/app/src/main/AndroidManifest.xml`, `ios/Runner/Info.plist`, `windows/runner/Runner.rc` + `main.cpp`, `linux/runner/my_application.cc`, `web/index.html` + `web/manifest.json`. Keep them in sync when renaming.
- Bundle ID is `com.aistudentassistant.ai_student_assistant` (do not change casually).
- The working directory path contains a space (`D:\code\dart\Student Assistant`) — quote paths in shell commands.
- Not a git repo yet; initialize with `git init` before committing.
