import 'package:flutter/material.dart';

import 'chat_math.dart';
import 'codex_chat_screen.dart';
import 'profile.dart';
import 'chat_jurnal.dart';
import 'chat_summarize.dart';
import 'chat_citation.dart';
import 'chat_translate.dart';

const _dark = Color(0xFF1C1C1E);
const _greys = Color(0xFF8E8E93);
const _greylight = Color(0xFFC2C2C6);
const _greyBg = Color(0xFFF4F4F6);
const _circleBg = Color(0xFFEFEFF1);

const _featured = [
  _FeaturedTool(
    title: 'CodeX',
    description: 'Tool untuk membantu tugas coding anda',
    usage: 'Today • 10k User',
    icon: 'assets/icons/codex-icon.png',
  ),
  _FeaturedTool(
    title: 'Makalah',
    description: 'Buat makalah dengan mudah dengan bantuan AI',
    usage: 'Today • 5k User',
    icon: 'assets/icons/makalah-icon.png',
  ),
  _FeaturedTool(
    title: 'Paraphrase',
    description: 'Paraphrase teks anda hanya dengan sekali klik',
    usage: 'Today • 2k User',
    icon: 'assets/icons/paraphrase-icon.png',
  ),
];

const _tools = [
  _ToolItem(title: 'Makalah', icon: 'assets/icons/makalah-icon.png'),
  _ToolItem(title: 'Paraphrase', icon: 'assets/icons/paraphrase-icon.png'),
  _ToolItem(title: 'CodeX', icon: 'assets/icons/codex-icon.png'),
  _ToolItem(title: 'Grammar', icon: 'assets/icons/grammar-icon.png'),
  _ToolItem(title: 'Math', icon: 'assets/icons/math-icon.png'),
  _ToolItem(
    title: 'Journal Search',
    icon: 'assets/icons/journal-search-icon.png',
  ),
  _ToolItem(title: 'Summarize', icon: 'assets/icons/summarize-icon.png'),
  _ToolItem(title: 'Citation', icon: 'assets/icons/citation-icon.png'),
  _ToolItem(title: 'Translate', icon: 'assets/icons/translate-icon.png'),
];

class ToolMenuScreen extends StatelessWidget {
  const ToolMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 18, 10),
              child: Row(
                children: [
                  _BackButton(onTap: () => Navigator.of(context).maybePop()),
                  const Spacer(),
                  const _AvatarButton(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 2, 16, 10),
              child: _SearchPill(
                onTap: () => _placeholder(context, 'Fitur belum tersedia'),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                children: [
                  const _SectionLabel('Unggulan'),
                  const SizedBox(height: 10),
                  for (final tool in _featured)
                    _FeaturedTile(
                      tool: tool,
                      onTap: () => _openTool(context, tool.title),
                    ),
                  const SizedBox(height: 24),
                  const _SectionLabel('Tools'),
                  const SizedBox(height: 14),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.78,
                    children: [
                      for (final tool in _tools)
                        _ToolTile(
                          tool: tool,
                          onTap: () => _openTool(context, tool.title),
                        ),
                    ],
                  ),
                ],
              ),
            ),
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

void _openTool(BuildContext context, String title) {
  Widget? screen;
  if (title == 'CodeX') {
    screen = const CodexChatScreen();
  } else if (title == 'Math') {
    screen = const MathChatScreen();
  } else if (title == 'Journal Search') {
    screen = const JournalSearchScreen();
  } else if (title == 'Summarize') {
    screen = const SummarizeScreen();
  } else if (title == 'Citation') {
    screen = const CitationScreen();
  } else if (title == 'Translate') {
    screen = const TranslateScreen();
  }

  if (screen == null) {
    _placeholder(context, 'Fitur belum tersedia');
    return;
  }

  final Widget target = screen;
  Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => target));
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: _dark,
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _greyBg,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: const SizedBox(
          width: 40,
          height: 40,
          child: Icon(Icons.arrow_back_ios_new_rounded, size: 17, color: _dark),
        ),
      ),
    );
  }
}

class _AvatarButton extends StatelessWidget {
  const _AvatarButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute<void>(builder: (_) => const ProfileScreen()));
      },
      child: const SizedBox(
        width: 40,
        height: 40,
        child: CircleAvatar(
          backgroundColor: _greyBg,
          child: Icon(Icons.person, size: 22, color: _dark),
        ),
      ),
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
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: _greyBg,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: const [
            Icon(Icons.search, size: 19, color: _greys),
            SizedBox(width: 10),
            Text(
              'Search tool',
              style: TextStyle(fontSize: 14, color: _greylight),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturedTile extends StatelessWidget {
  const _FeaturedTile({required this.tool, required this.onTap});

  final _FeaturedTool tool;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 54,
              height: 54,
              child: Image.asset(tool.icon, fit: BoxFit.contain),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tool.title,
                    style: const TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w700,
                      color: _dark,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    tool.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.35,
                      color: _greys,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    tool.usage,
                    style: const TextStyle(fontSize: 12, color: _greylight),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolTile extends StatelessWidget {
  const _ToolTile({required this.tool, required this.onTap});

  final _ToolItem tool;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          SizedBox(
            width: 78,
            height: 78,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: _circleBg,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Image.asset(tool.icon, fit: BoxFit.contain),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            tool.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: _dark,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedTool {
  const _FeaturedTool({
    required this.title,
    required this.description,
    required this.usage,
    required this.icon,
  });

  final String title;
  final String description;
  final String usage;
  final String icon;
}

class _ToolItem {
  const _ToolItem({required this.title, required this.icon});

  final String title;
  final String icon;
}
