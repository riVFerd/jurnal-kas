import 'package:flutter/material.dart';
import 'package:pretest/presentation/constants/style_constant.dart';

import '../constants/color_constant.dart';

class NumpadWidget extends StatelessWidget {
  final Function(String) onNumberPressed;
  final Function() onDeletePressed;

  const NumpadWidget({super.key, required this.onNumberPressed, required this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberButton('7'),
            _buildNumberButton('8'),
            _buildNumberButton('9'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberButton('4'),
            _buildNumberButton('5'),
            _buildNumberButton('6'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberButton('1'),
            _buildNumberButton('2'),
            _buildNumberButton('3'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberButton('.'),
            _buildNumberButton('0'),
            _buildDeleteButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildNumberButton(String number, {bool disabled = false}) {
    return ElevatedButton(
      onPressed: () {
        if (disabled) return;
        onNumberPressed(number);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      child: Text(
        number,
        style: StyleConstant.bodyPoppinsStyle.copyWith(
          color: blue,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return ElevatedButton(
      onPressed: onDeletePressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      child: const Icon(
        Icons.backspace,
        color: blue,
        size: 16,
      ),
    );
  }
}
