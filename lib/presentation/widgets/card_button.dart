import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;
  final double borderRadius;
  final Color backgroundColor;
  final Color? splashColor;

  const CardButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.borderRadius = 17.0,
    this.backgroundColor = Colors.white,
    this.splashColor,
  });

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: 1,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        borderOnForeground: true,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
          splashColor: splashColor,
          child: Container(
            width: MediaQuery.of(context).size.width / 3 - 16,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Image.asset(icon, width: 48, height: 48),
                const SizedBox(height: 8),
                Text(title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
