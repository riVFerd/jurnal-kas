import 'package:flutter/material.dart';
import 'package:pretest/presentation/constants/style_constant.dart';

class CardButton extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;
  final double borderRadius;
  final Color backgroundColor;
  final Color? splashColor;
  final double iconSize;

  const CardButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.borderRadius = 17.0,
    this.backgroundColor = Colors.white,
    this.splashColor,
    this.iconSize = 48,
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
            width: MediaQuery.of(context).size.width / 3 - 32,
            height: 100,
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(icon, width: iconSize, height: iconSize),
                const SizedBox(height: 8),
                if (title != '')
                  Text(
                    title,
                    style: StyleConstant.bodyStyle.copyWith(color: Colors.black, fontSize: 11),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
