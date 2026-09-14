import 'dart:async';

import 'package:flutter/material.dart';

import 'profile.dart';
import 'widgets/sidebar.dart';

const Color _panel = Color(0xFFFFFFFF);
const Color _border = Color(0xFFE8E8EA);
const Color _text = Color(0xFF2B2B2E);
const Color _dark = Color(0xFF1C1C1E);
const Color _mutedIcon = Color(0xFF3A3A3E);
const Color _greyBg = Color(0xFFF4F4F6);
const Color _placeholderGrey = Color(0xFFC2C2C6);
const Color _disabledButtonBg = Color(0xFFE6E6E9);
const Color _disabledButtonIcon = Color(0xFFA0A0A5);

const Color _codeBg = Color(0xFFF5F5F5);
const Color _codeBorder = Color(0xFFE6E6E6);
const Color _lineNum = Color(0xFFB3B3B3);
const Color _lineDiv = Color(0xFFE2E2E2);
const Color _synKeyword = Color(0xFFC9893F);
const Color _synString = Color(0xFF4BAB7C);
const Color _synNumber = Color(0xFFD9534F);
const Color _synFn = Color(0xFFE05FC4);
const Color _synPunc = Color(0xFF9A9AA0);
const Color _synText = Color(0xFF4A4A4E);
const Color _synComment = Color(0xFFAAAAAA);

class CodexChatScreen extends StatefulWidget {
  const CodexChatScreen({super.key});

  @override
  State<CodexChatScreen> createState() => _CodexChatScreenState();
}

class _CodexChatScreenState extends State<CodexChatScreen> {
  static const _aiIntro =
      'Sure. Here is a Typescript code block for your Analog Clock project. '
      'It\'s built using React, and uses the local time for London, England '
      'as standard. Let me know if you\'d like to make any refinements to '
      'the code.';

  static const _userPrompt =
      'Hey Flippy! Write me a script for building an Analog Clock.';

  bool _isChatSubmitted = false;
  String _userMessage = '';
  String _displayedIntro = '';
  int _codeChars = 0;
  Timer? _typewriterTimer;
  final ScrollController _scrollController = ScrollController();

  void _handleSendMessage() {
    if (_isChatSubmitted) return;

    setState(() {
      _userMessage = _userPrompt;
      _isChatSubmitted = true;
      _displayedIntro = '';
      _codeChars = 0;
    });

    _typewriterTimer?.cancel();
    var introIndex = 0;
    _typewriterTimer = Timer.periodic(const Duration(milliseconds: 15), (
      timer,
    ) {
      if (introIndex < _aiIntro.length) {
        setState(() {
          introIndex++;
          _displayedIntro = _aiIntro.substring(0, introIndex);
        });
      } else if (_codeChars < _totalCodeChars) {
        setState(() {
          _codeChars++;
        });
      } else {
        timer.cancel();
        return;
      }
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  void dispose() {
    _typewriterTimer?.cancel();
    _scrollController.dispose();
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
                      controller: _scrollController,
                      userMessage: _userMessage,
                      introText: _displayedIntro,
                      revealedCodeChars: _codeChars,
                    )
                  : const _HeroCenter(),
            ),
            _InputBar(submitted: _isChatSubmitted, onSend: _handleSendMessage),
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
    return const Padding(
      padding: EdgeInsets.fromLTRB(18, 14, 18, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _Hamburger(),
          Text(
            'CodeX',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF666666),
            ),
          ),
          _AvatarButton(),
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

// ==================== EMPTY STATE ====================
class _HeroCenter extends StatelessWidget {
  const _HeroCenter();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            '{ ✦ }',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 56,
              fontWeight: FontWeight.w800,
              color: _dark,
              height: 1,
            ),
          ),
          SizedBox(height: 18),
          Text(
            'Lets Build',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: _dark,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'CodeX',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 15,
              color: Color(0xFF7C7C80),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== CHAT STREAM ====================
class _ChatStreamView extends StatelessWidget {
  const _ChatStreamView({
    required this.controller,
    required this.userMessage,
    required this.introText,
    required this.revealedCodeChars,
  });

  final ScrollController controller;
  final String userMessage;
  final String introText;
  final int revealedCodeChars;

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      children: [
        _UserBubble(text: userMessage),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 3),
              child: _BotAvatar(),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (introText.isNotEmpty)
                    Text(
                      introText,
                      style: const TextStyle(
                        fontSize: 13.5,
                        height: 1.55,
                        color: _text,
                      ),
                    ),
                  if (revealedCodeChars > 0) ...[
                    const SizedBox(height: 12),
                    _CodeCard(revealedChars: revealedCodeChars),
                  ],
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _UserBubble extends StatelessWidget {
  const _UserBubble({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: _panel,
          border: Border.all(color: const Color(0xFFE6E6E8)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 13.5, height: 1.5, color: _text),
        ),
      ),
    );
  }
}

class _BotAvatar extends StatelessWidget {
  const _BotAvatar();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 18,
      height: 20,
      child: CustomPaint(painter: _BotAvatarPainter()),
    );
  }
}

