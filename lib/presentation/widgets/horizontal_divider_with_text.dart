import 'package:flutter/material.dart';

class HorizontalDividerWithText extends StatelessWidget {
  final String text;
  final double height;
  final Color color;

  const HorizontalDividerWithText({
    super.key,
    required this.text,
    this.height = 2,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Container(
            height: height,
            color: color,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
        Flexible(
          child: Container(
            height: height,
            color: color,
          ),
        ),
      ],
    );
  }
}
