import 'package:flutter/material.dart';

import '../tool_menu_screen.dart';

const _dark = Color(0xFF1C1C1E);
const _border = Color(0xFFE8E8EA);
const _greys = Color(0xFF8E8E93);
const _greylight = Color(0xFFC2C2C6);

/// Sidebar for the welcome state of the app (no session chat yet).
class SidebarWelcome extends StatelessWidget {
  const SidebarWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 16),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    'Student Assistant',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w700,
                      color: _dark,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _CircleButton(
                  icon: Icons.add,
                  size: 22,
                  onTap: () => _placeholder(context, 'Fitur belum tersedia'),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _SearchPill(
              onTap: () => _placeholder(context, 'Fitur belum tersedia'),
            ),
            const SizedBox(height: 18),
            _RowItem(
              icon: Icons.grid_view_rounded,
              label: 'More Tools+',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (_) => const ToolMenuScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Chats',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _greys,
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}

void _placeholder(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

class SidebarWelcomeDrawer extends StatelessWidget {
  const SidebarWelcomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 280,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
      ),
      child: const SidebarWelcome(),
    );
  }
}

class _SearchPill extends StatelessWidget {
  const _SearchPill({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: _border),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: const [
            Expanded(
              child: Text(
                'Search',
                style: TextStyle(fontSize: 14, color: _greylight),
              ),
            ),
            Icon(Icons.search, size: 19, color: _greys),
          ],
        ),
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  const _RowItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Icon(icon, size: 19, color: _dark),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: _dark,
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.icon,
    required this.onTap,
    this.size = 20,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size + 10,
      height: size + 10,
      child: Material(
        color: Colors.white,
        shape: CircleBorder(side: const BorderSide(color: _greys)),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Icon(icon, size: size * 0.8, color: _dark),
        ),
      ),
    );
  }
}
