import 'dart:async';
import 'package:flutter/material.dart';

import '../profile.dart';
import '../widgets/sidebar.dart';

const Color _panel = Color(0xFFFFFFFF);
const Color _border = Color(0xFFE8E8EA);
const Color _dark = Color(0xFF1C1C1E);
const Color _greyBg = Color(0xFFF4F4F6);
const Color _placeholderGrey = Color(0xFFC2C2C6);
const Color _disabledButtonBg = Color(0xFFE6E6E9);
const Color _disabledButtonIcon = Color(0xFFA0A0A5);

class MathChatScreen extends StatefulWidget {
  const MathChatScreen({super.key});

  @override
  State<MathChatScreen> createState() => _MathChatScreenState();
}

class _MathChatScreenState extends State<MathChatScreen> {
  bool _isFileUploaded = false;
  String _uploadedFileName = '';
  bool _isChatSubmitted = false;
  String _userSubmittedQuestion = '';

  // Jawaban AI matematika
  final String _aiFullResponse =
      '''To solve this system of equations, we will use the substitution method to reduce the system to a single-variable quadratic equation. Here is the step-by-step solution.

**Step 1: Express one variable in terms of the other**
Take the linear equation \$x + y = 7\$ and solve for \$y\$:
\$y = 7 - x\$

**Step 2: Substitute into the quadratic equation**
Substitute \$y = 7 - x\$ into \$x^2 + y^2 = 25\$:
\$x^2 + (7 - x)^2 = 25\$

**Step 3: Expand and simplify**
Expand the squared term and combine like terms:
\$x^2 + (49 - 14x + x^2) = 25\$
\$2x^2 - 14x + 49 = 25\$
\$2x^2 - 14x + 24 = 0\$

**Step 4: Solve the quadratic equation**
Divide the entire equation by 2 to simplify:
\$x^2 - 7x + 12 = 0\$
Factor the quadratic:
\$(x - 3)(x - 4) = 0\$
Thus, \$x = 3\$ or \$x = 4\$.

**Step 5: Find the corresponding y-values**
If \$x = 3\$, then \$y = 7 - 3 = 4\$.
If \$x = 4\$, then \$y = 7 - 4 = 3\$.

**Final Answer**
The real solutions are \$(3, 4)\$ and \$(4, 3)\$.''';

  String _displayedAiText = '';
  Timer? _typewriterTimer;

  // Handler upload file
  void _handleUploadFile() {
    setState(() {
      _isFileUploaded = true;
      _uploadedFileName = 'math_problem.png';
    });
  }

  // Handler hapus file
  void _handleRemoveFile() {
    setState(() {
      _isFileUploaded = false;
      _uploadedFileName = '';
    });
  }

  // Handler kirim pesan
  void _handleSendMessage(String text) {
    if (_isChatSubmitted) return;

    setState(() {
      _userSubmittedQuestion = text;
      _isChatSubmitted = true;
      _displayedAiText = '';
    });

    _handleRemoveFile();

    _typewriterTimer?.cancel();
    int currentIndex = 0;

    // Memunculkan karakter balasan AI satu per satu
    _typewriterTimer = Timer.periodic(const Duration(milliseconds: 15), (
      timer,
    ) {
      if (currentIndex < _aiFullResponse.length) {
        setState(() {
          _displayedAiText += _aiFullResponse[currentIndex];
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
              child: _isChatSubmitted
                  ? _ChatStreamView(
                      userQuestion: _userSubmittedQuestion,
                      aiResponseText: _displayedAiText,
                    )
                  : const _HeroCenter(),
            ),
            _InputBar(
              isFileUploaded: _isFileUploaded,
              fileName: _uploadedFileName,
              onUploadPressed: _handleUploadFile,
              onRemoveFilePressed: _handleRemoveFile,
              onSendPressed: _handleSendMessage,
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
            'Math',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
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

// ==================== HERO CENTER (TAMPILAN AWAL) ====================
class _HeroCenter extends StatelessWidget {
  const _HeroCenter();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/icons/math-icon.png', width: 80, height: 80),
          SizedBox(height: 16),
          Text(
            'Math Assistant',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: _dark,
              letterSpacing: -0.3,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'AI Student Assistant',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF8E8E93),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== CHAT STREAM VIEW ====================
class _ChatStreamView extends StatelessWidget {
  const _ChatStreamView({
    required this.userQuestion,
    required this.aiResponseText,
  });

  final String userQuestion;
  final String aiResponseText;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.only(left: 40, bottom: 20),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E5EA)),
            ),
            child: Text(
              userQuestion,
              style: const TextStyle(fontSize: 14, color: _dark, height: 1.4),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 2),
              width: 24,
              height: 24,
              child: const Icon(Icons.widgets, size: 22, color: _dark),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                aiResponseText,
                style: const TextStyle(
                  fontSize: 13.5,
                  color: _dark,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ==================== INPUT BAR ====================
class _InputBar extends StatefulWidget {
  const _InputBar({
    required this.isFileUploaded,
    required this.fileName,
    required this.onUploadPressed,
    required this.onRemoveFilePressed,
    required this.onSendPressed,
  });

  final bool isFileUploaded;
  final String fileName;
  final VoidCallback onUploadPressed;
  final VoidCallback onRemoveFilePressed;
  final Function(String) onSendPressed;

  @override
  State<_InputBar> createState() => _InputBarState();
}

class _InputBarState extends State<_InputBar> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final textIsNotEmpty = _controller.text.trim().isNotEmpty;
      if (_hasText != textIsNotEmpty) {
        setState(() {
          _hasText = textIsNotEmpty;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool canSend = _hasText || widget.isFileUploaded;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 12, 10),
        constraints: const BoxConstraints(minHeight: 100),
        decoration: BoxDecoration(
          color: _panel,
          border: Border.all(color: _border, width: 1.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.isFileUploaded) ...[
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F2F7),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE5E5EA)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.insert_drive_file_outlined,
                          size: 16,
                          color: _dark,
                        ),
                        const SizedBox(width: 6),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 180),
                          child: Text(
                            widget.fileName.isNotEmpty
                                ? widget.fileName
                                : 'math_problem.png',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: _dark,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: widget.onRemoveFilePressed,
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: Color(0xFF8E8E93),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                TextField(
                  controller: _controller,
                  maxLines: null,
                  style: const TextStyle(fontSize: 13.5, color: _dark),
                  decoration: const InputDecoration(
                    hintText: 'What would you like to know?',
                    hintStyle: TextStyle(
                      fontSize: 13.5,
                      color: _placeholderGrey,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.only(top: 4, bottom: 8),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: widget.onUploadPressed,
                  child: Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.add,
                      size: 24,
                      color: _dark,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (canSend) {
                      final String messageText = _controller.text.trim().isEmpty
                          ? 'Solve the uploaded math problem.'
                          : _controller.text.trim();

                      _controller.clear();
                      widget.onSendPressed(messageText);
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: canSend ? _dark : _disabledButtonBg,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_upward,
                      size: 18,
                      color: canSend ? Colors.white : _disabledButtonIcon,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}