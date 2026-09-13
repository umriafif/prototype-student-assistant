import 'package:flutter/material.dart';

import 'signin_screen.dart';

const Color _popupBackground = Color(0xFF4A4459);
const Color _popupText = Colors.white;

class SignOutPopup extends StatelessWidget {
  const SignOutPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: _popupBackground,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 280, maxWidth: 560),
        child: SizedBox(
          width: 312,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 24, height: 24),
                    const SizedBox(height: 16),
                    const Text(
                      'Continue to sign out',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _popupText,
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Apakah anda yakin ingin keluar?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _popupText,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.43,
                        letterSpacing: 0.25,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 24,
                  left: 8,
                  right: 24,
                  bottom: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _PopupActionButton(
                      label: 'Cancel',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 8),
                    _PopupActionButton(
                      label: 'Next',
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute<void>(
                            builder: (_) => const SignInScreen(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PopupActionButton extends StatelessWidget {
  const _PopupActionButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: _popupText,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        textStyle: const TextStyle(
          fontSize: 14,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          height: 1.43,
          letterSpacing: 0.10,
        ),
      ),
      child: Text(label),
    );
  }
}
