import 'package:flutter/material.dart';

class OnBoarding3 extends StatelessWidget {
  final AnimationController animationController;
  const OnBoarding3({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firstHalfAnimation =
        Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.34,
          0.67,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    final _titleAnimation =
        Tween<Offset>(begin: const Offset(2, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.34,
        0.67,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final _imageAnimation =
        Tween<Offset>(begin: const Offset(4, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.34,
        0.67,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: _firstHalfAnimation,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _imageAnimation,
              child: Container(
                constraints:
                    const BoxConstraints(maxWidth: 350, maxHeight: 350),
                child: Image.asset(
                  'assets/introduction/gambar6.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SlideTransition(
              position: _titleAnimation,
              child: const Text(
                "Mulai Pertualangan!",
                style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(left: 64, right: 64, top: 16, bottom: 16),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ultricies vulputate justo, ac posuere odio molestie sed.",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
