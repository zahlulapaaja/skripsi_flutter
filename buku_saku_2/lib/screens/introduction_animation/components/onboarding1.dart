import 'package:flutter/material.dart';

class OnBoarding1 extends StatelessWidget {
  final AnimationController animationController;

  const OnBoarding1({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _secondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-1, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.0,
          0.34,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final _imageAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-4, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.0,
          0.34,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    final _titleAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-2, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.0,
          0.34,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    return SlideTransition(
      position: _secondHalfAnimation,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _imageAnimation,
              child: Container(
                constraints:
                    const BoxConstraints(maxWidth: 350, maxHeight: 250),
                child: Image.asset(
                  'assets/introduction/gambar1.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 30),
            SlideTransition(
              position: _titleAnimation,
              child: const Text(
                "Selamat Datang!",
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
