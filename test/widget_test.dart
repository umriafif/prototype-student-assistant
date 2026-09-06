import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_student_assistant/main.dart';
import 'package:ai_student_assistant/signup_screen.dart';

void main() {
  testWidgets('Chat screen renders', (WidgetTester tester) async {
    await tester.pumpWidget(const AIStudentAssistantApp());

    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
    expect(find.text('Student Assistant'), findsOneWidget);
    expect(find.text('New Chat'), findsOneWidget);
    expect(find.byType(AppLogo), findsOneWidget);
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
}
