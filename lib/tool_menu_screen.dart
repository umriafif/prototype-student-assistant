import 'package:flutter/material.dart';

const _dark = Color(0xFF1C1C1E);
const _greys = Color(0xFF8E8E93);
const _greylight = Color(0xFFC2C2C6);
const _greyBg = Color(0xFFF4F4F6);
const _circleBg = Color(0xFFEFEFF1);

const _featured = [
  _FeaturedTool(
    title: 'CodeX',
    description: 'Tool untuk membantu tugas coding anda',
    usage: 'Today • 10k User',
    painter: _CodeXIconPainter(),
  ),
  _FeaturedTool(
    title: 'Makalah',
    description: 'Buat makalah dengan mudah dengan bantuan AI',
    usage: 'Today • 5k User',
    painter: _MakalahIconPainter(),
  ),
  _FeaturedTool(
    title: 'Paraphrase',
    description: 'Paraphrase teks anda hanya dengan sekali klik',
    usage: 'Today • 2k User',
    painter: _ParaphraseIconPainter(),
  ),
];

const _tools = [
  _ToolItem(title: 'Makalah', painter: _MakalahIconPainter()),
  _ToolItem(title: 'Paraphrase', painter: _ParaphraseIconPainter()),
  _ToolItem(title: 'CodeX', painter: _CodeXIconPainter()),
  _ToolItem(title: 'Grammar', painter: _GrammarIconPainter()),
  _ToolItem(title: 'Math', painter: _MathIconPainter()),
  _ToolItem(title: 'Journal Search', painter: _JournalIconPainter()),
  _ToolItem(title: 'Summarize', painter: _SummarizeIconPainter()),
  _ToolItem(title: 'Citation', painter: _CitationIconPainter()),
  _ToolItem(title: 'Translate', painter: _TranslateIconPainter()),
];

