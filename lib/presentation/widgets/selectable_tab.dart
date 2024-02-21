import 'package:flutter/material.dart';
import 'package:pretest/presentation/constants/color_constant.dart';

class SelectableTab extends StatelessWidget {
  final bool isSelected;
  final String label;
  final String iconPath;
  final VoidCallback onTap;

  const SelectableTab({
    super.key,
    required this.isSelected,
    required this.label,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isSelected ? blue : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        constraints: BoxConstraints(
          minWidth: isSelected ? 150 : 50,
          minHeight: 50,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              color: isSelected ? Colors.white : blue,
              scale: 2,
              height: 32,
            ),
            Visibility(
              visible: isSelected,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
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
