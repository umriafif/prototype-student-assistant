import 'dart:async';
import 'package:flutter/material.dart';

import '../profile.dart';
import '../widgets/sidebar.dart';

const Color _panel = Color(0xFFFFFFFF);
const Color _border = Color(0xFFE8E8EA);
const Color _dark = Color(0xFF1C1C1E);
const Color _placeholderGrey = Color(0xFF8E8E93);

class SummarizeScreen extends StatefulWidget {
  const SummarizeScreen({super.key});

  @override
  State<SummarizeScreen> createState() => _SummarizeScreenState();
}

class _SummarizeScreenState extends State<SummarizeScreen> {
  bool _isFileUploaded = false;
  bool _isSummarized = false;
  String _selectedLanguage = 'English';

  final TextEditingController _textController = TextEditingController(
    text:
        'Writing clearly and concisely is an essential skill in content creation, professional communication and',
  );
  int _wordCount = 0;

  // Teks ringkasan hasil
  final String _summaryResult =
      'Our online paraphrasing tool uses advanced AI technology to rephrase text accurately and quickly. With this tool, you can rewrite sentences and articles while keeping their original meaning unchanged.';

  String _displayedSummaryText = '';
  Timer? _typewriterTimer;

  @override
  void initState() {
    super.initState();
    _calculateWordCount();
    _textController.addListener(_calculateWordCount);
  }

  void _calculateWordCount() {
    final text = _textController.text.trim();
    setState(() {
      _wordCount = text.isEmpty ? 0 : text.split(RegExp(r'\s+')).length;
    });
  }

  void _handleUploadFile() {
    setState(() {
      _isFileUploaded = true;
    });
  }

  void _handleClear() {
    setState(() {
      _textController.clear();
      _isFileUploaded = false;
      _wordCount = 0;
    });
  }

  void _handleSummarize() {
    if (_textController.text.trim().isEmpty && !_isFileUploaded) return;

    setState(() {
      _isSummarized = true;
      _displayedSummaryText = '';
    });

    _typewriterTimer?.cancel();
    int currentIndex = 0;

    _typewriterTimer = Timer.periodic(const Duration(milliseconds: 15), (
      timer,
    ) {
      if (currentIndex < _summaryResult.length) {
        setState(() {
          _displayedSummaryText += _summaryResult[currentIndex];
          currentIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _handleTryAgain() {
    _typewriterTimer?.cancel();
    setState(() {
      _isSummarized = false;
      _displayedSummaryText = '';
    });
  }

  @override
  void dispose() {
    _typewriterTimer?.cancel();
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
                child: _isSummarized
                    ? _SummarizeResultView(
                        summaryText: _displayedSummaryText,
                        onTryAgain: _handleTryAgain,
                      )
                    : _SummarizeDefaultView(
                        controller: _textController,
                        wordCount: _wordCount,
                        selectedLanguage: _selectedLanguage,
                        onLanguageChanged: (val) {
                          if (val != null) {
                            setState(() => _selectedLanguage = val);
                          }
                        },
                        onUploadTap: _handleUploadFile,
                        onClear: _handleClear,
                        onSummarize: _handleSummarize,
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
            'Summarize',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color(0xFF666666),
            ),
          ),
          const _AvatarButton(),
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
        width: 32,
        height: 32,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Icon(Icons.account_circle, size: 32, color: _dark),
        ),
      ),
    );
  }
}

// ==================== DEFAULT VIEW ====================
class _SummarizeDefaultView extends StatelessWidget {
  const _SummarizeDefaultView({
    required this.controller,
    required this.wordCount,
    required this.selectedLanguage,
    required this.onLanguageChanged,
    required this.onUploadTap,
    required this.onClear,
    required this.onSummarize,
  });

  final TextEditingController controller;
  final int wordCount;
  final String selectedLanguage;
  final ValueChanged<String?> onLanguageChanged;
  final VoidCallback onUploadTap;
  final VoidCallback onClear;
  final VoidCallback onSummarize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Judul & Subjudul
        const Text(
          'AI Summarizer',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: _dark,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Masukkan Teks Yang Akan\nDiringkas',
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF666666),
            height: 1.3,
          ),
        ),
        const SizedBox(height: 20),

        // Text Input Box dengan Tombol di Bawahnya
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
                  fontSize: 14,
                  color: Color(0xFF1E2022),
                  height: 1.4,
                  fontWeight: FontWeight.w500,
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
                      child: Row(
                        children: const [
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

        // Actions: Clear & Summarize Button
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
              onPressed: onSummarize,
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
                'Summarize',
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
class _SummarizeResultView extends StatelessWidget {
  const _SummarizeResultView({
    required this.summaryText,
    required this.onTryAgain,
  });

  final String summaryText;
  final VoidCallback onTryAgain;

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

        // Result Card dengan garis indikator tebal hitam di sisi kanan
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
                  // Badge / Highlight "Summarizing Tool"
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3DC),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Summarizing Tool',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _dark,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF2C3E50),
                        height: 1.45,
                      ),
                      children: [
                        const TextSpan(text: 'Our '),
                        const TextSpan(
                          text: 'online paraphrasing tool ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: 'uses '),
                        const TextSpan(
                          text: 'advanced AI technology ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: 'to '),
                        const TextSpan(
                          text: 'rephrase text accurately and quickly',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: '. With this '),
                        const TextSpan(
                          text: 'tool',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: ', you can '),
                        const TextSpan(
                          text: 'rewrite sentences ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: 'and '),
                        const TextSpan(
                          text: 'articles ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              'while keeping their original meaning unchanged.',
                        ),
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

        // Action Buttons
        Row(
          children: [
            OutlinedButton(
              onPressed: onTryAgain,
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFEFEFF4),
                foregroundColor: _dark,
                side: BorderSide.none,
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
              onPressed: () {},
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
              icon: const Icon(Icons.filter_none_outlined, size: 16),
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