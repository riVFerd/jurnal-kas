import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretest/presentation/constants/size_constant.dart';
import 'package:pretest/presentation/pages/login/login_page.dart';
import 'package:pretest/presentation/widgets/button_with_asset.dart';

import '../../bloc/user/user_cubit.dart';
import '../../constants/color_constant.dart';
import '../../constants/style_constant.dart';
import '../../widgets/horizontal_divider_with_text.dart';
import '../../widgets/rounded_input_text.dart';
import '../../widgets/rounded_rectangle_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  static const routeName = '/signup';

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _onSubmit() async {
    if (_isLoading) return;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email, password, dan konfirmasi password tidak boleh kosong'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password dan konfirmasi password tidak sama'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    setState(() => _isLoading = true);
    await BlocProvider.of<UserCubit>(context).createUserWithEmailAndPassword(email, password);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
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
                    RoundedInputText(
                      hintText: 'Email',
                      controller: _emailController,
                    ),
                    RoundedInputText(
                      hintText: 'Password',
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    RoundedInputText(
                      hintText: 'Konfirmasi Password',
                      controller: _confirmPasswordController,
                      obscureText: true,
                    ),
                    RoundedRectangleButton(
                      onPressed: _onSubmit,
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
          Visibility(
            visible: _isLoading,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
