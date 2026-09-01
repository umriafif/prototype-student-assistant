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
}
