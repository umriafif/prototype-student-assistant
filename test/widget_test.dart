import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_student_assistant/main.dart';
import 'package:ai_student_assistant/widgets/sidebar.dart';
import 'package:ai_student_assistant/widgets/sidebar_welcome.dart';

void main() {
  testWidgets('Chat screen renders', (WidgetTester tester) async {
    await tester.pumpWidget(const AIStudentAssistantApp());

    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
    expect(find.text('Student Assistant'), findsOneWidget);
    expect(find.text('New Chat'), findsOneWidget);
    expect(find.text('What would you like to know?'), findsOneWidget);
    expect(find.byIcon(Icons.mic_none), findsNothing);
    expect(find.textContaining('Hey Flippy!'), findsNothing);
  });

  testWidgets('Register opens signup screen', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 2600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AIStudentAssistantApp());
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();

    expect(find.text('Student Assistant'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Repeat Password'), findsOneWidget);
    expect(find.text('Masukkan Email'), findsOneWidget);
    expect(find.text('Masukkan Password'), findsNWidgets(2));
    expect(find.text('Continue with Google'), findsOneWidget);
    expect(find.text('Continue with Facebook'), findsOneWidget);
    expect(find.text('ATAU'), findsOneWidget);
  });

  testWidgets('Signup form validates input', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 2600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AIStudentAssistantApp());
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Masukkan Email'),
      'not-an-email',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Masukkan Password').first,
      '12345',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Masukkan Password').last,
      '54321',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Sign Up'));
    await tester.pumpAndSettle();

    expect(find.text('Format email tidak valid'), findsOneWidget);
    expect(find.text('Password minimal 6 karakter'), findsOneWidget);
    expect(find.text('Password tidak cocok'), findsOneWidget);
  });

  testWidgets('Sign in opens signin screen', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 2600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AIStudentAssistantApp());
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();

    expect(find.text('Student Assistant'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Repeat Password'), findsNothing);
    expect(find.text('Masukkan Email'), findsOneWidget);
    expect(find.text('Masukkan Password'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);
    expect(find.text('Continue with Facebook'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('ATAU'), findsOneWidget);
  });

  testWidgets('Signin form validates input', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 2600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AIStudentAssistantApp());
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Masukkan Email'),
      'not-an-email',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Sign In'));
    await tester.pumpAndSettle();

    expect(find.text('Format email tidak valid'), findsOneWidget);
    expect(find.text('Password wajib diisi'), findsOneWidget);
  });

  testWidgets('Cross navigation between auth screens', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 2600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AIStudentAssistantApp());

    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sign In').last);
    await tester.pumpAndSettle();
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Repeat Password'), findsNothing);

    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();
    expect(find.text('Repeat Password'), findsOneWidget);
  });

  testWidgets('Hamburger opens sidebar (welcome)', (WidgetTester tester) async {
    await tester.pumpWidget(const AIStudentAssistantApp());
    await tester.tap(find.byKey(const ValueKey('hamburger')));
    await tester.pumpAndSettle();

    expect(find.text('Search'), findsOneWidget);
    expect(find.text('More Tools+'), findsOneWidget);
    expect(find.text('Chats'), findsOneWidget);
    expect(find.text('flippy@figma.com'), findsNothing);
    expect(find.text('Analog Clock React app'), findsNothing);
  });

  testWidgets('Sidebar shows chat list and footer', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 2600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(drawer: const SidebarDrawer(), body: const SizedBox()),
      ),
    );
    tester.state<ScaffoldState>(find.byType(Scaffold)).openDrawer();
    await tester.pumpAndSettle();

    expect(find.text('Analog Clock React app'), findsOneWidget);
    expect(find.text('Simple Design System'), findsOneWidget);
    expect(find.text('Figma variable planning'), findsOneWidget);
    expect(find.text('OKCLH token algorithm'), findsOneWidget);
    expect(find.text('Component naming advice'), findsOneWidget);
    expect(find.text('flippy@figma.com'), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);
  });

  testWidgets('Welcome drawer has no chat list', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          drawer: const SidebarWelcomeDrawer(),
          body: const SizedBox(),
        ),
      ),
    );
    tester.state<ScaffoldState>(find.byType(Scaffold)).openDrawer();
    await tester.pumpAndSettle();

    expect(find.text('Analog Clock React app'), findsNothing);
    expect(find.text('flippy@figma.com'), findsNothing);
  });

  testWidgets('More Tools+ opens tool menu', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 2600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AIStudentAssistantApp());
    await tester.tap(find.byKey(const ValueKey('hamburger')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('More Tools+'));
    await tester.pumpAndSettle();

    expect(find.text('Search tool'), findsOneWidget);
    expect(find.text('Unggulan'), findsOneWidget);
    expect(find.text('Tools'), findsOneWidget);
    expect(find.text('Tool untuk membantu tugas coding anda'), findsOneWidget);
    expect(
      find.text('Buat makalah dengan mudah dengan bantuan AI'),
      findsOneWidget,
    );
    expect(
      find.text('Paraphrase teks anda hanya dengan sekali klik'),
      findsOneWidget,
    );
    expect(find.text('Today • 10k User'), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(12));
    expect(find.text('Makalah'), findsNWidgets(2));
    expect(find.text('Paraphrase'), findsNWidgets(2));
    expect(find.text('CodeX'), findsNWidgets(2));
    expect(find.text('Grammar'), findsOneWidget);
    expect(find.text('Math'), findsOneWidget);
    expect(find.text('Journal Search'), findsOneWidget);
    expect(find.text('Summarize'), findsOneWidget);
    expect(find.text('Citation'), findsOneWidget);
    expect(find.text('Translate'), findsOneWidget);
  });

  testWidgets('Tool menu back button returns to chat', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 2600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AIStudentAssistantApp());
    await tester.tap(find.byKey(const ValueKey('hamburger')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('More Tools+'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();

    expect(find.text('New Chat'), findsOneWidget);
  });

  testWidgets('Tool menu Math button opens chat_math', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 2600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AIStudentAssistantApp());
    await tester.tap(find.byKey(const ValueKey('hamburger')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('More Tools+'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Math'));
    await tester.pumpAndSettle();

    expect(find.text('Upload Files'), findsOneWidget);
    expect(find.text('Browse Files'), findsOneWidget);

    tester.state<NavigatorState>(find.byType(Navigator)).pop();
    await tester.pumpAndSettle();

    expect(find.text('Search tool'), findsOneWidget);
  });

  testWidgets('CodeX opens from Unggulan row', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 2600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AIStudentAssistantApp());
    await tester.tap(find.byKey(const ValueKey('hamburger')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('More Tools+'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('CodeX').first);
    await tester.pumpAndSettle();

    expect(find.text('Lets Build'), findsOneWidget);
    expect(find.text('What would you like to know?'), findsOneWidget);
  });

  testWidgets('CodeX chat types a response after send', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 2600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AIStudentAssistantApp());
    await tester.tap(find.byKey(const ValueKey('hamburger')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('More Tools+'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('CodeX').last);
    await tester.pumpAndSettle();

    expect(find.text('Lets Build'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'teks yang diabaikan');
    await tester.pump();
    await tester.tap(find.byIcon(Icons.arrow_upward));
    await tester.pump();

    expect(
      find.text('Hey Flippy! Write me a script for building an Analog Clock.'),
      findsOneWidget,
    );
    expect(find.text('teks yang diabaikan'), findsNothing);
    expect(find.text('Lets Build'), findsNothing);

    await tester.pump(const Duration(seconds: 30));
    await tester.pumpAndSettle();

    expect(find.textContaining('Typescript code block'), findsOneWidget);
    expect(find.textContaining('AnalogClock'), findsOneWidget);
    expect(find.textContaining('London'), findsWidgets);
  });

  testWidgets('Tool menu Makalah button opens chat_makalah', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 2600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AIStudentAssistantApp());
    await tester.tap(find.byKey(const ValueKey('hamburger')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('More Tools+'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Makalah').first);
    await tester.pumpAndSettle();

    expect(find.text('Asisten Makalah'), findsOneWidget);
    expect(find.text('Detail Makalah'), findsOneWidget);
    expect(
      find.text('Masukkan deskripsi makalah\nyang akan anda buat'),
      findsOneWidget,
    );
    expect(find.text('Judul'), findsOneWidget);
    expect(find.text('Masukkan Judul'), findsOneWidget);
    expect(find.text('Sub Bab'), findsOneWidget);
    expect(find.text('Rumusan Masalah'), findsOneWidget);
    expect(find.text('Keterangan'), findsOneWidget);
    expect(find.text('Jelaskan Makalah Anda Sedeatil Mungkin'), findsOneWidget);
    expect(find.text('0/1000 Karakter'), findsOneWidget);
    expect(find.text('Clear'), findsOneWidget);
    expect(find.text('Generate'), findsOneWidget);

    // Test typing and Clear button
    await tester.enterText(
      find.widgetWithText(TextField, 'Masukkan Judul'),
      'Kecerdasan Buatan',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Jelaskan Makalah Anda Sedeatil Mungkin'),
      'Deskripsi makalah AI',
    );
    await tester.pump();
    expect(find.text('20/1000 Karakter'), findsOneWidget);

    await tester.tap(find.text('Clear'));
    await tester.pump();
    expect(find.text('0/1000 Karakter'), findsOneWidget);
    expect(find.text('Masukkan Judul'), findsOneWidget);

    // Test Generate button (Gambar 2 transition)
    await tester.tap(find.text('Generate'));
    await tester.pump();

    // Clear is hidden after generate
    expect(find.text('Clear'), findsNothing);

    // Pump typewriter stream
    await tester.pump(const Duration(seconds: 30));
    await tester.pumpAndSettle();

    expect(find.textContaining('Lorem ipsum dolor sit amet'), findsWidgets);
    expect(find.textContaining('Suspendisse imperdiet sem'), findsWidgets);

    // Typing into form resets back to Gambar 1 state
    await tester.enterText(
      find.widgetWithText(TextField, 'Masukkan Judul'),
      'Judul Baru',
    );
    await tester.pump();
    expect(find.text('Clear'), findsOneWidget);
    expect(find.textContaining('Lorem ipsum dolor sit amet'), findsNothing);
  });
}
