import 'package:flutter/material.dart';
import 'package:pretest/presentation/constants/size_constant.dart';
import 'package:pretest/presentation/pages/login/login_page.dart';
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
            padding: screenPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Daftar',
                  style: StyleConstant.titleStyle,
                ),
                Text(
                  'Yuk daftar dulu disini, biar bisa nyobain fitur-fitur kami!',
                  style: StyleConstant.bodyBoldStyle,
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
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
                    },
                    child: const Text(
                      'Sudah punya akun? Masuk',
                      style: StyleConstant.textButtonStyle,
                    ),
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
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