class ToolMenuScreen extends StatelessWidget {
  const ToolMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 18, 10),
              child: Row(
                children: [
                  _BackButton(onTap: () => Navigator.of(context).maybePop()),
                  const Spacer(),
                  const _AvatarButton(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 2, 16, 10),
              child: _SearchPill(
                onTap: () => _placeholder(context, 'Fitur belum tersedia'),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                children: [
                  const _SectionLabel('Unggulan'),
                  const SizedBox(height: 10),
                  for (final tool in _featured)
                    _FeaturedTile(
                      tool: tool,
                      onTap: () =>
                          _placeholder(context, 'Fitur belum tersedia'),
                    ),
                  const SizedBox(height: 24),
                  const _SectionLabel('Tools'),
                  const SizedBox(height: 14),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.78,
                    children: [
                      for (final tool in _tools)
                        _ToolTile(
                          tool: tool,
                          onTap: () =>
                              _placeholder(context, 'Fitur belum tersedia'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _placeholder(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: _dark,
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _greyBg,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: const SizedBox(
          width: 40,
          height: 40,
          child: Icon(Icons.arrow_back_ios_new_rounded, size: 17, color: _dark),
        ),
      ),
    );
  }
}

class _AvatarButton extends StatelessWidget {
  const _AvatarButton();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 40,
      height: 40,
      child: CircleAvatar(
        backgroundColor: _greyBg,
        child: Icon(Icons.person, size: 22, color: _dark),
      ),
    );
  }
}

class _SearchPill extends StatelessWidget {
  const _SearchPill({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: _greyBg,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: const [
            Icon(Icons.search, size: 19, color: _greys),
            SizedBox(width: 10),
            Text(
              'Search tool',
              style: TextStyle(fontSize: 14, color: _greylight),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturedTile extends StatelessWidget {
  const _FeaturedTile({required this.tool, required this.onTap});

  final _FeaturedTool tool;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 54,
              height: 54,
              child: CustomPaint(painter: tool.painter),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tool.title,
                    style: const TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w700,
                      color: _dark,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    tool.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.35,
                      color: _greys,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    tool.usage,
                    style: const TextStyle(fontSize: 12, color: _greylight),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolTile extends StatelessWidget {
  const _ToolTile({required this.tool, required this.onTap});

  final _ToolItem tool;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          SizedBox(
            width: 78,
            height: 78,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: _circleBg,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: CustomPaint(painter: tool.painter),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            tool.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: _dark,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedTool {
  const _FeaturedTool({
    required this.title,
    required this.description,
    required this.usage,
    required this.painter,
  });

  final String title;
  final String description;
  final String usage;
  final CustomPainter painter;
}

class _ToolItem {
  const _ToolItem({required this.title, required this.painter});

  final String title;
  final CustomPainter painter;
}

class _MakalahIconPainter extends CustomPainter {
  const _MakalahIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()..color = _dark;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.1, h * 0.05, w * 0.8, h * 0.9),
      Radius.circular(w * 0.12),
    );
    canvas.drawRRect(rrect, paint);

    // Folded corner notch
    final notch = Path()
      ..moveTo(w * 0.66, h * 0.05)
      ..lineTo(w * 0.9, h * 0.29)
      ..lineTo(w * 0.66, h * 0.29)
      ..close();
    canvas.save();
    canvas.clipRRect(rrect);
    canvas.drawPath(notch, Paint()..color = Colors.white);
    canvas.restore();

    // Star sparkle
    final c = Offset(w * 0.4, h * 0.55);
    final star = Path()
      ..moveTo(c.dx, c.dy - h * 0.16)
      ..lineTo(c.dx + w * 0.07, c.dy)
      ..lineTo(c.dx, c.dy + h * 0.16)
      ..lineTo(c.dx - w * 0.07, c.dy)
      ..close();
    canvas.save();
    canvas.clipRRect(rrect);
    canvas.drawPath(star, Paint()..color = Colors.white);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _MakalahIconPainter oldDelegate) => false;
}

class _ParaphraseIconPainter extends CustomPainter {
  const _ParaphraseIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    _paintTextGlyph(
      canvas,
      size,
      '\u00B6',
      (d) => TextStyle(
        fontFamily: 'serif',
        fontSize: size.height * d,
        fontWeight: FontWeight.w900,
        color: _dark,
        height: 1,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant _ParaphraseIconPainter oldDelegate) => false;
}

class _CodeXIconPainter extends CustomPainter {
  const _CodeXIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()
      ..color = _dark
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.11
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Left brace
    final left = Path()
      ..moveTo(w * 0.3, h * 0.16)
      ..lineTo(w * 0.18, h * 0.32)
      ..lineTo(w * 0.18, h * 0.68)
      ..lineTo(w * 0.3, h * 0.84);
    canvas.drawPath(left, paint);
    // Right brace
    final right = Path()
      ..moveTo(w * 0.7, h * 0.16)
      ..lineTo(w * 0.82, h * 0.32)
      ..lineTo(w * 0.82, h * 0.68)
      ..lineTo(w * 0.7, h * 0.84);
    canvas.drawPath(right, paint);

    _drawSparkle(canvas, Offset(w * 0.5, h * 0.5), w * 0.2, _dark);
  }

  @override
  bool shouldRepaint(covariant _CodeXIconPainter oldDelegate) => false;
}

class _GrammarIconPainter extends CustomPainter {
  const _GrammarIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    _paintTextGlyph(
      canvas,
      size,
      'AA',
      (d) => TextStyle(
        fontFamily: 'serif',
        fontSize: size.height * d,
        fontWeight: FontWeight.w900,
        color: _dark,
        height: 1,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant _GrammarIconPainter oldDelegate) => false;
}

class _MathIconPainter extends CustomPainter {
  const _MathIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    _paintTextGlyph(
      canvas,
      size,
      'fx',
      (d) => TextStyle(
        fontFamily: 'serif',
        fontSize: size.height * d,
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.italic,
        color: _dark,
        height: 1,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant _MathIconPainter oldDelegate) => false;
}

class _JournalIconPainter extends CustomPainter {
  const _JournalIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()..color = _dark;
    final stroke = Paint()
      ..color = _dark
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.07;

    // Left page
    final path = Path()
      ..moveTo(w * 0.08, h * 0.16)
      ..quadraticBezierTo(w * 0.26, h * 0.08, w * 0.5, h * 0.22)
      ..quadraticBezierTo(w * 0.26, h * 0.36, w * 0.08, h * 0.28)
      ..close();
    canvas.drawPath(path, paint);
    // Right page
    final path2 = Path()
      ..moveTo(w * 0.92, h * 0.16)
      ..quadraticBezierTo(w * 0.74, h * 0.08, w * 0.5, h * 0.22)
      ..quadraticBezierTo(w * 0.74, h * 0.36, w * 0.92, h * 0.28)
      ..close();
    canvas.drawPath(path2, paint);

    // Spine
    canvas.drawLine(
      Offset(w * 0.5, h * 0.22),
      Offset(w * 0.5, h * 0.84),
      stroke,
    );
    // Base
    canvas.drawLine(
      Offset(w * 0.08, h * 0.28),
      Offset(w * 0.08, h * 0.8),
      stroke,
    );
    canvas.drawLine(
      Offset(w * 0.92, h * 0.28),
      Offset(w * 0.92, h * 0.8),
      stroke,
    );
    canvas.drawLine(
      Offset(w * 0.08, h * 0.8),
      Offset(w * 0.5, h * 0.92),
      stroke,
    );
    canvas.drawLine(
      Offset(w * 0.92, h * 0.8),
      Offset(w * 0.5, h * 0.92),
      stroke,
    );
  }

  @override
  bool shouldRepaint(covariant _JournalIconPainter oldDelegate) => false;
}

class _SummarizeIconPainter extends CustomPainter {
  const _SummarizeIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()..color = _dark;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.1, h * 0.06, w * 0.8, h * 0.88),
      Radius.circular(w * 0.1),
    );
    canvas.drawRRect(rect, paint);

    final linePaint = Paint()..color = Colors.white;
    for (var i = 0; i < 4; i++) {
      final y = h * 0.24 + i * h * 0.17;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(w * 0.23, y, w * 0.54, h * 0.07),
          const Radius.circular(2),
        ),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SummarizeIconPainter oldDelegate) => false;
}

class _CitationIconPainter extends CustomPainter {
  const _CitationIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()..color = _dark;

    // Left quote
    final lRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.06, h * 0.3, w * 0.34, h * 0.36),
      Radius.circular(w * 0.09),
    );
    canvas.drawRRect(lRect, paint);
    _drawQuoteTail(canvas, Offset(w * 0.23, h * 0.66), false, w * 0.14, _dark);

    // Right quote
    final rRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.6, h * 0.3, w * 0.34, h * 0.36),
      Radius.circular(w * 0.09),
    );
    canvas.drawRRect(rRect, paint);
    _drawQuoteTail(canvas, Offset(w * 0.77, h * 0.66), true, w * 0.14, _dark);
  }

  @override
  bool shouldRepaint(covariant _CitationIconPainter oldDelegate) => false;
}

