import 'package:buku_saku_2/screens/app/app_screen.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/introduction_animation/components/onboarding1.dart';
import 'package:buku_saku_2/screens/introduction_animation/components/onboarding2.dart';
import 'package:buku_saku_2/screens/introduction_animation/components/top_back_skip_view.dart';
import 'package:buku_saku_2/screens/introduction_animation/components/center_next_button.dart';
import 'package:buku_saku_2/screens/introduction_animation/components/onboarding3.dart';
import 'package:get_storage/get_storage.dart';

class IntroductionAnimationScreen extends StatefulWidget {
  static const String id = 'introduction_animation_screen';

  const IntroductionAnimationScreen({Key? key}) : super(key: key);
  @override
  _IntroductionAnimationScreenState createState() =>
      _IntroductionAnimationScreenState();
}

class _IntroductionAnimationScreenState
    extends State<IntroductionAnimationScreen> with TickerProviderStateMixin {
  AnimationController? _animationController;
  final introData = GetStorage();

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 8));
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
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: ClipRect(
        child: Stack(
          children: [
            OnBoarding1(
              animationController: _animationController!,
            ),
            OnBoarding2(
              animationController: _animationController!,
            ),
            OnBoarding3(
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
              onConnectClick: () {},
            ),
          ],
        ),
      ),
    );
  }

  // 1 detik bagi 3, karna semuanya ada 3 halaman

  void _onSkipClick() {
    _EndIntroScreen(context, AppScreen.id);
  }

  void _onBackClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.34) {
      _animationController?.animateTo(0.0);
    } else if (_animationController!.value > 0.34 &&
        _animationController!.value <= 0.67) {
      _animationController?.animateTo(0.34);
    }
  }

  void _onNextClick() {
    if (_animationController!.value < 0.34) {
      _animationController?.animateTo(0.34);
    } else if (_animationController!.value >= 0.34 &&
        _animationController!.value < 0.67) {
      _animationController?.animateTo(0.67);
    } else if (_animationController!.value >= 0.67) {
      _EndIntroScreen(context, AppScreen.id);
    }
  }

  void _EndIntroScreen(context, String routeName) {
    Navigator.pop(context);
    Navigator.pushNamed(context, routeName);
    introData.write("displayed", true);
  }
}
