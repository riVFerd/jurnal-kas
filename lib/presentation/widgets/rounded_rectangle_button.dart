import 'package:flutter/material.dart';

class RoundedRectangleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color backgroundColor;
  final double minWidth;
  final double height;
  final double borderRadius;
  final TextStyle textStyle;

  const RoundedRectangleButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.backgroundColor = Colors.blue,
    this.minWidth = double.infinity,
    this.height = 50,
    this.borderRadius = 10,
    this.textStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(minWidth, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Text(label, style: textStyle),
    );
  }
}
