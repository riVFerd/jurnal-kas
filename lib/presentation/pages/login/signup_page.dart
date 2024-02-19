import 'package:flutter/material.dart';
import 'package:pretest/presentation/constants/size_constant.dart';
import 'package:pretest/presentation/widgets/button_with_asset.dart';

import '../../constants/color_constant.dart';
import '../../constants/style_constant.dart';
import '../../widgets/horizontal_divider_with_text.dart';
import '../../widgets/rounded_input_text.dart';
import '../../widgets/rounded_rectangle_button.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            constraints: screenHeightConstraint,
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Daftar',
                  style: titleStyle,
                ),
                const Text(
                  'Yuk daftar dulu disini, biar bisa nyobain fitur-fitur kami!',
                  style: bodyBoldStyle,
                  textAlign: TextAlign.center,
                ),
                const RoundedInputText(hintText: 'Email'),
                const RoundedInputText(hintText: 'Password'),
                const RoundedInputText(hintText: 'Konfirmasi Password'),
                RoundedRectangleButton(
                  onPressed: () {},
                  label: 'Daftar',
                  backgroundColor: blue,
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Sudah punya akun?',
                    style: textButtonStyle,
                  ),
                ),
                const HorizontalDividerWithText(text: 'atau'),
                ButtonWithAsset(
                  onPressed: () {},
                  buttonText: 'Continue with Google',
                  iconAsset: 'assets/icons/google.png',
                  backgroundColor: Colors.white,
                  showShadow: false,
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                  textColor: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
