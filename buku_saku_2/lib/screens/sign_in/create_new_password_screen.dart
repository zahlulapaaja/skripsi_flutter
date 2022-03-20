import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/components.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:flutter/material.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  static const id = 'create_new_password_screen';
  const CreateNewPasswordScreen({Key? key}) : super(key: key);

  @override
  _CreateNewPasswordScreenState createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final _passController = TextEditingController();
  final _confPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.offWhite,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.black,
              ),
            ),
            const Text(
              'Create New Password',
              style: TextStyle(
                color: AppColors.black,
                fontSize: AppConstants.kLargeFontSize,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                    'Your new password must be different from previous used password'),
                const SizedBox(height: 40),
                FormFieldTemplate(
                  headingText: "New Password",
                  hintText: "Masukkan password baru...",
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.visibility), onPressed: () {}),
                  obsecureText: true,
                  maxLines: 1,
                  border: Border.all(color: AppColors.black),
                  elevation: false,
                  controller: _passController,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                FormFieldTemplate(
                  headingText: "Confirm Password",
                  hintText: "Konfirmasi password baru...",
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.visibility_off), onPressed: () {}),
                  obsecureText: false,
                  maxLines: 1,
                  border: Border.all(color: AppColors.black),
                  elevation: false,
                  controller: _confPassController,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.text,
                ),
              ],
            ),
            BlueRoundedButton(
              buttonTitle: 'Reset Password',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
