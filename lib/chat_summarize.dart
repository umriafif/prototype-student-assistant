import 'dart:async';
import 'package:flutter/material.dart';
import 'widgets/sidebar.dart';

const Color _panel = Color(0xFFFFFFFF);
const Color _border = Color(0xFFE8E8EA);
const Color _dark = Color(0xFF1C1C1E);
const Color _placeholderGrey = Color(0xFF9E9E9E);
const Color _dividerBg = Color(0xFFEFEFF4);

class SummarizeScreen extends StatefulWidget {
  const SummarizeScreen({super.key});

  @override
  State<SummarizeScreen> createState() => _SummarizeScreenState();
}

class _SummarizeScreenState extends State<SummarizeScreen> {
  bool _isFileUploaded = false;
  bool _isSummarized = false;
  
  final TextEditingController _textController = TextEditingController();
  int _characterCount = 0;

  // Teks ringkasan hasil
  final String _summaryResult =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent id efficitur nunc, blandit laoreet tortor. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aliquam vel elit posuere, aliquet dolor nec, luctus eros. Quisque a luctus enim. Donec gravida quam nisl, id fermentum ipsum blandit a. Nam sed nisl sit amet quam gravida imperdiet. Suspendisse imperdiet sem nulla, sed blandit sem interdum in.';

  String _displayedSummaryText = '';
  Timer? _typewriterTimer;

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _characterCount = _textController.text.length;
      });
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
      _characterCount = 0;
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

    _typewriterTimer = Timer.periodic(const Duration(milliseconds: 15), (timer) {
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
      _handleClear();
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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: _isSummarized
                    ? _SummarizeResultView(
                        summaryText: _displayedSummaryText,
                        onTryAgain: _handleTryAgain,
                      )
                    : _SummarizeDefaultView(
                        controller: _textController,
                        characterCount: _characterCount,
                        isFileUploaded: _isFileUploaded,
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

// ==================== DEFAULT VIEW (Summarize-default) ====================
class _SummarizeDefaultView extends StatelessWidget {
  const _SummarizeDefaultView({
    required this.controller,
    required this.characterCount,
    required this.isFileUploaded,
    required this.onUploadTap,
    required this.onClear,
    required this.onSummarize,
  });

  final TextEditingController controller;
  final int characterCount;
  final bool isFileUploaded;
  final VoidCallback onUploadTap;
  final VoidCallback onClear;
  final VoidCallback onSummarize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Upload Card
        GestureDetector(
          onTap: onUploadTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFDCDCE0),
                width: 1.2,
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF0F0F5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.cloud_upload_outlined,
                    color: _dark,
                    size: 22,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  isFileUploaded ? 'file_document.pdf' : 'Upload Files',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: _dark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isFileUploaded
                      ? 'File uploaded • Ready to summarize'
                      : 'Drag and drop or click to browse',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: isFileUploaded ? Colors.green : const Color(0xFF8E8E93),
                  ),
                ),
                if (!isFileUploaded) ...[
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF14142B),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Browse Files',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Supports PDF or DOCX up to 1MB',
                    style: TextStyle(fontSize: 11, color: Color(0xFFA0A0A5)),
                  ),
                ],
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Divider ATAU
        Row(
          children: const [
            Expanded(child: Divider(color: _dividerBg, thickness: 2)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'ATAU',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF8E8E93),
                ),
              ),
            ),
            Expanded(child: Divider(color: _dividerBg, thickness: 2)),
          ],
        ),

        const SizedBox(height: 20),

        // Text Area Input
        Container(
          height: 180,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E5EA)),
          ),
          child: TextField(
            controller: controller,
            maxLength: 1000,
            maxLines: null,
            expands: true,
            style: const TextStyle(fontSize: 14, color: _dark),
            decoration: const InputDecoration(
              hintText: 'Enter or paste your text and press Summarize',
              hintStyle: TextStyle(fontSize: 13.5, color: _placeholderGrey),
              border: InputBorder.none,
              counterText: '',
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Counter Karakter
        Text(
          '$characterCount/1000 Karakter',
          style: const TextStyle(fontSize: 13, color: Color(0xFF666666)),
        ),

        const SizedBox(height: 16),

        // Action Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: onClear,
              child: const Text(
                'Clear',
                style: TextStyle(fontSize: 14, color: _dark),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              onPressed: onSummarize,
              style: ElevatedButton.styleFrom(
                backgroundColor: _dark,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              icon: const Icon(Icons.format_list_bulleted, size: 18),
              label: const Text(
                'Summarize',
                style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ==================== RESULT VIEW (Summarize-result) ====================
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
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: _dark,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 220),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E5EA)),
          ),
          child: Text(
            summaryText,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF8E8E93),
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            OutlinedButton(
              onPressed: onTryAgain,
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFEFEFF4),
                foregroundColor: _dark,
                side: BorderSide.none,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Try Again',
                style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: _dark,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              icon: const Icon(Icons.copy_outlined, size: 18),
              label: const Text(
                'Copy',
                style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    );
  }
}