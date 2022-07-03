import 'package:buku_saku_2/configs/colors.dart';
import 'package:flutter/material.dart';

class TopBackSkipView extends StatelessWidget {
  final AnimationController animationController;
  final VoidCallback onBackClick;
  final VoidCallback onSkipClick;

  const TopBackSkipView({
    Key? key,
    required this.onBackClick,
    required this.onSkipClick,
    required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _backAnimation =
        Tween<Offset>(begin: const Offset(-2, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _skipAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(2, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.2,
        .67,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: SizedBox(
        height: 58,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SlideTransition(
                position: _backAnimation,
                child: IconButton(
                  onPressed: onBackClick,
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ),
              SlideTransition(
                position: _skipAnimation,
                child: TextButton(
                  onPressed: onSkipClick,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
