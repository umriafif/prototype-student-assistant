import 'package:flutter/material.dart';

const Color _background = Color(0xFFF5F5F5);
const Color _panel = Color(0xFFFFFFFF);
const Color _border = Color(0xFFE7E7EC);
const Color _dark = Color(0xFF1C1C1E);
const Color _textPrimary = Color(0xFF1D1B20);
const Color _textSecondary = Color(0xCC1D1B20);

void main() {
  runApp(const PersonalizationApp());
}

class PersonalizationApp extends StatelessWidget {
  const PersonalizationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personalisasi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: _background,
        colorScheme: ColorScheme.fromSeed(seedColor: _dark),
      ),
      home: const PersonalizationScreen(),
    );
  }
}

class PersonalizationScreen extends StatelessWidget {
  const PersonalizationScreen({super.key});

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
                  _TopBar(),
                  const SizedBox(height: 20),
                  const Text(
                    'Gaya dan nada dasar',
                    style: TextStyle(
                      color: _textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _InfoCard(title: 'Gaya dan nada dasar', subtitle: 'Default'),
                  const SizedBox(height: 20),
                  const Text(
                    'Karakteristik',
                    style: TextStyle(
                      color: _textPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _InfoCard(
                    title: 'Tambah Karakteristik',
                    subtitle: null,
                    trailing: null,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Intruksi Khusus',
                    style: TextStyle(
                      color: _textPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _InfoCard(
                    title:
                        'Bagikan hal lain yang perlu dipertimbangkan AI dalam responsnya.',
                    subtitle: null,
                    trailing: null,
                    isMultiline: true,
                  ),
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
            'Personalisasi',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
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
          child: const Center(child: Icon(Icons.check, size: 18, color: _dark)),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    this.subtitle,
    this.trailing,
    this.isMultiline = false,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final bool isMultiline;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: isMultiline
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (subtitle != null) ...[
                  Text(
                    title,
                    style: const TextStyle(
                      color: _textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      color: _textSecondary,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ] else
                  Text(
                    title,
                    style: const TextStyle(
                      color: _textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
          if (trailing != null) ...[const SizedBox(width: 12), trailing!],
        ],
      ),
    );
  }
}
