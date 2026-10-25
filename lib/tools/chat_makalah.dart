import 'dart:async';
import 'package:flutter/material.dart';

import '../profile.dart';
import '../widgets/sidebar.dart';

const Color _panel = Color(0xFFFFFFFF);
const Color _border = Color(0xFFE8E8EA);
const Color _dark = Color(0xFF1C1C1E);
const Color _placeholderGrey = Color(0xFFA0A0A5);
const Color _inputBorder = Color(0xFFE5E5EA);

class MakalahScreen extends StatefulWidget {
  const MakalahScreen({super.key});

  @override
  State<MakalahScreen> createState() => _MakalahScreenState();
}

class _MakalahScreenState extends State<MakalahScreen> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();

  final List<String> _subBabOptions = const [
    'Rumusan Masalah',
    'Latar Belakang',
    'Tujuan Penulisan',
    'Metode Penelitian',
    'Pembahasan',
    'Kesimpulan',
    'Saran',
  ];

  late String _selectedSubBab;
  bool _isGenerated = false;

  static const String _fullResponseText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
      'Praesent id efficitur nunc, blandit laoreet tortor. '
      'Interdum et malesuada fames ac ante ipsum primis in faucibus. '
      'Aliquam vel elit posuere, aliquet dolor nec, luctus eros. '
      'Quisque a luctus enim. Donec gravida quam nisl, id fermentum ipsum '
      'blandit a. Nam sed nisl sit amet quam gravida imperdiet. '
      'Suspendisse imperdiet sem nulla, sed blandit sem interdum in.\n\n'
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
      'Praesent id efficitur nunc, blandit laoreet tortor. '
      'Interdum et malesuada fames ac ante ipsum primis in faucibus. '
      'Aliquam vel elit posuere, aliquet dolor nec, luctus eros. '
      'Quisque a luctus enim. Donec gravida quam nisl, id fermentum ipsum '
      'blandit a. Nam sed nisl sit amet quam gravida imperdiet. '
      'Suspendisse imperdiet sem';

  String _displayedResultText = '';
  Timer? _typewriterTimer;

  @override
  void initState() {
    super.initState();
    _selectedSubBab = _subBabOptions.first;

    _judulController.addListener(_onInputChanged);
    _keteranganController.addListener(_onInputChanged);
  }

  void _onInputChanged() {
    if (_isGenerated) {
      _typewriterTimer?.cancel();
      setState(() {
        _isGenerated = false;
        _displayedResultText = '';
      });
    } else {
      setState(() {});
    }
  }

  void _handleSubBabChanged(String? val) {
    if (val != null && val != _selectedSubBab) {
      if (_isGenerated) {
        _typewriterTimer?.cancel();
        setState(() {
          _selectedSubBab = val;
          _isGenerated = false;
          _displayedResultText = '';
        });
      } else {
        setState(() {
          _selectedSubBab = val;
        });
      }
    }
  }

  void _handleClear() {
    setState(() {
      _judulController.clear();
      _keteranganController.clear();
      _selectedSubBab = _subBabOptions.first;
      _isGenerated = false;
      _displayedResultText = '';
    });
    _typewriterTimer?.cancel();
  }

  void _handleGenerate() {
    if (_isGenerated) return;

    setState(() {
      _isGenerated = true;
      _displayedResultText = '';
    });

    _typewriterTimer?.cancel();
    int currentIndex = 0;

    _typewriterTimer = Timer.periodic(const Duration(milliseconds: 15), (
      timer,
    ) {
      if (currentIndex < _fullResponseText.length) {
        setState(() {
          _displayedResultText += _fullResponseText[currentIndex];
          currentIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _typewriterTimer?.cancel();
    _judulController.dispose();
    _keteranganController.dispose();
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
                      'Detail Makalah',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _dark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Masukkan  deskripsi makalah\nyang akan anda buat',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF666666),
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Judul
                    const Text(
                      'Judul',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: _dark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _inputBorder, width: 1.2),
                      ),
                      child: TextField(
                        controller: _judulController,
                        style: const TextStyle(fontSize: 13.5, color: _dark),
                        decoration: const InputDecoration(
                          hintText: 'Masukkan Judul',
                          hintStyle: TextStyle(
                            fontSize: 13.5,
                            color: _placeholderGrey,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Sub Bab
                    const Text(
                      'Sub Bab',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: _dark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _inputBorder, width: 1.2),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedSubBab,
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: _dark,
                            size: 22,
                          ),
                          items:
                              _subBabOptions.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                      fontSize: 13.5,
                                      color: _dark,
                                    ),
                                  ),
                                );
                              }).toList(),
                          onChanged: _handleSubBabChanged,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Keterangan
                    const Text(
                      'Keterangan',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: _dark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 95,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _inputBorder, width: 1.2),
                      ),
                      child: Stack(
                        children: [
                          TextField(
                            controller: _keteranganController,
                            maxLength: 1000,
                            maxLines: null,
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            style: const TextStyle(
                              fontSize: 13.5,
                              color: _dark,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Jelaskan Makalah Anda Sedeatil Mungkin',
                              hintStyle: TextStyle(
                                fontSize: 13.5,
                                color: _placeholderGrey,
                              ),
                              border: InputBorder.none,
                              counterText: '',
                              contentPadding: EdgeInsets.fromLTRB(
                                14,
                                12,
                                14,
                                16,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 5,
                            bottom: 5,
                            child: CustomPaint(
                              size: const Size(8, 8),
                              painter: _ResizeHandlePainter(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${_keteranganController.text.length}/1000 Karakter',
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF666666),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Action buttons & Result
                    if (!_isGenerated)
                      Row(
                        children: [
                          GestureDetector(
                            onTap: _handleClear,
                            behavior: HitTestBehavior.opaque,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 8,
                              ),
                              child: Text(
                                'Clear',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _dark,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          _GenerateButton(
                            isEnabled: true,
                            onTap: _handleGenerate,
                          ),
                        ],
                      )
                    else ...[
                      _GenerateButton(isEnabled: false, onTap: null),
                      const SizedBox(height: 20),
                      Text(
                        _displayedResultText,
                        style: const TextStyle(
                          fontSize: 13,
                          color: _dark,
                          height: 1.45,
                        ),
                      ),
                    ],
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
            'Asisten Makalah',
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

// ==================== GENERATE BUTTON ====================
class _GenerateButton extends StatelessWidget {
  const _GenerateButton({required this.isEnabled, required this.onTap});

  final bool isEnabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isEnabled ? _dark : const Color(0xFFE5E5EA),
          borderRadius: BorderRadius.circular(8),
          border:
              isEnabled
                  ? null
                  : Border.all(color: const Color(0xFF9E9E9E), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.bolt_rounded,
              size: 18,
              color: isEnabled ? Colors.white : Colors.white,
            ),
            const SizedBox(width: 4),
            Text(
              'Generate',
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: isEnabled ? Colors.white : _dark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== RESIZE HANDLE ====================
class _ResizeHandlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFFC2C2C6)
          ..strokeWidth = 1.0
          ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(size.width - 2, size.height),
      Offset(size.width, size.height - 2),
      paint,
    );
    canvas.drawLine(
      Offset(size.width - 5, size.height),
      Offset(size.width, size.height - 5),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
