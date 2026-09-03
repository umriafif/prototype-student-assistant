# AGENTS.md

Flutter app (Dart) — "AI Student Assistant". Scaffolded with `flutter create`; app display name is "AI Student Assistant", package name `ai_student_assistant`.

## Commands

- `flutter run` — run the app (Windows desktop available on this machine)
- `flutter test` — run widget tests (`test/widget_test.dart`)
- `flutter analyze` — static analysis; run after code changes
- `dart format .` — formatting

## Structure

- `lib/main.dart` — entrypoint; `AIStudentAssistantApp` (MaterialApp) → `ChatScreen`. No state management or service layer yet; keep simple until architecture is decided.
- `lib/chat_screen.dart` — chat UI (the current home). Header has `Register`/`Sign in` pill buttons that push `SignUpScreen` / show placeholder snackbars. All UI is static; code block is tokenized mock content (`_codeLines`), not a real AI response.
- `lib/signup_screen.dart` — signup form (`SignUpScreen`) with the app logo / Google / Facebook logos painted via `CustomPaint` (no asset files). Validation messages are Indonesian; UI labels mix English + Indonesian ("ATAU", "Masukkan Email").
- `test/widget_test.dart` — tests: chat screen renders, Register opens signup, form validation errors. Note tests set `tester.view.physicalSize` tall (1200x2600) so the whole scrollable signup form is laid out.

## Conventions & gotchas

- App display name is set per-platform ("AI Student Assistant"): `android/app/src/main/AndroidManifest.xml`, `ios/Runner/Info.plist`, `windows/runner/Runner.rc` + `main.cpp`, `linux/runner/my_application.cc`, `web/index.html` + `web/manifest.json`. Keep them in sync when renaming.
- Bundle ID is `com.aistudentassistant.ai_student_assistant` (do not change casually).
- Dark UI color is `Color(0xFF1C1C1E)`; keep colors consistent across screens (constants per file, no theme tokens yet).
- The working directory path contains a space (`D:\code\dart\Student Assistant`) — quote paths in shell commands.
- Active branch is `development`; `git init` + first commits already done (`Init`, chat page). Only commit when asked.
