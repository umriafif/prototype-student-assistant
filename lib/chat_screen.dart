import 'package:flutter/material.dart';

const Color _panel = Color(0xFFFFFFFF);
const Color _border = Color(0xFFE8E8EA);
const Color _text = Color(0xFF2B2B2E);
const Color _dark = Color(0xFF1C1C1E);
const Color _mutedIcon = Color(0xFF3A3A3E);

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

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _panel,
      body: const Column(
        children: [
          _Header(),
          Divider(height: 1, thickness: 1, color: _border),
          Expanded(child: _ChatList()),
          _InputBar(),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _Hamburger(),
          Row(
            children: const [
              _HeaderButton(
                label: 'Sign in',
                background: Color(0xFFECECEE),
                foreground: _dark,
              ),
              SizedBox(width: 8),
              _HeaderButton(
                label: 'Register',
                background: _dark,
                foreground: Colors.white,
              ),
            ],
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
    return SizedBox(
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
    );
  }
}

class _HeaderButton extends StatelessWidget {
  const _HeaderButton({
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w600,
          color: foreground,
        ),
      ),
    );
  }
}

class _ChatList extends StatelessWidget {
  const _ChatList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      children: const [
        _UserBubble(
          text: 'Hey Flippy! Write me a script for building an Analag Clock.',
        ),
        SizedBox(height: 16),
        _BotMessage(),
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

class _BotMessage extends StatelessWidget {
  const _BotMessage();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Padding(padding: EdgeInsets.only(top: 3), child: _BotAvatar()),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sure. Here is a Typescript code block for your Analog Clock '
                'project. It\'s built using React, and uses the local time for '
                'London, England as standard. Let me know if you\'d like to '
                'make any refinements to the code.',
                style: TextStyle(fontSize: 13.5, height: 1.55, color: _text),
              ),
              SizedBox(height: 12),
              _CodeCard(),
            ],
          ),
        ),
      ],
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

class _CodeCard extends StatelessWidget {
  const _CodeCard();

  @override
  Widget build(BuildContext context) {
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
            children: [
              for (var i = 0; i < _codeLines.length; i++)
                _CodeLine(number: i + 1, tokens: _codeLines[i]),
            ],
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

class _InputBar extends StatelessWidget {
  const _InputBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: _border)),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(
          color: _panel,
          border: Border.all(color: _border),
          borderRadius: BorderRadius.circular(22),
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
            const Text(
              'What would you like to know?',
              style: TextStyle(fontSize: 13.5, color: Color(0xFFC2C2C6)),
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                _ToolIcon(icon: Icons.image_outlined),
                SizedBox(width: 18),
                _ToolIcon(icon: Icons.code),
                SizedBox(width: 18),
                _ToolIcon(icon: Icons.mic_none),
                Spacer(),
                _SendButton(),
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

class _SendButton extends StatelessWidget {
  const _SendButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        color: Color(0xFFE6E6E9),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.arrow_upward, size: 15, color: Color(0xFF8A8A90)),
    );
  }
}