class _BotAvatarPainter extends CustomPainter {
  const _BotAvatarPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = _dark;
    for (final c in const [
      (5.0, 4.0),
      (13.0, 4.0),
      (5.0, 12.0),
      (13.0, 12.0),
    ]) {
      canvas.drawCircle(Offset(c.$1, c.$2), 3.1, paint);
    }
    canvas.drawRect(const Rect.fromLTWH(4.2, 4, 1.6, 8), paint);
    canvas.drawRect(const Rect.fromLTWH(12.2, 4, 1.6, 8), paint);
    canvas.drawRect(const Rect.fromLTWH(5, 3.2, 8, 1.6), paint);
    canvas.drawRect(const Rect.fromLTWH(5, 11.2, 8, 1.6), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==================== CODE CARD ====================
class _CodeCard extends StatelessWidget {
  const _CodeCard({required this.revealedChars});

  final int revealedChars;

  @override
  Widget build(BuildContext context) {
    final lines = <Widget>[];
    for (var i = 0; i < _codeLines.length; i++) {
      final start = _lineStarts[i];
      if (revealedChars <= start) break;
      lines.add(
        _CodeLine(
          number: i + 1,
          tokens: _truncateTokens(_codeLines[i], revealedChars - start),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: _codeBg,
        border: Border.all(color: _codeBorder),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: lines,
          ),
        ),
      ),
    );
  }
}

class _CodeLine extends StatelessWidget {
  const _CodeLine({required this.number, required this.tokens});

  final int number;
  final List<_Tok> tokens;

