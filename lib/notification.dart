import 'package:flutter/material.dart';

const Color _background = Color(0xFFF5F5F5);
const Color _panel = Color(0xFFFFFFFF);
const Color _border = Color(0xFFE7E7EC);
const Color _dark = Color(0xFF1C1C1E);
const Color _textPrimary = Color(0xFF1D1B20);
const Color _textSecondary = Color(0xCC1D1B20);

const List<_NotificationItemData> _notificationItems = [
  _NotificationItemData('CodeX', 'aktif'),
  _NotificationItemData('Makalah', 'aktif'),
  _NotificationItemData('Paraphrase', 'aktif'),
  _NotificationItemData('Grammar', 'aktif'),
  _NotificationItemData('Math', 'aktif'),
  _NotificationItemData('Journal', 'aktif'),
  _NotificationItemData('Summarize', 'aktif'),
  _NotificationItemData('Cite', 'aktif'),
  _NotificationItemData('Translate', 'aktif'),
];

void main() {
  runApp(const NotificationApp());
}

class NotificationApp extends StatelessWidget {
  const NotificationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notifikasi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: _background,
        colorScheme: ColorScheme.fromSeed(seedColor: _dark),
      ),
      home: const NotificationScreen(),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: Center(
          child: Container(
            width: 412,
            height:
                mediaQuery.size.height -
                mediaQuery.padding.top -
                mediaQuery.padding.bottom,
            decoration: const BoxDecoration(color: _panel),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _TopBar(),
                  const SizedBox(height: 20),
                  const _NotificationList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).maybePop(),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _panel,
              border: Border.all(color: _border),
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: _dark,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'Notifikasi',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _NotificationList extends StatelessWidget {
  const _NotificationList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int index = 0; index < _notificationItems.length; index++)
          Padding(
            padding: EdgeInsets.only(
              bottom: index == _notificationItems.length - 1 ? 0 : 12,
            ),
            child: _NotificationCard(
              title: _notificationItems[index].title,
              status: _notificationItems[index].status,
            ),
          ),
      ],
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.title, required this.status});

  final String title;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: _panel,
        border: Border.all(color: _border),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: _textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            status,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: _textSecondary,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationItemData {
  const _NotificationItemData(this.title, this.status);

  final String title;
  final String status;
}
