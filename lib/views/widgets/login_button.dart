import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String label;
  final dynamic onPressed;
  final bool isOutlined;
  final bool isDisabled;
  final String tooltipMessage;

  const LoginButton({super.key, 
    required this.label,
    required this.onPressed,
    this.isOutlined = false,
    this.isDisabled = false,
      this.tooltipMessage = ""
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        key: const ValueKey('loginKey'),
        onPressed: () => onPressed(),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(0),
        ),
        child: Container(
          padding: isOutlined
              ? const EdgeInsets.symmetric(horizontal: 15, vertical: 14)
              : const EdgeInsets.all(15),
          width: double.infinity,
          decoration: BoxDecoration(
            color: isOutlined
                ? null
                : isDisabled
                    ? const Color(0xFFA3B3D9)
                    : Colors.blue,
            borderRadius: BorderRadius.circular(8),
            border: isOutlined
                ? Border.all(
                    width: 1.5,
                    color: const Color(0xFF244AA4),
                  )
                : null,
          ),
          child: Text(
            label,
            semanticsLabel: label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isOutlined ? const Color(0xFF244AA4) : Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.normal,
              letterSpacing: 1.0,
            ),
          ),
        ),
      );
  }
}