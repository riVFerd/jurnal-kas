import 'package:flutter/material.dart';
import 'package:pretest/presentation/constants/color_constant.dart';
import 'package:pretest/presentation/constants/style_constant.dart';

class SelectableTab extends StatelessWidget {
  final bool isSelected;
  final String label;
  final String iconPath;
  final VoidCallback onTap;
  final Color selectedBackgroundColor;
  final Color backgroundColor;
  final Color selectedTextColor;
  final Color textColor;
  final double borderRadius;
  final double size;
  final double selectedSize;
  final double iconScale;
  final double iconSize;

  const SelectableTab({
    super.key,
    required this.isSelected,
    required this.label,
    required this.iconPath,
    required this.onTap,
    this.selectedBackgroundColor = blue,
    this.selectedTextColor = Colors.white,
    this.borderRadius = 24,
    this.size = 50,
    this.selectedSize = 150,
    this.iconScale = 2,
    this.iconSize = 32,
    this.backgroundColor = Colors.transparent,
    this.textColor = blue,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isSelected ? selectedBackgroundColor : backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        constraints: BoxConstraints(
          minWidth: isSelected ? selectedSize : size,
          minHeight: size,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              color: isSelected ? selectedTextColor : textColor,
              scale: iconScale,
              height: iconSize,
            ),
            Visibility(
              visible: isSelected,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  label,
                  style: StyleConstant.bodyStyle.copyWith(
                    color: selectedTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
