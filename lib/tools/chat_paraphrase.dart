import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../profile.dart';
import '../widgets/sidebar.dart';

const Color _panel = Color(0xFFFFFFFF);
const Color _border = Color(0xFFE8E8EA);
const Color _dark = Color(0xFF1C1C1E);
const Color _placeholderGrey = Color(0xFF8E8E93);
const Color _blueAccent = Color(0xFF007AFF);

class ParaphraseScreen extends StatefulWidget {
  const ParaphraseScreen({super.key});

  @override
  State<ParaphraseScreen> createState() => _ParaphraseScreenState();
}

class _ParaphraseScreenState extends State<ParaphraseScreen> {
  static const String _defaultInput =
      'Writing clearly and concisely is an essential skill in content creation, professional communication and';

  bool _isFileUploaded = false;
  bool _isParaphrased = false;
  String _selectedLanguage = 'English';

  late final TextEditingController _textController;
  int _wordCount = 0;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: _defaultInput);
    _calculateWordCount();
    _textController.addListener(_calculateWordCount);
  }

  void _calculateWordCount() {
    final text = _textController.text.trim();
    setState(() {
      _wordCount = text.isEmpty ? 0 : text.split(RegExp(r'\s+')).length;
    });
  }

  int get _displayedWordCount {
    if (_textController.text == _defaultInput) {
      return 86;
    }
    return _wordCount;
  }

  void _handleUploadFile() {
    setState(() {
      _isFileUploaded = true;
    });
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('File berhasil diunggah (demo)')),
      );
  }

  void _handleClear() {
    setState(() {
      _textController.clear();
      _isFileUploaded = false;
      _wordCount = 0;
    });
  }

  void _handleParaphrase() {
    if (_textController.text.trim().isEmpty && !_isFileUploaded) return;

    setState(() {
      _isParaphrased = true;
    });
  }

  void _handleTryAgain() {
    setState(() {
      _isParaphrased = false;
    });
  }

  void _handleCopy() {
    const textToCopy =
        'Our online paraphrasing tool uses advanced AI technology to rephrase text accurately and quickly. With this tool, you can rewrite sentences and articles while keeping their original meaning unchanged.';
    Clipboard.setData(const ClipboardData(text: textToCopy));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Teks berhasil disalin ke clipboard')),
      );
  }

  @override
  void dispose() {
    _textController.dispose();
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
                  vertical: 18,
                ),
                child:
                    _isParaphrased
                        ? _ParaphraseResultView(
                          onTryAgain: _handleTryAgain,
                          onCopy: _handleCopy,
                        )
                        : _ParaphraseDefaultView(
                          controller: _textController,
                          wordCount: _displayedWordCount,
                          selectedLanguage: _selectedLanguage,
                          onLanguageChanged: (val) {
                            if (val != null) {
                              setState(() => _selectedLanguage = val);
                            }
                          },
                          onUploadTap: _handleUploadFile,
                          onClear: _handleClear,
                          onParaphrase: _handleParaphrase,
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
            'Paraphrase',
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

// ==================== DEFAULT VIEW ====================
class _ParaphraseDefaultView extends StatelessWidget {
  const _ParaphraseDefaultView({
    required this.controller,
    required this.wordCount,
    required this.selectedLanguage,
    required this.onLanguageChanged,
    required this.onUploadTap,
    required this.onClear,
    required this.onParaphrase,
  });

  final TextEditingController controller;
  final int wordCount;
  final String selectedLanguage;
  final ValueChanged<String?> onLanguageChanged;
  final VoidCallback onUploadTap;
  final VoidCallback onClear;
  final VoidCallback onParaphrase;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Judul & Subjudul
        const Text(
          'AI Paraphraser',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: _dark,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Masukkan Teks Yang Akan\nDiparaphrase',
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF666666),
            height: 1.35,
          ),
        ),
        const SizedBox(height: 20),

        // Text Input Box dengan Tombol Upload & Bahasa di dalamnya
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E5EA), width: 1.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller,
                maxLines: 5,
                minLines: 3,
                style: const TextStyle(
                  fontSize: 14.5,
                  color: Color(0xFF1E2022),
                  height: 1.45,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  hintText: 'Enter or paste your text...',
                  hintStyle: TextStyle(fontSize: 14, color: _placeholderGrey),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tombol Unggah File
                  InkWell(
                    onTap: onUploadTap,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF1F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.upload_outlined,
                            size: 16,
                            color: Color(0xFF2C3E50),
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Unggah File',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2C3E50),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Dropdown Bahasa
                  Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF1F5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedLanguage,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          size: 18,
                          color: Color(0xFF2C3E50),
                        ),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF2C3E50),
                        ),
                        onChanged: onLanguageChanged,
                        items:
                            <String>[
                              'English',
                              'Indonesia',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Counter Kata
        Text(
          '$wordCount/400 Kata-kata',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: _dark,
          ),
        ),

        const SizedBox(height: 20),

        // Actions: Clear & Paraphrase Button
        Row(
          children: [
            InkWell(
              onTap: onClear,
              borderRadius: BorderRadius.circular(8),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  'Clear',
                  style: TextStyle(
                    fontSize: 14,
                    color: _dark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: onParaphrase,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2B2B2B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              icon: const Icon(Icons.bolt, size: 18),
              label: const Text(
                'Paraphrase',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ==================== RESULT VIEW ====================
class _ParaphraseResultView extends StatelessWidget {
  const _ParaphraseResultView({
    required this.onTryAgain,
    required this.onCopy,
  });

  final VoidCallback onTryAgain;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hasil',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: _dark,
          ),
        ),
        const SizedBox(height: 16),

        // Result Card dengan garis aksen hitam di sisi kanan
        Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E5EA), width: 1.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge / Highlight "Paraphrasing Tool"
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3DC),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Paraphrasing Tool',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _dark,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 14.5,
                        color: _dark,
                        height: 1.45,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(text: 'Our '),
                        TextSpan(
                          text: 'online paraphrasing tool ',
                          style: TextStyle(color: _blueAccent),
                        ),
                        TextSpan(text: 'uses '),
                        TextSpan(
                          text: 'advanced AI technology ',
                          style: TextStyle(color: _blueAccent),
                        ),
                        TextSpan(text: 'to '),
                        TextSpan(
                          text: 'rephrase text accurately ',
                          style: TextStyle(color: _blueAccent),
                        ),
                        TextSpan(text: 'and '),
                        TextSpan(
                          text: 'quickly',
                          style: TextStyle(color: _blueAccent),
                        ),
                        TextSpan(text: '. With this '),
                        TextSpan(
                          text: 'tool',
                          style: TextStyle(color: _blueAccent),
                        ),
                        TextSpan(text: ', you can '),
                        TextSpan(
                          text: 'rewrite sentences ',
                          style: TextStyle(color: _blueAccent),
                        ),
                        TextSpan(text: 'and '),
                        TextSpan(
                          text: 'articles ',
                          style: TextStyle(color: _blueAccent),
                        ),
                        TextSpan(text: 'while keeping '),
                        TextSpan(
                          text: 'their original meaning unchanged',
                          style: TextStyle(color: _blueAccent),
                        ),
                        TextSpan(text: '.'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Accent bar tebal di kanan
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 4,
                decoration: const BoxDecoration(
                  color: _dark,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        // Action Buttons: Try Again & Copy
        Row(
          children: [
            OutlinedButton(
              onPressed: onTryAgain,
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFEFEFF4),
                foregroundColor: _dark,
                side: const BorderSide(color: Color(0xFFC7C7CC), width: 1),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Try Again',
                style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: onCopy,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2B2B2B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              icon: const Icon(Icons.copy_rounded, size: 16),
              label: const Text(
                'Copy',
                style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
