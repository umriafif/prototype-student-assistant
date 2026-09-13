import 'package:flutter/material.dart';

const Color _background = Color(0xFFF5F5F5);
const Color _panel = Color(0xFFFFFFFF);
const Color _border = Color(0xFFE7E7EC);
const Color _dark = Color(0xFF1C1C1E);
const Color _textPrimary = Color(0xFF1D1B20);
const Color _textSecondary = Color(0xCC1D1B20);

void main() {
  runApp(const UpgradePlanApp());
}

class UpgradePlanApp extends StatelessWidget {
  const UpgradePlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upgrade Paket',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: _background,
        colorScheme: ColorScheme.fromSeed(seedColor: _dark),
      ),
      home: const UpgradePlanScreen(),
    );
  }
}

class UpgradePlanScreen extends StatelessWidget {
  const UpgradePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: Center(
          child: Container(
            width: 412,
            height:
                mediaQuery.size.height -
                mediaQuery.padding.top -
                mediaQuery.padding.bottom,
            decoration: const BoxDecoration(color: _panel),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _TopBar(),
                  const SizedBox(height: 20),
                  const Text(
                    'AI Student Assistant Pro',
                    style: TextStyle(
                      color: _textPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _panel,
                      border: Border.all(color: _border),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x08000000),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Fitur',
                                style: TextStyle(
                                  color: _textPrimary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 64,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Gratis',
                                  style: TextStyle(
                                    color: _textPrimary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 64,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Pro',
                                  style: TextStyle(
                                    color: _textPrimary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const _FeatureRow('Model Dasar', freeCheck: true),
                        const _FeatureRow('Lebih banyak pesan'),
                        const _FeatureRow('Lebih banyak unggahan'),
                        const _FeatureRow('Memori lebih panjang'),
                      ],
                    ),
                  ),

                  const Spacer(),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: _dark,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Center(
                      child: Text(
                        'Upgrade seharga Rp1,2 triliun',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
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
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).maybePop(),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _panel,
              border: Border.all(color: _border),
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: _dark,
              ),
            ),
          ),
        ),
        const Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: SizedBox(width: 48, height: 48),
          ),
        ),
      ],
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow(this.label, {this.freeCheck = false});

  final String label;
  final bool freeCheck;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: _textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            width: 64,
            child: Center(
              child: Icon(
                freeCheck ? Icons.check_rounded : Icons.remove_rounded,
                size: 18,
                color: _dark,
              ),
            ),
          ),
          const SizedBox(
            width: 64,
            child: Center(
              child: Icon(Icons.check_rounded, size: 18, color: _dark),
            ),
          ),
        ],
      ),
    );
  }
}
