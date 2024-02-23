import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretest/presentation/bloc/dompet/dompet_cubit.dart';
import 'package:pretest/presentation/bloc/transaction/transaction_cubit.dart';
import 'package:pretest/presentation/constants/color_constant.dart';
import 'package:pretest/presentation/constants/size_constant.dart';
import 'package:pretest/presentation/constants/style_constant.dart';
import 'package:pretest/presentation/pages/dashboard/dashboard_page.dart';
import 'package:pretest/presentation/pages/login/signup_page.dart';
import 'package:pretest/presentation/widgets/horizontal_divider_with_text.dart';
import 'package:pretest/presentation/widgets/rounded_input_text.dart';
import 'package:pretest/presentation/widgets/rounded_rectangle_button.dart';

import '../../bloc/category/category_cubit.dart';
import '../../bloc/user/user_cubit.dart';
import '../../widgets/button_with_asset.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _onSubmit() async {
    if (_isLoading) return;
    final email = _emailController.text;
    final password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email dan password tidak boleh kosong'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    setState(() => _isLoading = true);
    await BlocProvider.of<UserCubit>(context).signInWithEmailAndPassword(email, password);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is UserAuthenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Welcome back, ${state.user.username}'),
              backgroundColor: lightBlue,
            ),
          );

          // Reset all state before navigate to dashboard
          BlocProvider.of<CategoryCubit>(context).resetState();
          BlocProvider.of<DompetCubit>(context).resetState();
          BlocProvider.of<TransactionCubit>(context).resetState();
          Navigator.of(context).pushReplacementNamed(DashboardPage.routeName);
        }
      },
      child: Scaffold(
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
                        'Masuk',
                        style: StyleConstant.titleStyle,
                      ),
                      Text(
                        'Halo kamu, lama ga ketemu yaa, gimana kabarmu sekarang?',
                        style: StyleConstant.bodyBoldStyle,
                        textAlign: TextAlign.center,
                      ),
                      RoundedInputText(hintText: 'Email', controller: _emailController),
                      RoundedInputText(
                          hintText: 'Password', controller: _passwordController, obscureText: true),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Lupa password?',
                          style: StyleConstant.bodyBoldStyle.copyWith(color: lightBlue),
                        ),
                      ),
                      RoundedRectangleButton(
                        onPressed: _onSubmit,
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
                          const Text('Belum punya akun? '),
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
      ),
    );
  }
}
