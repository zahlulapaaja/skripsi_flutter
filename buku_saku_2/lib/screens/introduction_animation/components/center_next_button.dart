import 'package:animations/animations.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';

class CenterNextButton extends StatelessWidget {
  final AnimationController animationController;
  final VoidCallback onNextClick;
  const CenterNextButton(
      {Key? key, required this.animationController, required this.onNextClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _topMoveAnimation =
        Tween<Offset>(begin: Offset(0, 5), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.0,
        0.25,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _signUpMoveAnimation =
        Tween<double>(begin: 0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.5,
        0.75,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _loginTextMoveAnimation =
        Tween<Offset>(begin: Offset(0, 5), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.5,
        0.75,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    return Padding(
      padding:
          EdgeInsets.only(bottom: 16 + MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SlideTransition(
            position: _topMoveAnimation,
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) => AnimatedOpacity(
                opacity: animationController.value >= 0.25 &&
                        animationController.value <= 0.5
                    ? 1
                    : 0,
                duration: Duration(milliseconds: 480),
                child: _pageView(),
              ),
            ),
          ),
          SlideTransition(
            position: _topMoveAnimation,
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) => Padding(
                padding: EdgeInsets.only(
                    bottom: 38 - (38 * _signUpMoveAnimation.value)),
                child: Container(
                  height: 58,
                  width: 58 + 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primary,
                  ),
                  child: PageTransitionSwitcher(
                    duration: Duration(milliseconds: 480),
                    reverse: _signUpMoveAnimation.value < 0.6,
                    transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                    ) {
                      return SharedAxisTransition(
                        fillColor: Colors.transparent,
                        child: child,
                        animation: animation,
                        secondaryAnimation: secondaryAnimation,
                        transitionType: SharedAxisTransitionType.vertical,
                      );
                    },
                    child: _signUpMoveAnimation.value > 0.6
                        ? InkWell(
                            key: ValueKey('Sign Up button'),
                            onTap: onNextClick,
                            child: Padding(
                              padding: EdgeInsets.only(left: 16.0, right: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: AppColors.offWhite,
                                      fontSize: AppConstants.kNormalFontSize,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_rounded,
                                      color: Colors.white),
                                ],
                              ),
                            ),
                          )
                        : InkWell(
                            key: ValueKey('next button'),
                            onTap: onNextClick,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'Lanjutkan',
                                style: TextStyle(
                                    color: AppColors.offWhite,
                                    fontSize: AppConstants.kLargeFontSize,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SlideTransition(
              position: _loginTextMoveAnimation,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: AppConstants.kSmallFontSize,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignInScreen.id);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: AppColors.primaryDark,
                        fontSize: AppConstants.kNormalFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pageView() {
    int _selectedIndex = 0;

    if (animationController.value >= 0.6) {
      _selectedIndex = 2;
    } else if (animationController.value >= 0.4) {
      _selectedIndex = 1;
    } else if (animationController.value >= 0.2) {
      _selectedIndex = 0;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < 3; i++)
            Padding(
              padding: const EdgeInsets.all(4),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 480),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color:
                      _selectedIndex == i ? AppColors.primary : AppColors.grey,
                ),
                width: _selectedIndex == i ? 20 : 10,
                height: 10,
              ),
            )
        ],
      ),
    );
  }
}
