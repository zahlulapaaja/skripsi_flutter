import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/components.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const id = 'reset_password_screen';
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _emailController = TextEditingController();

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
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.black,
              ),
            ),
            Text(
              'Reset Password',
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
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                    'Input your email and let’s help you get your password back'),
                SizedBox(height: 40),
                FormFieldTemplate(
                  headingText: "Input Your Email Address",
                  hintText: "Masukkan email anda...",
                  suffixIcon: Icon(Icons.mail),
                  obsecureText: false,
                  maxLines: 1,
                  border: Border.all(color: AppColors.black),
                  elevation: false,
                  controller: _emailController,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.emailAddress,
                ),
              ],
            ),
            BlueRoundedButton(
              buttonTitle: 'send',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
