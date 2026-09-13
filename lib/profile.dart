import 'package:flutter/material.dart';

import 'memory.dart';
import 'personalization.dart';

const Color _background = Color(0xFFF5F5F5);
const Color _panel = Color(0xFFFFFFFF);
const Color _border = Color(0xFFE7E7EC);
const Color _dark = Color(0xFF1C1C1E);
const Color _textPrimary = Color(0xFF1D1B20);
const Color _textSecondary = Color(0xCC1D1B20);

void main() {
  runApp(const ProfileApp());
}

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: _background,
        colorScheme: ColorScheme.fromSeed(seedColor: _dark),
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                  const _SectionTitle('StudentAsistent saya'),
                  const SizedBox(height: 12),
                  _ProfileTile(
                    title: 'Personalisasi',
                    icon: const Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      size: 18,
                      color: _dark,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const PersonalizationScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _ProfileTile(
                    title: 'Memori',
                    icon: const Icon(
                      Icons.import_contacts_outlined,
                      size: 18,
                      color: _dark,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const MemoryScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  _SectionTitle('Akun'),
                  SizedBox(height: 12),
                  _ProfileTile(
                    title: 'Upgrade paket',
                    icon: Icon(
                      Icons.auto_awesome_outlined,
                      size: 18,
                      color: _dark,
                    ),
                  ),
                  SizedBox(height: 12),
                  _ProfileTile(
                    title: 'Email',
                    value: 'user@gmail.com',
                    hasValue: true,
                    icon: Icon(Icons.email_outlined, size: 18, color: _dark),
                  ),
                  SizedBox(height: 20),
                  _SectionTitle('Umum'),
                  SizedBox(height: 12),
                  _ProfileTile(
                    title: 'Umum',
                    icon: Icon(Icons.settings_outlined, size: 18, color: _dark),
                  ),
                  SizedBox(height: 12),
                  _ProfileTile(
                    title: 'Notifikasi',
                    icon: Icon(
                      Icons.notifications_none_outlined,
                      size: 18,
                      color: _dark,
                    ),
                  ),
                  SizedBox(height: 12),
                  _ProfileTile(
                    title: 'Tentang',
                    icon: Icon(Icons.info_outline, size: 18, color: _dark),
                  ),
                  SizedBox(height: 8),
                  _ProfileTile(
                    title: 'Keluar',
                    icon: Icon(Icons.logout_outlined, size: 18, color: _dark),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
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
        const SizedBox(
          width: 64,
          child: Column(
            children: [
              _AvatarCircle(),
              SizedBox(height: 8),
              Text(
                'User',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const Opacity(opacity: 0, child: SizedBox(width: 48, height: 48)),
      ],
    );
  }
}

class _AvatarCircle extends StatelessWidget {
  const _AvatarCircle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: _panel,
        border: Border.all(color: _border),
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: const Center(
        child: Icon(Icons.person_outline, color: _dark, size: 28),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: _textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({
    required this.title,
    required this.icon,
    this.value,
    this.hasValue = false,
    this.onTap,
  });

  final String title;
  final Widget icon;
  final String? value;
  final bool hasValue;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      width: double.infinity,
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          _TileIcon(child: icon),
          const SizedBox(width: 12),
          Expanded(
            child: hasValue
                ? Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Email     ',
                          style: TextStyle(
                            color: _textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: value,
                          style: const TextStyle(
                            color: _textSecondary,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : Text(
                    title,
                    style: const TextStyle(
                      color: _textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ],
      ),
    );

    if (onTap == null) {
      return content;
    }

    return GestureDetector(onTap: onTap, child: content);
  }
}

class _TileIcon extends StatelessWidget {
  const _TileIcon({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(child: child),
    );
  }
}
