import 'package:animations/animations.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';

class CenterNextButton extends StatelessWidget {
  final AnimationController animationController;
  final VoidCallback onNextClick;
  final VoidCallback onConnectClick;
  const CenterNextButton({
    Key? key,
    required this.animationController,
    required this.onNextClick,
    required this.onConnectClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _signUpMoveAnimation =
        Tween<double>(begin: 0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.34,
        0.67,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    // final _loginTextMoveAnimation =
    //     Tween<Offset>(begin: const Offset(0, 5), end: const Offset(0, 0))
    //         .animate(CurvedAnimation(
    //   parent: animationController,
    //   curve: const Interval(
    //     0.34,
    //     0.67,
    //     curve: Curves.fastOutSlowIn,
    //   ),
    // ));

    return Padding(
      padding:
          EdgeInsets.only(bottom: 16 + MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) => Column(
              children: [
                _pageView(),
                Padding(
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
                      duration: const Duration(milliseconds: 480),
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
                              key: const ValueKey('Sign Up button'),
                              onTap: onNextClick,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'Mulai Sekarang',
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
                              key: const ValueKey('next button'),
                              onTap: onNextClick,
                              child: const Padding(
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
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 8),
          //   child: SlideTransition(
          //     position: _loginTextMoveAnimation,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         const Text(
          //           'Already have an account? ',
          //           style: TextStyle(
          //             color: AppColors.black,
          //             fontSize: AppConstants.kSmallFontSize,
          //             fontWeight: FontWeight.normal,
          //           ),
          //         ),
          //         TextButton(
          //           onPressed: onConnectClick,
          //           child: const Text(
          //             'Login',
          //             style: TextStyle(
          //               color: AppColors.primaryDark,
          //               fontSize: AppConstants.kNormalFontSize,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _pageView() {
    int _selectedIndex = 0;

    if (animationController.value > 0.66) {
      _selectedIndex = 2;
    } else if (animationController.value > 0.33) {
      _selectedIndex = 1;
    } else if (animationController.value >= 0.0) {
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
                duration: const Duration(milliseconds: 480),
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
