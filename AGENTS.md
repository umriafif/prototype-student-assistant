# AGENTS.md

Flutter app (Dart) — "AI Student Assistant". Scaffolded with `flutter create`; app display name is "AI Student Assistant", package name `ai_student_assistant`.

## Commands

- `flutter run` — run the app (Windows desktop available on this machine)
- `flutter test` — run widget tests (`test/widget_test.dart`)
- `flutter analyze` — static analysis; run after code changes
- `dart format .` — formatting

## Structure

- `lib/main.dart` — entrypoint; `AIStudentAssistantApp` (MaterialApp) → `ChatScreen`. No state management or service layer yet; keep simple until architecture is decided.
- `lib/chat_screen.dart` — chat UI (the current home): header with hamburger + `Sign in`/`Register` pill buttons (push `SignInScreen` / `SignUpScreen`), empty-state hero ("Student Assistant" / "New Chat"), UI-only input bar (image/code icons + send button; no real messaging or AI yet). The hamburger opens the `AppDrawer` (early hero `AppLogo` was deliberately removed by commit "delete logo on hero center" — don't re-add).
- `lib/widgets/app_sidebar.dart` — reusable sidebar: `AppSidebar` (content) + `AppDrawer` (wraps it in a 280px `Drawer`), so any page can use `Scaffold(drawer: const AppDrawer())`. `loggedIn`/`userEmail` params switch between logged-out (empty list, no footer) and logged-in views (mock chat list, active first item, avatar + email + settings footer). All taps are snackbar placeholders; chat titles are mock data (`_sampleChats`).
- `lib/signup_screen.dart` — signup form (`SignUpScreen`): logo, Google/Facebook and app logo painted via `CustomPaint`, Indonesian validation, mixed EN/ID labels ("ATAU", "Masukkan Email"). Bottom outline button opens `SignInScreen`.
- `lib/signin_screen.dart` — sign-in form (`SignInScreen`), mirror of signup layout (Email + Password only, no repeat field). Bottom outline button opens `SignUpScreen`. Note: shared auth widgets (logo, brand icons, divider, back button, field styles) are intentionally duplicated per-screen, not extracted.
- `test/widget_test.dart` — tests: chat screen renders (hero, no mock messages), Register/Sign in open auth screens, hamburger opens sidebar (logged out), sidebar logged-in content (via `AppDrawer(loggedIn: true)` + `ScaffoldState.openDrawer()`), form validation, cross-navigation. Note tests set `tester.view.physicalSize` tall (1200x2600) so the whole scrollable signup form is laid out.

## Conventions & gotchas

- App display name is set per-platform ("AI Student Assistant"): `android/app/src/main/AndroidManifest.xml`, `ios/Runner/Info.plist`, `windows/runner/Runner.rc` + `main.cpp`, `linux/runner/my_application.cc`, `web/index.html` + `web/manifest.json`. Keep them in sync when renaming.
- Bundle ID is `com.aistudentassistant.ai_student_assistant` (do not change casually).
- Dark UI color is `Color(0xFF1C1C1E)`; keep colors consistent across screens (constants per file, no theme tokens yet).
- The working directory path contains a space (`D:\code\dart\Student Assistant`) — quote paths in shell commands.
- Active branch is `development`; `git init` + first commits already done (`Init`, chat page). Only commit when asked.
