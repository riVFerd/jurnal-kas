import 'package:flutter/material.dart';

class RoundedDivider extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double borderRadius;

  const RoundedDivider({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
