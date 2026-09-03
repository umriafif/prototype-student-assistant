import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_student_assistant/main.dart';

void main() {
  testWidgets('Chat screen renders', (WidgetTester tester) async {
    await tester.pumpWidget(const AIStudentAssistantApp());

    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
    expect(find.textContaining('Hey Flippy!'), findsOneWidget);
    expect(find.textContaining('Typescript code block'), findsOneWidget);
    expect(find.text('What would you like to know?'), findsOneWidget);
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
}
