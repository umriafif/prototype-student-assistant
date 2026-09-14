# AGENTS.md

Flutter app (Dart) — "AI Student Assistant". Scaffolded with `flutter create`; app display name is "AI Student Assistant", package name `ai_student_assistant`.

## Commands

- `flutter run` — run the app (Windows desktop available on this machine)
- `flutter test` — run widget tests (`test/widget_test.dart`)
- `flutter analyze` — static analysis; run after code changes
- `dart format .` — formatting

## Structure

- `lib/main.dart` — entrypoint; `AIStudentAssistantApp` (MaterialApp) → `ChatScreen`. No state management or service layer yet; keep simple until architecture is decided.
- `lib/chat_screen.dart` — chat UI (the current home): header with hamburger + `Sign in`/`Register` pill buttons (push `SignInScreen` / `SignUpScreen`), empty-state hero ("Student Assistant" / "New Chat"), UI-only input bar (image/code icons + send button; no real messaging or AI yet). The hamburger opens the `SidebarWelcomeDrawer` (early hero `AppLogo` was deliberately removed by commit "delete logo on hero center" — don't re-add).
- `lib/tool_menu_screen.dart` — tool menu page (`ToolMenuScreen`), per `design/tool-menu.png`: back button + avatar header, "Search tool" pill, "Unggulan" section (3 featured: CodeX/Makalah/Paraphrase with Indonesian descriptions + "Today • Xk User"), "Tools" section — 3-column grid of 9 tools (Makalah, Paraphrase, CodeX, Grammar, Math, Journal Search, Summarize, Citation, Translate). Icons are PNG assets from `assets/icons/` (registered in `pubspec.yaml`), loaded via `Image.asset`; the old CustomPaint painters were removed. CodeX (featured row + grid tile) opens `CodexChatScreen`; Math/Journal Search/Summarize/Citation/Translate open their `lib/chat_*.dart` screens via shared `_openTool`; Makalah/Paraphrase/Grammar are snackbar placeholders. Opened by the `More Tools+` item in both sidebars.
- `lib/chat_math.dart`, `chat_jurnal.dart`, `chat_summarize.dart`, `chat_citation.dart`, `chat_translate.dart` — per-tool screens opened from the tool menu grid (hamburger + title + avatar header, some with upload/result views).
- `lib/codex_chat_screen.dart` — CodeX chat (`CodexChatScreen`) per `design/codex-screen-1..4.png`: empty hero (`{ ✦ }` / "Lets Build" / "CodeX") + input bar; tapping send reveals the fixed demo conversation from the design (user bubble "Hey Flippy! ... Analog Clock.", bot intro, tokenized TypeScript code card with line numbers + horizontal scroll) character-by-character via `Timer.periodic(15ms)` with auto-scroll. The input TextField is visual-only: typed text is ignored/cleared, the user bubble is always the fixed prompt. One-shot per visit (`_isChatSubmitted`); send is grey before and black after submit (matching the mockups). Uses `SidebarDrawer`; avatar opens `ProfileScreen`.
- `lib/widgets/sidebar.dart` — full sidebar: `Sidebar` (content) + `SidebarDrawer` (wraps it in a 280px `Drawer`), so any page can use `Scaffold(drawer: const SidebarDrawer())`. No login-state params (auth state deliberately not modeled yet): always shows mock chat list (first item highlighted), avatar + hardcoded email + settings footer. All taps are snackbar placeholders; chat titles are mock data (`_sampleChats`).
- `lib/widgets/sidebar_welcome.dart` — welcome-state variant: `SidebarWelcome` + `SidebarWelcomeDrawer`, same header/search/`More Tools+`/`Chats` sections but empty list and no footer. This is what `ChatScreen` currently uses. Sub-widgets (`_SearchPill`, `_RowItem`, `_CircleButton`) are duplicated between the two sidebar files, not extracted.
- `lib/signup_screen.dart` — signup form (`SignUpScreen`): logo, Google/Facebook and app logo painted via `CustomPaint`, Indonesian validation, mixed EN/ID labels ("ATAU", "Masukkan Email"). Bottom outline button opens `SignInScreen`.
- `lib/signin_screen.dart` — sign-in form (`SignInScreen`), mirror of signup layout (Email + Password only, no repeat field). Bottom outline button opens `SignUpScreen`. Note: shared auth widgets (logo, brand icons, divider, back button, field styles) are intentionally duplicated per-screen, not extracted.
- `test/widget_test.dart` — tests: chat screen renders (hero, no mock messages), Register/Sign in open auth screens, hamburger opens sidebar (welcome), sidebar content (via `SidebarDrawer()` + `ScaffoldState.openDrawer()`), welcome drawer has no chat list, More Tools+ opens tool menu + back returns, CodeX opens (Unggulan + grid) and its typewriter reply completes after `pump(30s)`, form validation, cross-navigation. Note tests set `tester.view.physicalSize` tall (1200x2600) so the whole scrollable signup form is laid out.

## Conventions & gotchas

- App display name is set per-platform ("AI Student Assistant"): `android/app/src/main/AndroidManifest.xml`, `ios/Runner/Info.plist`, `windows/runner/Runner.rc` + `main.cpp`, `linux/runner/my_application.cc`, `web/index.html` + `web/manifest.json`. Keep them in sync when renaming.
- Bundle ID is `com.aistudentassistant.ai_student_assistant` (do not change casually).
- Dark UI color is `Color(0xFF1C1C1E)`; keep colors consistent across screens (constants per file, no theme tokens yet).
- `assets/icons/` holds tool-menu PNG icons (black glyphs, transparent bg), registered as a folder in `pubspec.yaml` — new icons are picked up automatically; image assets must stay registered or `Image.asset` throws in tests.
- The working directory path contains a space (`D:\code\dart\Student Assistant`) — quote paths in shell commands.
- Active branch is `development`; `git init` + first commits already done (`Init`, chat page). Only commit when asked.
