import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pretest/presentation/constants/size_constant.dart';
import 'package:pretest/presentation/pages/profile/profile_edit_page.dart';

import '../../bloc/user/user_cubit.dart';
import '../../constants/color_constant.dart';
import '../../constants/style_constant.dart';
import '../../widgets/button_with_asset.dart';
import '../../widgets/rounded_divider.dart';
import '../login/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FBFF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: screenPadding,
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is! UserAuthenticated) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final user = state.user;
              return Column(
                children: [
                  const RoundedDivider(
                    width: 64,
                    height: 4,
                    color: Colors.grey,
                    borderRadius: 24,
                  ),
                  const Gap(24),
                  Row(
                    children: [
                      const Spacer(),
                      ButtonWithAsset(
                        onPressed: () {},
                        buttonText: 'Pengaturan',
                        iconAsset: 'assets/icons/settings.png',
                        borderRadius: 24,
                        backgroundColor: blue,
                      ),
                      const Spacer(),
                    ],
                  ),
                  const Gap(24),
                  Text(
                    'Profile',
                    style: StyleConstant.subTitleStyle,
                  ),
                  const Gap(16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage('assets/icons/default-avatar.png'),
                                fit: BoxFit.contain,
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFEAE9E9),
                                width: 2,
                              ),
                              color: Colors.red,
                            ),
                            width: 78,
                            height: 78,
                            clipBehavior: Clip.hardEdge,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, ProfileEditPage.routeName,
                                  arguments: user);
                            },
                            child: Text(
                              'Edit Profil',
                              style: StyleConstant.textButtonStyle.copyWith(
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(78 / 5),
                          Text(
                            user.nickname,
                            style: StyleConstant.bodyBoldStyle.copyWith(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const Gap(8),
                          Text(
                            user.bio,
                            style: StyleConstant.bodyPoppinsStyle.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Informasi Akun',
                            style: StyleConstant.bodyBoldStyle,
                          ),
                        ),
                        _userInfo('Alamat Email', user.email),
                        _userInfo('Nama Pengguna', user.username),
                        _userInfo('Jenis Kelamin', user.genderString),
                        _userInfo('Nomor Telepon', user.phone.toString()),
                        _userInfo('NIK', user.nik.toString()),
                      ],
                    ),
                  ),
                  const Gap(24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      BlocProvider.of<UserCubit>(context).signOut();
                      Navigator.pushReplacementNamed(context, LoginPage.routeName);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Berhasil keluar'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    child: Text(
                      'Log Out',
                      style: StyleConstant.bodyBoldStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Column _userInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(16),
        Text(
          label,
          style: StyleConstant.bodyPoppinsStyle.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Gap(4),
        Text(
          value,
          style: StyleConstant.bodyPoppinsStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
