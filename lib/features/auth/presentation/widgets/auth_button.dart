import 'package:flutter/material.dart';
import 'package:reto_asap/core/theme/app_theme.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const AuthButton(
      {super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              AppPalleteColor.gradient1,
              AppPalleteColor.gradient2,
              // AppPal leteColor.gradient3,
            ],
          ),
          borderRadius: BorderRadius.circular(100)),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          fixedSize: Size(size.width, 50),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
