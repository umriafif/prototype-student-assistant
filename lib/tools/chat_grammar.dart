import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../profile.dart';
import '../widgets/sidebar.dart';

const Color _panel = Color(0xFFFFFFFF);
const Color _border = Color(0xFFE8E8EA);
const Color _dark = Color(0xFF1C1C1E);
const Color _placeholderGrey = Color(0xFF8E8E93);
const Color _cardBorder = Color(0xFFE5E5EA);
const Color _resultPurple = Color(0xFF7C4DFF);
const Color _doneBlue = Color(0xFF1976D2);

class GrammarScreen extends StatefulWidget {
  const GrammarScreen({super.key});

  @override
  State<GrammarScreen> createState() => _GrammarScreenState();
}

class _GrammarScreenState extends State<GrammarScreen> {
  static const String _defaultText =
      "Their sales revenue has increased significantly. It's not what I anticipated.";

  late final TextEditingController _textController;
  final FocusNode _focusNode = FocusNode();

  String _selectedLanguage = 'English';
  bool _isChecked = false;
  int _wordCount = 0;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: _defaultText);
    _calculateCounts();
    _textController.addListener(_calculateCounts);
  }

  void _calculateCounts() {
    final text = _textController.text.trim();
    setState(() {
      _wordCount = text.isEmpty ? 0 : text.split(RegExp(r'\s+')).length;
    });
  }

  void _handleClearText() {
    setState(() {
      _textController.clear();
      _isChecked = false;
    });
  }

  void _handleCheck() {
    if (_textController.text.trim().isEmpty) return;
    setState(() {
      _isChecked = true;
    });
  }

  void _handleBack() {
    setState(() {
      _isChecked = false;
    });
  }

  void _handleEdit() {
    setState(() {
      _isChecked = false;
    });
    _focusNode.requestFocus();
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Teks disalin ke clipboard')),
      );
  }

  @override
  void dispose() {
    _textController.dispose();
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'AI Grammar Checker',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: _dark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Masukkan Teks Yang Akan\nDicek',
                      style: TextStyle(
                        fontSize: 14.5,
                        color: Color(0xFF666666),
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Main Container Card
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _cardBorder, width: 1.2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top Toolbar
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.outlined_flag,
                                  size: 18,
                                  color: Color(0xFF555555),
                                ),
                                const SizedBox(width: 6),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _selectedLanguage,
                                    isDense: true,
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 18,
                                      color: Color(0xFF555555),
                                    ),
                                    style: const TextStyle(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w600,
                                      color: _dark,
                                    ),
                                    onChanged: (val) {
                                      if (val != null) {
                                        setState(() => _selectedLanguage = val);
                                      }
                                    },
                                    items:
                                        <String>[
                                          'English',
                                          'Indonesia',
                                        ].map<DropdownMenuItem<String>>((
                                          String value,
                                        ) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 1,
                                  height: 14,
                                  color: const Color(0xFFDCDCE0),
                                ),
                                const Spacer(),
                                _SmallBoxButton(
                                  icon: Icons.copy_rounded,
                                  onTap: () {
                                    if (_textController.text.isNotEmpty) {
                                      _copyToClipboard(_textController.text);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: _cardBorder,
                          ),

                          // Text Input Area
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 14, 12),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 28),
                                  child: TextField(
                                    controller: _textController,
                                    focusNode: _focusNode,
                                    maxLines: null,
                                    minLines: 3,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: _dark,
                                      height: 1.45,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    decoration: const InputDecoration(
                                      hintText: 'Enter text to check...',
                                      hintStyle: TextStyle(
                                        fontSize: 14.5,
                                        color: _placeholderGrey,
                                      ),
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ),
                                ),
                                if (_textController.text.isNotEmpty)
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: GestureDetector(
                                      onTap: _handleClearText,
                                      behavior: HitTestBehavior.opaque,
                                      child: const Padding(
                                        padding: EdgeInsets.all(4),
                                        child: Icon(
                                          Icons.close_rounded,
                                          size: 18,
                                          color: Color(0xFF8E8E93),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Character and Word Counter
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              '${_textController.text.length} characters , $_wordCount words',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF8E8E93),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Bottom of Card: Check Button OR Result List
                          if (!_isChecked)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: _handleCheck,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2B2B2B),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 13,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 0,
                                  ),
                                  icon: const Icon(
                                    Icons.check_circle_outline_rounded,
                                    size: 20,
                                  ),
                                  label: const Text(
                                    'Check',
                                    style: TextStyle(
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          else ...[
                            // Back | Edit Row
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: _handleBack,
                                    behavior: HitTestBehavior.opaque,
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_back,
                                          size: 16,
                                          color: Color(0xFF4A4A4A),
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          'Back',
                                          style: TextStyle(
                                            fontSize: 13.5,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF4A4A4A),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Container(
                                    width: 1,
                                    height: 14,
                                    color: const Color(0xFFDCDCE0),
                                  ),
                                  const SizedBox(width: 14),
                                  GestureDetector(
                                    onTap: _handleEdit,
                                    behavior: HitTestBehavior.opaque,
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.edit_outlined,
                                          size: 16,
                                          color: Color(0xFF4A4A4A),
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          'Edit',
                                          style: TextStyle(
                                            fontSize: 13.5,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF4A4A4A),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 1,
                              thickness: 1,
                              color: _cardBorder,
                            ),

                            // Result Header: Result & Done
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Result',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: _resultPurple,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: _handleBack,
                                    behavior: HitTestBehavior.opaque,
                                    child: const Text(
                                      'Done',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: _doneBlue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 1,
                              thickness: 1,
                              color: _cardBorder,
                            ),

                            // Suggestion 1
                            _SuggestionItem(
                              leadingText: 'The revenue growth was ',
                              highlightedText: 'substantial',
                              trailingText:
                                  ', but it didn\'t match my expectations.',
                              onCopy:
                                  () => _copyToClipboard(
                                    'The revenue growth was substantial, but it didn\'t match my expectations.',
                                  ),
                            ),
                            const Divider(
                              height: 1,
                              thickness: 1,
                              color: _cardBorder,
                            ),

                            // Suggestion 2
                            _SuggestionItem(
                              leadingText:
                                  'Their sales earnings have increased ',
                              highlightedText: 'dramatically',
                              trailingText: ', which was quite unexpected.',
                              onCopy:
                                  () => _copyToClipboard(
                                    'Their sales earnings have increased dramatically, which was quite unexpected.',
                                  ),
                            ),
                            const Divider(
                              height: 1,
                              thickness: 1,
                              color: _cardBorder,
                            ),

                            // Suggestion 3
                            _SuggestionItem(
                              leadingText: 'I did not foresee such a ',
                              highlightedText: 'significant rise',
                              trailingText: ' in their sales revenues.',
                              onCopy:
                                  () => _copyToClipboard(
                                    'I did not foresee such a significant rise in their sales revenues.',
                                  ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== SUGGESTION ITEM ====================
class _SuggestionItem extends StatelessWidget {
  const _SuggestionItem({
    required this.leadingText,
    required this.highlightedText,
    required this.trailingText,
    required this.onCopy,
  });

  final String leadingText;
  final String highlightedText;
  final String trailingText;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 14,
                  color: _dark,
                  height: 1.45,
                ),
                children: [
                  TextSpan(text: leadingText),
                  TextSpan(
                    text: highlightedText,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: trailingText),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          _SmallBoxButton(icon: Icons.copy_rounded, onTap: onCopy),
        ],
      ),
    );
  }
}

// ==================== SMALL BOX BUTTON ====================
class _SmallBoxButton extends StatelessWidget {
  const _SmallBoxButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFDCDCE0), width: 1.1),
        ),
        child: Icon(icon, size: 17, color: const Color(0xFF555555)),
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
            'Grammar',
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
