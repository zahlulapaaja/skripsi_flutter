import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:buku_saku_2/configs/components.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/sign_in/sign_up_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static const String id = 'sign_in_screen';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // TODO : Membuat firetoast untuk pesan gagal login
  // void fireToast(String message) {
  //   Fluttertoast.showToast(
  //       msg: message,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // }
  // void fireToast2(String message) {
  //   Fluttertoast.showToast(
  //       msg: message,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.green.shade900,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // }

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
                height: 200,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const <Widget>[
                    // Nanti ganti sama gambar
                    Text('LOGO',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                        )),
                    SizedBox(height: 20),
                    Text(
                      'Sign in to continue',
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                    decoration: const BoxDecoration(
                      color: AppColors.offWhite,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        /// Text Fields
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
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
                          buttonTitle: 'SIGN IN',
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
                                SizedBox(width: 10),
                                Text(
                                  'Continue with Google',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: AppConstants.kMediumFontSize,
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
                        text: 'Don’t have an account? ',
                        style: const TextStyle(
                            fontSize: AppConstants.kSmallFontSize,
                            color: AppColors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign Up',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppConstants.kSmallFontSize,
                                color: AppColors.primaryDark),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, SignUpScreen.id);
                                // fireToast2("Ini namanya firetoast");
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
