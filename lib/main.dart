import 'package:flutter/material.dart';

import 'chat_screen.dart';

void main() {
  runApp(const AIStudentAssistantApp());
}

class AIStudentAssistantApp extends StatelessWidget {
  const AIStudentAssistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Student Assistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ChatScreen(),
    );
  }
}
