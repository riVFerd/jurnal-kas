import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pretest/presentation/constants/size_constant.dart';

import '../../../domain/entities/user.dart';
import '../../bloc/user/user_cubit.dart';
import '../../constants/color_constant.dart';
import '../../constants/style_constant.dart';
import '../../widgets/button_with_asset.dart';
import '../../widgets/rounded_divider.dart';
import '../login/login_page.dart';

class ProfileEditPage extends StatefulWidget {
  final User user;

  const ProfileEditPage({super.key, required this.user});

  static const routeName = '/profile-edit';

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _nicknameController = TextEditingController();
  final _bioController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _genderController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nikController = TextEditingController();

  @override
  void initState() {
    _nicknameController.text = widget.user.nickname;
    _bioController.text = widget.user.bio;
    _emailController.text = widget.user.email;
    _usernameController.text = widget.user.username;
    _genderController.text = widget.user.genderString;
    _phoneController.text = widget.user.phone ?? '';
    _nikController.text = widget.user.nik ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _bioController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _nikController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    // nickname, bio, email, username should not be empty
    if (_nicknameController.text.isEmpty ||
        _bioController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pastikan tidak ada data penting yang kosong!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    final user = widget.user.copyWith(
      nickname: _nicknameController.text,
      bio: _bioController.text,
      email: _emailController.text,
      username: _usernameController.text,
      gender: _genderController.text == 'Pria' ? Gender.male : Gender.female,
      phone: _phoneController.text,
      nik: _nikController.text,
    );
    BlocProvider.of<UserCubit>(context).updateUser(user);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FBFF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: screenPadding,
          child: Column(
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
              Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/icons/default-avatar.png'),
                    fit: BoxFit.contain,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: lighterBlue,
                    width: 2,
                  ),
                  color: Colors.red,
                ),
                width: 78,
                height: 78,
                clipBehavior: Clip.hardEdge,
              ),
              const Gap(78 / 5),
              TextField(
                style: StyleConstant.bodyBoldStyle.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Nama Panggilan',
                  hintStyle: StyleConstant.bodyPoppinsStyle.copyWith(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                ),
                controller: _nicknameController,
              ),
              TextField(
                style: StyleConstant.bodyPoppinsStyle.copyWith(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Bio',
                  hintStyle: StyleConstant.bodyPoppinsStyle.copyWith(
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                ),
                controller: _bioController,
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
                    _userTextField('Alamat Email', _emailController),
                    _userTextField('Nama Pengguna', _usernameController),
                    const Gap(16),
                    DropdownMenu<Gender>(
                      controller: _genderController,
                      width: MediaQuery.of(context).size.width - 48 * 2,
                      label: Text(
                        'Jenis Kelamin',
                        style: StyleConstant.bodyPoppinsStyle,
                      ),
                      inputDecorationTheme: const InputDecorationTheme(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: blue,
                          ),
                        ),
                      ),
                      textStyle: StyleConstant.bodyPoppinsStyle.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(value: Gender.male, label: 'Pria'),
                        DropdownMenuEntry(value: Gender.female, label: 'Wanita'),
                      ],
                    ),
                    _userTextField(
                      'Nomor Telepon',
                      _phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    _userTextField(
                      'NIK',
                      _nikController,
                      keyboardType: TextInputType.number,
                    ),
                    const Gap(24),
                    Center(
                      child: ElevatedButton(
                        onPressed: _onSubmit,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: blue,
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.all(10),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: darkYellow,
                        ),
                      ),
                    ),
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
          ),
        ),
      ),
    );
  }

  Column _userTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(16),
        TextField(
          style: StyleConstant.bodyPoppinsStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
          keyboardType: keyboardType,
          decoration: InputDecoration(
            label: Text(label),
            labelStyle: StyleConstant.bodyPoppinsStyle.copyWith(
              fontWeight: FontWeight.w500,
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: blue,
              ),
            ),
          ),
          controller: controller,
        ),
      ],
    );
  }
}
