import 'package:flutter/material.dart';

const _dark = Color(0xFF1C1C1E);
const _border = Color(0xFFE8E8EA);
const _greys = Color(0xFF8E8E93);
const _greylight = Color(0xFFC2C2C6);
const _activeBg = Color(0xFFF0F0F2);

/// Sample chat titles; replace with real session data later.
const _sampleChats = [
  'Analog Clock React app',
  'Simple Design System',
  'Figma variable planning',
  'OKCLH token algorithm',
  'Component naming advice',
];

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
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
            onTap: () => _placeholder(context, 'Fitur belum tersedia'),
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
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                for (var i = 0; i < _sampleChats.length; i++)
                  _ChatItem(
                    title: _sampleChats[i],
                    active: i == 0,
                    onTap: () => _placeholder(context, 'Fitur belum tersedia'),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _FooterRow(
            onSettings: () =>
                _placeholder(context, 'Pengaturan belum tersedia'),
          ),
        ],
      ),
    );
  }
}

void _placeholder(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

class SidebarDrawer extends StatelessWidget {
  const SidebarDrawer({super.key});

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
      child: const Sidebar(),
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

class _ChatItem extends StatelessWidget {
  const _ChatItem({
    required this.title,
    required this.active,
    required this.onTap,
  });

  final String title;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          decoration: BoxDecoration(
            color: active ? _activeBg : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _dark,
            ),
          ),
        ),
      ),
    );
  }
}

class _FooterRow extends StatelessWidget {
  const _FooterRow({required this.onSettings});

  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 32,
          height: 32,
          child: CircleAvatar(
            backgroundColor: _activeBg,
            child: Icon(Icons.person, size: 18, color: _greys),
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            'flippy@figma.com',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13.5, color: _greys),
          ),
        ),
        const SizedBox(width: 8),
        _CircleButton(icon: Icons.settings, size: 20, onTap: onSettings),
      ],
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
