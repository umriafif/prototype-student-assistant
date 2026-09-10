import 'package:flutter/material.dart';
import 'widgets/sidebar.dart';

const Color _panel = Color(0xFFFFFFFF);
const Color _border = Color(0xFFE8E8EA);
const Color _dark = Color(0xFF1C1C1E);
const Color _primaryBlue = Color(0xFF1A73E8);
const Color _resultBg = Color(0xFFF1F5F9);
const Color _iconGrey = Color(0xFF70757A);
const Color _placeholderGrey = Color(0xFF80868B);

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({super.key});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  final TextEditingController _inputController = TextEditingController();

  String _sourceLanguage = 'Indonesia';
  String _targetLanguage = 'Inggris';

  final List<String> _languages = [
    'Indonesia',
    'Inggris',
    'Jepang',
    'Mandarin',
    'Arab',
    'Jerman',
    'Prancis',
    'Spanyol',
  ];

  String _translatedText = '';

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final text = _inputController.text;
    setState(() {
      if (text.trim().isEmpty) {
        _translatedText = '';
      } else {
        // Simulasi terjemahan sederhana
        if (text.trim().toLowerCase() == 'saya akan lawan') {
          _translatedText = 'I will fight';
        } else {
          _translatedText = 'Translated: $text';
        }
      }
    });
  }

  void _swapLanguages() {
    setState(() {
      final temp = _sourceLanguage;
      _sourceLanguage = _targetLanguage;
      _targetLanguage = temp;
      _onTextChanged();
    });
  }

  void _clearText() {
    _inputController.clear();
  }

  @override
  void dispose() {
    _inputController.dispose();
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                  child: Column(
                    children: [
                      // Language Selector Bar
                      _LanguageSelectorBar(
                        sourceLanguage: _sourceLanguage,
                        targetLanguage: _targetLanguage,
                        languages: _languages,
                        onSourceChanged: (val) {
                          if (val != null) setState(() => _sourceLanguage = val);
                        },
                        onTargetChanged: (val) {
                          if (val != null) setState(() => _targetLanguage = val);
                        },
                        onSwap: _swapLanguages,
                      ),
                      const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),

                      // Source Input Area
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: _inputController,
                              maxLines: 4,
                              minLines: 2,
                              style: const TextStyle(
                                fontSize: 18,
                                color: _dark,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Masukkan teks',
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: _placeholderGrey,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                IconButton(
                                  constraints: const BoxConstraints(),
                                  padding: const EdgeInsets.only(right: 12),
                                  icon: const Icon(Icons.mic_none, color: _iconGrey, size: 22),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  constraints: const BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.volume_up_outlined, color: _iconGrey, size: 22),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Target Translation Area
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: _resultBg,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _translatedText,
                              style: const TextStyle(
                                fontSize: 18,
                                color: _primaryBlue,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: _translatedText.isNotEmpty ? 24 : 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  constraints: const BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.volume_up_outlined, color: _iconGrey, size: 20),
                                  onPressed: () {},
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      constraints: const BoxConstraints(),
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      icon: const Icon(Icons.copy_outlined, color: _iconGrey, size: 20),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      constraints: const BoxConstraints(),
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      icon: const Icon(Icons.cancel_outlined, color: _iconGrey, size: 20),
                                      onPressed: _clearText,
                                    ),
                                    IconButton(
                                      constraints: const BoxConstraints(),
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      icon: const Icon(Icons.edit_outlined, color: _iconGrey, size: 20),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      constraints: const BoxConstraints(),
                                      padding: const EdgeInsets.only(left: 8),
                                      icon: const Icon(Icons.ios_share, color: _iconGrey, size: 20),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
            'Translate',
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
            onPressed: () {},
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

// ==================== LANGUAGE SELECTOR BAR ====================
class _LanguageSelectorBar extends StatelessWidget {
  const _LanguageSelectorBar({
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.languages,
    required this.onSourceChanged,
    required this.onTargetChanged,
    required this.onSwap,
  });

  final String sourceLanguage;
  final String targetLanguage;
  final List<String> languages;
  final ValueChanged<String?> onSourceChanged;
  final ValueChanged<String?> onTargetChanged;
  final VoidCallback onSwap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Source Language Dropdown
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: sourceLanguage,
              icon: const Icon(Icons.arrow_drop_down, color: _primaryBlue),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: _primaryBlue,
              ),
              items: languages.map((String lang) {
                return DropdownMenuItem<String>(
                  value: lang,
                  child: Text(lang),
                );
              }).toList(),
              onChanged: onSourceChanged,
            ),
          ),

          // Swap Button
          IconButton(
            icon: const Icon(Icons.swap_horiz, color: _iconGrey, size: 22),
            onPressed: onSwap,
          ),

          // Target Language Dropdown
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: targetLanguage,
              icon: const Icon(Icons.arrow_drop_down, color: _primaryBlue),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: _primaryBlue,
              ),
              items: languages.map((String lang) {
                return DropdownMenuItem<String>(
                  value: lang,
                  child: Text(lang),
                );
              }).toList(),
              onChanged: onTargetChanged,
            ),
          ),
        ],
      ),
    );
  }
}