import 'package:flutter/material.dart';

import '../constants/color_constant.dart';
import '../constants/style_constant.dart';

class ButtonWithAsset extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final String iconAsset;
  final bool showShadow;
  final Color backgroundColor;
  final BorderSide borderSide;
  final Color textColor;

  const ButtonWithAsset({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.iconAsset,
    this.showShadow = true,
    this.backgroundColor = lighterBlue,
    this.borderSide = const BorderSide(
      width: 0,
      style: BorderStyle.none,
    ),
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(17),
      elevation: showShadow ? 8 : 0,
      shadowColor: showShadow ? Colors.black : Colors.transparent,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          minimumSize: const Size(150, 50),
          shape: RoundedRectangleBorder(
            side: borderSide,
            borderRadius: BorderRadius.circular(17),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconAsset),
            const SizedBox(width: 8),
            Text(
              buttonText,
              style: buttonStyle.copyWith(
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
