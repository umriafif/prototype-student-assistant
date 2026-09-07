import 'package:flutter/material.dart';

import 'signin_screen.dart';
import 'signup_screen.dart';
import 'widgets/app_sidebar.dart';

const Color _panel = Color(0xFFFFFFFF);
const Color _border = Color(0xFFE8E8EA);
const Color _dark = Color(0xFF1C1C1E);
const Color _mutedIcon = Color(0xFF3A3A3E);
const Color _placeholderGrey = Color(0xFFC2C2C6);

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _panel,
      drawer: const AppDrawer(),
      body: const Column(
        children: [
          _Header(),
          Divider(height: 1, thickness: 1, color: _border),
          Expanded(child: _HeroCenter()),
          _InputBar(),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _Hamburger(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _HeaderButton(
                label: 'Sign in',
                background: const Color(0xFFECECEE),
                foreground: _dark,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const SignInScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
              _HeaderButton(
                label: 'Register',
                background: _dark,
                foreground: Colors.white,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const SignUpScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Hamburger extends StatelessWidget {
  const _Hamburger();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Scaffold.of(context).openDrawer(),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 22,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < 3; i++) ...[
              Container(
                height: 2.2,
                decoration: BoxDecoration(
                  color: _dark,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              if (i < 2) const SizedBox(height: 5),
            ],
          ],
        ),
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  const _HeaderButton({
    required this.label,
    required this.background,
    required this.foreground,
    this.onTap,
  });

  final String label;
  final Color background;
  final Color foreground;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            color: foreground,
          ),
        ),
      ),
    );
  }
}

class _HeroCenter extends StatelessWidget {
  const _HeroCenter();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          // AppLogo(size: 80),
          SizedBox(height: 22),
          Text(
            'Student Assistant',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: _dark,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'New Chat',
            style: TextStyle(fontSize: 15, color: Color(0xFF8E8E93)),
          ),
        ],
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  const _InputBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: _border)),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(
          color: _panel,
          border: Border.all(color: _border),
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F14141E),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What would you like to know?',
              style: TextStyle(fontSize: 13.5, color: _placeholderGrey),
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                _ToolIcon(icon: Icons.image_outlined),
                SizedBox(width: 18),
                _ToolIcon(icon: Icons.code),
                Spacer(),
                _SendButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolIcon extends StatelessWidget {
  const _ToolIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: 18, color: _mutedIcon);
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: const BoxDecoration(
        color: Color(0xFFE6E6E9),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.arrow_upward, size: 17, color: _dark),
    );
  }
}
