import 'package:buku_saku_2/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:buku_saku_2/configs/components.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = "sign_up_screen";
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _textController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: AppColors.kGradientBackground,
          ),
          child: ListView(
            children: <Widget>[
              /// Logo
              Container(
                height: 100,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const <Widget>[
                    Text('Selamat Datang!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.offWhite,
                          fontSize: AppConstants.kHugeFontSize,
                        )),
                    SizedBox(height: 10),
                    Text(
                      'Create account to explore',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.offWhite,
                        fontSize: AppConstants.kSmallFontSize,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 20),
                    decoration: const BoxDecoration(
                      color: AppColors.offWhite,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        /// Text Fields
                        FormFieldTemplate(
                          headingText: "Full Name",
                          hintText: "Masukkan nama lengkap anda...",
                          suffixIcon: const SizedBox(),
                          obsecureText: false,
                          maxLines: 1,
                          controller: _textController,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        FormFieldTemplate(
                          headingText: "Email Address",
                          hintText: "Masukkan email anda...",
                          suffixIcon: IconButton(
                              icon: const Icon(Icons.mail), onPressed: () {}),
                          obsecureText: false,
                          maxLines: 1,
                          controller: _emailController,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        FormFieldTemplate(
                          headingText: "Password",
                          hintText: "Masukkan password anda...",
                          suffixIcon: IconButton(
                              icon: const Icon(Icons.visibility),
                              onPressed: () {}),
                          obsecureText: true,
                          maxLines: 1,
                          controller: _passwordController,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.text,
                        ),
                        const SizedBox(height: 16),
                        FormFieldTemplate(
                          headingText: "Konfirmasi Password",
                          hintText: "Masukkan password anda...",
                          suffixIcon: IconButton(
                              icon: const Icon(Icons.visibility),
                              onPressed: () {}),
                          obsecureText: true,
                          maxLines: 1,
                          controller: _passwordController,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.text,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Lupa Password?',
                              style: TextStyle(
                                fontSize: AppConstants.kTinyFontSize,
                                color: AppColors.secondary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        /// Sign In Button
                        BlueRoundedButton(
                          buttonTitle: 'SIGN UP',
                          onPressed: () {},
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            children: const <Widget>[
                              Expanded(
                                child: Divider(
                                  color: AppColors.black,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text('Or'),
                              SizedBox(width: 10),
                              Expanded(
                                child: Divider(
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.offWhite,
                            border:
                                Border.all(width: 1.5, color: AppColors.black),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              // disini logic nya nanti
                            },
                            height: 50,
                            child: Row(
                              children: <Widget>[
                                Image.asset('assets/icons/google.png'),
                                const SizedBox(width: 10),
                                const Text(
                                  'Continue with Google',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: AppConstants.kNormalFontSize,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Arahan Sign Up
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: const TextStyle(
                            fontSize: AppConstants.kSmallFontSize,
                            color: AppColors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign In',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppConstants.kSmallFontSize,
                                color: AppColors.primaryDark),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, SignInScreen.id);
                                // Navigator.pop(context);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