class _TranslateIconPainter extends CustomPainter {
  const _TranslateIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // "A" at top-left
    _paintTextGlyph(
      canvas,
      size,
      'A',
      (d) => TextStyle(
        fontFamily: 'serif',
        fontSize: size.height * d,
        fontWeight: FontWeight.w900,
        color: _dark,
        height: 1,
      ),
      scale: 0.72,
      align: Alignment.topLeft,
      offset: Offset(w * 0.06, h * 0.02),
    );

    // Right bottom box with a few strokes
    final paint = Paint()..color = _dark;
    final box = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.42, h * 0.42, w * 0.52, h * 0.52),
      Radius.circular(w * 0.08),
    );
    canvas.drawRRect(box, paint);
    final linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = w * 0.05
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(w * 0.54, h * 0.55),
      Offset(w * 0.54, h * 0.82),
      linePaint,
    );
    canvas.drawLine(
      Offset(w * 0.68, h * 0.52),
      Offset(w * 0.68, h * 0.85),
      linePaint,
    );
    canvas.drawLine(
      Offset(w * 0.54, h * 0.68),
      Offset(w * 0.82, h * 0.68),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _TranslateIconPainter oldDelegate) => false;
}

void _drawSparkle(Canvas canvas, Offset center, double radius, Color color) {
  final paint = Paint()..color = color;
  final path = Path()
    ..moveTo(center.dx, center.dy - radius)
    ..lineTo(center.dx + radius * 0.32, center.dy - radius * 0.32)
    ..lineTo(center.dx + radius, center.dy)
    ..lineTo(center.dx + radius * 0.32, center.dy + radius * 0.32)
    ..lineTo(center.dx, center.dy + radius)
    ..lineTo(center.dx - radius * 0.32, center.dy + radius * 0.32)
    ..lineTo(center.dx - radius, center.dy)
    ..lineTo(center.dx - radius * 0.32, center.dy - radius * 0.32)
    ..close();
  canvas.drawPath(path, paint);
}

void _drawQuoteTail(
  Canvas canvas,
  Offset base,
  bool flip,
  double radius,
  Color color,
) {
  final paint = Paint()..color = color;
  final dir = flip ? -1.0 : 1.0;
  final path = Path()
    ..moveTo(base.dx + dir * radius, base.dy)
    ..lineTo(base.dx - dir * radius, base.dy + radius * 0.9)
    ..lineTo(base.dx - dir * radius * 0.4, base.dy + radius * 0.9)
    ..close();
  canvas.drawPath(path, paint);
}

void _paintTextGlyph(
  Canvas canvas,
  Size size,
  String text,
  TextStyle Function(double) styleBuilder, {
  double scale = 1,
  Alignment align = Alignment.center,
  Offset offset = Offset.zero,
}) {
  final tp = TextPainter(
    text: TextSpan(text: text, style: styleBuilder(scale)),
    textDirection: TextDirection.ltr,
  )..layout();
  final dx = align.x < 0
      ? offset.dx
      : align.x > 0
      ? size.width - tp.width + offset.dx
      : (size.width - tp.width) / 2 + offset.dx;
  final dy = align.y < 0
      ? offset.dy
      : align.y > 0
      ? size.height - tp.height + offset.dy
      : (size.height - tp.height) / 2 + offset.dy;
  tp.paint(canvas, Offset(dx, dy));
}
