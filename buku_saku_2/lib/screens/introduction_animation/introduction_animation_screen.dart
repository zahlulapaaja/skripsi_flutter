import 'package:buku_saku_2/screens/sign_in/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/introduction_animation/components/onboarding1.dart';
import 'package:buku_saku_2/screens/introduction_animation/components/splash_view.dart';
import 'package:buku_saku_2/screens/introduction_animation/components/onboarding2.dart';
import 'package:buku_saku_2/screens/introduction_animation/components/top_back_skip_view.dart';
import 'package:buku_saku_2/screens/introduction_animation/components/center_next_button.dart';
import 'package:buku_saku_2/screens/introduction_animation/components/welcome_view.dart';

class IntroductionAnimationScreen extends StatefulWidget {
  static const String id = 'introduction_animation_screen';
  @override
  _IntroductionAnimationScreenState createState() =>
      _IntroductionAnimationScreenState();
}

class _IntroductionAnimationScreenState
    extends State<IntroductionAnimationScreen> with TickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 8));
    _animationController?.animateTo(0.0);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_animationController?.value);
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: ClipRect(
        child: Stack(
          children: [
            SplashView(
              animationController: _animationController!,
            ),
            Onboarding1(
              animationController: _animationController!,
            ),
            Onboarding2(
              animationController: _animationController!,
            ),
            WelcomeView(
              animationController: _animationController!,
            ),
            TopBackSkipView(
              onBackClick: _onBackClick,
              onSkipClick: _onSkipClick,
              animationController: _animationController!,
            ),
            CenterNextButton(
              animationController: _animationController!,
              onNextClick: _onNextClick,
            ),
          ],
        ),
      ),
    );
  }

  // 1 detik bagi 4, karna semuanya ada 4 halaman (termasuk halaman selamat datang)

  void _onSkipClick() {
    _animationController?.animateTo(0.75,
        duration: Duration(milliseconds: 1200));
  }

  void _onBackClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.25) {
      _animationController?.animateTo(0.0);
    } else if (_animationController!.value > 0.25 &&
        _animationController!.value <= 0.5) {
      _animationController?.animateTo(0.25);
    } else if (_animationController!.value > 0.45 &&
        _animationController!.value <= 0.75) {
      _animationController?.animateTo(0.5);
    } else if (_animationController!.value > 0.75 &&
        _animationController!.value <= 1.0) {
      _animationController?.animateTo(0.75);
    }
  }

  void _onNextClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.25) {
      _animationController?.animateTo(0.5);
    } else if (_animationController!.value > 0.25 &&
        _animationController!.value <= 0.5) {
      _animationController?.animateTo(0.75);
    } else if (_animationController!.value > 0.5 &&
        _animationController!.value <= 0.75) {
      _signUpClick();
    }
  }

  void _signUpClick() {
    Navigator.pushNamed(context, SignUpScreen.id);
  }
}
