import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  final AnimationController animationController;

  const SplashView({Key? key, required this.animationController})
      : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}
// TODO : Sederhanakan lagi halaman yang ini, sesuai wireframe

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    final _introductionanimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0.0, -1.0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.0,
        0.25,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: _introductionanimation,
      child: SingleChildScrollView(
        child: Container(
          color: AppColors.primary,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset('assets/icons/logo_buku.png'),
              ),
              SizedBox(
                height: 48,
              ),
              InkWell(
                onTap: () {
                  widget.animationController.animateTo(0.25);
                },
                child: Container(
                  height: 58,
                  padding: EdgeInsets.only(
                    left: 96.0,
                    right: 96.0,
                    top: 16,
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(38.0),
                    color: AppColors.primaryLight,
                  ),
                  child: Text(
                    "Mulai",
                    style: TextStyle(
                      fontSize: AppConstants.kLargeFontSize,
                      fontWeight: FontWeight.w500,
                      color: AppColors.offWhite,
                    ),
                  ),
                ),
              ),
              Image(
                image: AssetImage('assets/introduction/splash.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
