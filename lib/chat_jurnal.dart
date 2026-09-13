import 'package:flutter/material.dart';

import 'profile.dart';
import 'widgets/sidebar.dart';

const Color _panel = Color(0xFFFFFFFF);
const Color _border = Color(0xFFE8E8EA);
const Color _dark = Color(0xFF1C1C1E);
const Color _searchBg = Color(0xFFEEEBF5);
const Color _placeholderGrey = Color(0xFF8E8E93);
const Color _linkBlue = Color(0xFF8AC0FF);

class JournalSearchScreen extends StatefulWidget {
  const JournalSearchScreen({super.key});

  @override
  State<JournalSearchScreen> createState() => _JournalSearchScreenState();
}

class _JournalSearchScreenState extends State<JournalSearchScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _activateSearch() {
    setState(() {
      _isSearching = true;
    });
    _focusNode.requestFocus();
  }

  void _deactivateSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });
    _focusNode.unfocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _panel,
      drawer: const SidebarDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            const _Header(),
            const Divider(height: 1, thickness: 1, color: _border),
            Expanded(
              child: _isSearching
                  ? _JournalResultView(
                      controller: _searchController,
                      focusNode: _focusNode,
                      onBack: _deactivateSearch,
                      onClear: _deactivateSearch,
                    )
                  : _JournalDefaultView(onSearchTap: _activateSearch),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== HEADER ====================
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _Hamburger(),
          const Text(
            'Journal Search',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF666666),
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.account_circle, size: 28, color: _dark),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const ProfileScreen()),
              );
            },
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
      key: const ValueKey('hamburger'),
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

// ==================== DEFAULT VIEW (Journal-default) ====================
class _JournalDefaultView extends StatelessWidget {
  const _JournalDefaultView({required this.onSearchTap});

  final VoidCallback onSearchTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo Icon Figma Style
          const Icon(Icons.widgets_outlined, size: 56, color: _dark),
          const SizedBox(height: 16),
          const Text(
            'Journal Search\nAssistant',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: _dark,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'AI Student Assistant',
            style: TextStyle(fontSize: 13, color: _placeholderGrey),
          ),
          const SizedBox(height: 24),
          // Search Input Bar
          GestureDetector(
            onTap: onSearchTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: _searchBg,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, size: 20, color: _dark),
                  SizedBox(width: 10),
                  Text(
                    'Search Journal',
                    style: TextStyle(fontSize: 14, color: Color(0xFF555555)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== RESULT VIEW (Journal-result) ====================
class _JournalResultView extends StatelessWidget {
  const _JournalResultView({
    required this.controller,
    required this.focusNode,
    required this.onBack,
    required this.onClear,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onBack;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top Active Search Bar
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: _searchBg,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, size: 20, color: _dark),
                  onPressed: onBack,
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    style: const TextStyle(fontSize: 14, color: _dark),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20, color: _dark),
                  onPressed: onClear,
                ),
              ],
            ),
          ),
        ),

        // List Hasil Jurnal
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            itemCount: 8,
            itemBuilder: (context, index) {
              return const _JournalItem();
            },
          ),
        ),
      ],
    );
  }
}

// ==================== JOURNAL ITEM WIDGET ====================
class _JournalItem extends StatelessWidget {
  const _JournalItem();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Journal',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _dark,
            ),
          ),
          const SizedBox(height: 2),
          InkWell(
            onTap: () {},
            child: const Text(
              'Journal Title',
              style: TextStyle(
                fontSize: 15,
                color: _linkBlue,
                decoration: TextDecoration.underline,
                decorationColor: _linkBlue,
              ),
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Supporting line text, lorem ipsum dolor',
            style: TextStyle(fontSize: 13, color: Color(0xFF666666)),
          ),
        ],
      ),
    );
  }
}
