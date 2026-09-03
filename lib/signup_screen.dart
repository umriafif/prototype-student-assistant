import 'dart:math' as math;

import 'package:flutter/material.dart';

const _primary = Color(0xFF1C1C1E);
const _labelGrey = Color(0xFF8E8E93);
const _hintGrey = Color(0xFFABABAB);
const _borderGrey = Color(0xFFE0E0E0);

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Email wajib diisi';
    final pattern = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$');
    if (!pattern.hasMatch(email)) return 'Format email tidak valid';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password wajib diisi';
    if (value.length < 6) return 'Password minimal 6 karakter';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi password wajib diisi';
    }
    if (value != _passwordController.text) return 'Password tidak cocok';
    return null;
  }

  void _onSignUp() {
    if (!_formKey.currentState!.validate()) return;
    _showSnackBar('Registrasi berhasil (demo)');
  }

  InputDecoration _decoration(String hint) {
    final outline = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _borderGrey, width: 1.4),
    );
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: _hintGrey, fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      enabledBorder: outline,
      focusedBorder: outline.copyWith(
        borderSide: const BorderSide(color: _primary, width: 1.4),
      ),
      errorBorder: outline.copyWith(
        borderSide: const BorderSide(color: Color(0xFFE53935), width: 1.4),
      ),
      focusedErrorBorder: outline.copyWith(
        borderSide: const BorderSide(color: Color(0xFFE53935), width: 1.4),
      ),
    );
  }

  Widget _fieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: _primary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _BackButton(
                      onTap: () => Navigator.of(context).maybePop(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Center(child: AppLogo(size: 92)),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Student Assistant',
                      style: TextStyle(
                        color: _primary,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: _labelGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _fieldLabel('Email'),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autocorrect: false,
                          validator: _validateEmail,
                          decoration: _decoration('Masukkan Email'),
                        ),
                        const SizedBox(height: 18),
                        _fieldLabel('Password'),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: _validatePassword,
                          decoration: _decoration('Masukkan Password'),
                        ),
                        const SizedBox(height: 18),
                        _fieldLabel('Repeat Password'),
                        TextFormField(
                          controller: _confirmController,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: _validateConfirmPassword,
                          decoration: _decoration('Masukkan Password'),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 52,
                          child: FilledButton(
                            onPressed: _onSignUp,
                            style: FilledButton.styleFrom(
                              backgroundColor: _primary,
                              foregroundColor: Colors.white,
                              shape: const StadiumBorder(),
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            child: const Text('Sign Up'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const _OrDivider(),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () =>
                          _showSnackBar('Login dengan Google belum tersedia'),
                      icon: const _GoogleLogo(size: 20),
                      label: const Text('Continue with Google'),
                      style: _outlineStyle,
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () =>
                          _showSnackBar('Login dengan Facebook belum tersedia'),
                      icon: const _FacebookLogo(size: 20),
                      label: const Text('Continue with Facebook'),
                      style: _outlineStyle,
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () =>
                          _showSnackBar('Halaman Sign In belum tersedia'),
                      style: _outlineStyle,
                      child: const Text('Sign In'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ButtonStyle get _outlineStyle => OutlinedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: _primary,
    side: const BorderSide(color: _borderGrey, width: 1.4),
    shape: const StadiumBorder(),
    textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
  );
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF4F4F6),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: const SizedBox(
          width: 44,
          height: 44,
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: Color(0xFF1C1C1E),
          ),
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: _borderGrey, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            'ATAU',
            style: TextStyle(
              color: _labelGrey,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
        Expanded(child: Divider(color: _borderGrey, thickness: 1)),
      ],
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.square(size), painter: _AppLogoPainter());
  }
}

class _AppLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final paint = Paint()..color = const Color(0xFF1C1C1E);
    final lobes = [
      (Offset(s * 0.5, s * 0.62), s * 0.33),
      (Offset(s * 0.26, s * 0.42), s * 0.24),
      (Offset(s * 0.74, s * 0.42), s * 0.24),
      (Offset(s * 0.5, s * 0.2), s * 0.17),
      (Offset(s * 0.42, s * 0.78), s * 0.09),
      (Offset(s * 0.58, s * 0.78), s * 0.09),
    ];
    for (final (center, radius) in lobes) {
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _AppLogoPainter oldDelegate) => false;
}

class _GoogleLogo extends StatelessWidget {
  const _GoogleLogo({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.square(size), painter: _GoogleLogoPainter());
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final d = size.shortestSide;
    final strokeWidth = d * 0.115;
    final radius = (d - strokeWidth) / 2;
    final center = Offset(d / 2, d / 2);
    final rect = Rect.fromCircle(center: center, radius: radius);
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Arc start/end angles split by small gaps at the diagonal joints and a
    // wider opening on the right where the horizontal bar sits.
    const joints = <(Color, double, double)>[
      (Color(0xFF4285F4), 228, 84), // blue, top
      (Color(0xFF34A853), 318, 36), // green, above opening
      (Color(0xFF34A853), 6, 36), // green, below opening
      (Color(0xFFFBBC05), 48, 84), // yellow, bottom
      (Color(0xFFEA4335), 138, 84), // red, left
    ];
    for (final (color, start, sweep) in joints) {
      stroke.color = color;
      canvas.drawArc(rect, _radians(start), _radians(sweep), false, stroke);
    }

    // Horizontal green bar reaching inward from the right side of the ring.
    final startX = center.dx + radius - strokeWidth / 2;
    final tipX = center.dx + radius * 0.52 - strokeWidth / 2;
    stroke.color = const Color(0xFF34A853);
    canvas.drawLine(Offset(startX, center.dy), Offset(tipX, center.dy), stroke);
  }

  @override
  bool shouldRepaint(covariant _GoogleLogoPainter oldDelegate) => false;
}

double _radians(double degrees) => degrees * math.pi / 180;

class _FacebookLogo extends StatelessWidget {
  const _FacebookLogo({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _FacebookLogoPainter(),
    );
  }
}

class _FacebookLogoPainter extends CustomPainter {
  static const _blue = Color(0xFF1877F2);

  @override
  void paint(Canvas canvas, Size size) {
    final d = size.shortestSide;
    canvas.drawCircle(Offset(d / 2, d / 2), d / 2, Paint()..color = _blue);

    final textPainter = TextPainter(
      text: TextSpan(
        text: 'f',
        style: TextStyle(
          color: Colors.white,
          fontSize: d * 0.68,
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      Offset(
        d / 2 - textPainter.width / 2,
        d / 2 - textPainter.height / 2 - d * 0.02,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant _FacebookLogoPainter oldDelegate) => false;
}
