import 'package:flutter/material.dart';
import 'package:pretest/presentation/constants/color_constant.dart';
import 'package:pretest/presentation/constants/size_constant.dart';
import 'package:pretest/presentation/constants/style_constant.dart';
import 'package:pretest/presentation/pages/home/home_page.dart';
import 'package:pretest/presentation/pages/login/signup_page.dart';
import 'package:pretest/presentation/widgets/horizontal_divider_with_text.dart';
import 'package:pretest/presentation/widgets/rounded_input_text.dart';
import 'package:pretest/presentation/widgets/rounded_rectangle_button.dart';

import '../../widgets/button_with_asset.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const routeName = '/login';

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
                  'Masuk',
                  style: StyleConstant.titleStyle,
                ),
                Text(
                  'Halo kamu, lama ga ketemu yaa, gimana kabarmu sekarang?',
                  style: StyleConstant.bodyBoldStyle,
                  textAlign: TextAlign.center,
                ),
                const RoundedInputText(hintText: 'Email'),
                const RoundedInputText(hintText: 'Password'),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Lupa password?',
                    style: StyleConstant.bodyBoldStyle.copyWith(color: lightBlue),
                  ),
                ),
                RoundedRectangleButton(
                  onPressed: () => Navigator.of(context).pushReplacementNamed(HomePage.routeName),
                  label: 'Masuk',
                  backgroundColor: blue,
                ),
                const Text('Atau Sambungkan Dengan'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWithAsset(
                      onPressed: () {},
                      buttonText: 'Facebook',
                      iconAsset: 'assets/icons/facebook.png',
                    ),
                    const SizedBox(width: 16),
                    ButtonWithAsset(
                      onPressed: () {},
                      buttonText: 'Twitter',
                      iconAsset: 'assets/icons/twitter.png',
                      backgroundColor: lightBlue,
                    ),
                  ],
                ),
                const HorizontalDividerWithText(text: 'atau'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Belum punya akun? '),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushNamed(SignupPage.routeName),
                      child: const Text(
                        'Daftar',
                        style: StyleConstant.textButtonStyle,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