  @override
  Widget build(BuildContext context) {
    const baseStyle = TextStyle(
      fontFamily: 'monospace',
      fontSize: 11.5,
      height: 1.65,
      color: _synText,
    );
    return SizedBox(
      height: 19,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.only(right: 10),
            decoration: const BoxDecoration(
              border: Border(right: BorderSide(color: _lineDiv)),
            ),
            alignment: Alignment.centerRight,
            child: Text('$number', style: baseStyle.copyWith(color: _lineNum)),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Text.rich(
              TextSpan(
                children: [
                  for (final t in tokens)
                    TextSpan(
                      text: t.text,
                      style: baseStyle.copyWith(
                        color: t.color,
                        fontStyle: t.italic
                            ? FontStyle.italic
                            : FontStyle.normal,
                      ),
                    ),
                ],
              ),
              style: baseStyle,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _Tok {
  const _Tok(this.text, this.color, {this.italic = false});

  final String text;
  final Color color;
  final bool italic;
}

const List<List<_Tok>> _codeLines = [
  [
    _Tok('import', _synKeyword),
    _Tok(' React, { useState, useEffect } from', _synText),
  ],
  [_Tok('"react"', _synString), _Tok(';', _synText)],
  [
    _Tok('import', _synKeyword),
    _Tok(' { defineProperties } ', _synText),
    _Tok('from', _synKeyword),
  ],
  [_Tok('"figma:react"', _synString), _Tok(';', _synText)],
  [_Tok('', _synText)],
  [
    _Tok('export default function', _synKeyword),
    _Tok(' ', _synText),
    _Tok('AnalogClock', _synFn),
    _Tok('({', _synPunc),
  ],
  [
    _Tok('  updateInterval = ', _synText),
    _Tok('1000', _synNumber),
    _Tok(',', _synPunc),
  ],
  [
    _Tok('  secondHandColor = ', _synText),
    _Tok('"red"', _synString),
    _Tok(',', _synPunc),
  ],
  [
    _Tok('  minuteHandColor = ', _synText),
    _Tok('"black"', _synString),
    _Tok(',', _synPunc),
  ],
  [
    _Tok('  hourHandColor = ', _synText),
    _Tok('"black"', _synString),
    _Tok(',', _synPunc),
  ],
  [_Tok('}) {', _synPunc)],
  [
    _Tok('  ', _synText),
    _Tok('const', _synKeyword),
    _Tok(' [time, setTime] = ', _synText),
    _Tok('useState', _synFn),
    _Tok('({ hour:', _synPunc),
  ],
  [
    _Tok('0', _synNumber),
    _Tok(', minutes: ', _synText),
    _Tok('0', _synNumber),
    _Tok(', seconds: ', _synText),
    _Tok('0', _synNumber),
    _Tok(' });', _synPunc),
  ],
  [_Tok('', _synText)],
  [_Tok('  ', _synText), _Tok('useEffect', _synFn), _Tok('(() => {', _synPunc)],
  [
    _Tok('    ', _synText),
    _Tok('const', _synKeyword),
    _Tok(' updateClock = () => {', _synText),
  ],
  [
    _Tok(
      '      // Get London\'s local time using en-GB',
      _synComment,
      italic: true,
    ),
  ],
  [_Tok('      format', _synComment, italic: true)],
  [
    _Tok('      ', _synText),
    _Tok('const', _synKeyword),
    _Tok(' londonTimeString = ', _synText),
    _Tok('new', _synKeyword),
  ],
  [
    _Tok('      Date().toLocaleTimeString(', _synText),
    _Tok('"en-GB"', _synString),
    _Tok(', {', _synPunc),
  ],
  [
    _Tok('        timeZone: ', _synText),
    _Tok('"Europe/London"', _synString),
    _Tok(',', _synPunc),
  ],
  [_Tok('        hour12: ', _synText), _Tok('false', _synKeyword)],
  [_Tok('      });', _synPunc)],
  [
    _Tok('      ', _synText),
    _Tok('const', _synKeyword),
    _Tok(' [hoursStr, minutesStr,', _synText),
  ],
  [
    _Tok('      secondsStr] = londonTimeString.split(', _synText),
    _Tok('":"', _synString),
    _Tok(');', _synPunc),
  ],
  [_Tok('      setTime({', _synText)],
  [
    _Tok('        hours: ', _synText),
    _Tok('parseInt', _synFn),
    _Tok('(hoursStr, ', _synPunc),
    _Tok('10', _synNumber),
    _Tok('),', _synPunc),
  ],
  [
    _Tok('        minutes: ', _synText),
    _Tok('parseInt', _synFn),
    _Tok('(minutesStr, ', _synPunc),
    _Tok('10', _synNumber),
    _Tok(')', _synPunc),
  ],
  [
    _Tok('        seconds: ', _synText),
    _Tok('parseInt', _synFn),
    _Tok('(secondsStr, ', _synPunc),
    _Tok('10', _synNumber),
    _Tok(')', _synPunc),
  ],
  [_Tok('      });', _synPunc)],
  [_Tok('    };', _synPunc)],
  [_Tok('  };', _synPunc)],
  [_Tok('];', _synPunc)],
];

int _lineTextLength(List<_Tok> tokens) =>
    tokens.fold(0, (sum, token) => sum + token.text.length);

final List<int> _lineStarts = _computeLineStarts();

final int _totalCodeChars =
    _lineStarts.last + _lineTextLength(_codeLines.last) + 1;

List<int> _computeLineStarts() {
  final starts = <int>[];
  var offset = 0;
  for (final line in _codeLines) {
    starts.add(offset);
    // +1 virtual char per line so typing pauses briefly between lines
    offset += _lineTextLength(line) + 1;
  }
  return starts;
}

List<_Tok> _truncateTokens(List<_Tok> tokens, int maxChars) {
  if (maxChars <= 0) return const [];
  final result = <_Tok>[];
  var remaining = maxChars;
  for (final token in tokens) {
    if (remaining <= 0) break;
    if (token.text.length <= remaining) {
      result.add(token);
      remaining -= token.text.length;
    } else {
      result.add(
        _Tok(
          token.text.substring(0, remaining),
          token.color,
          italic: token.italic,
        ),
      );
      remaining = 0;
    }
  }
  return result;
}

// ==================== INPUT BAR ====================
class _InputBar extends StatefulWidget {
  const _InputBar({required this.submitted, required this.onSend});

  final bool submitted;
  final VoidCallback onSend;

  @override
  State<_InputBar> createState() => _InputBarState();
}

class _InputBarState extends State<_InputBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final active = widget.submitted;

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(
          color: _panel,
          border: Border.all(color: _border),
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F14141E),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              maxLines: null,
              style: const TextStyle(fontSize: 13.5, color: _dark),
              decoration: const InputDecoration(
                hintText: 'What would you like to know?',
                hintStyle: TextStyle(fontSize: 13.5, color: _placeholderGrey),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const _ToolIcon(icon: Icons.image_outlined),
                const SizedBox(width: 18),
                const _ToolIcon(icon: Icons.code),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (widget.submitted) return;
                    _controller.clear();
                    widget.onSend();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: active ? _dark : _disabledButtonBg,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_upward,
                      size: 17,
                      color: active ? Colors.white : _disabledButtonIcon,
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

class _ToolIcon extends StatelessWidget {
  const _ToolIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: 18, color: _mutedIcon);
  }
}
