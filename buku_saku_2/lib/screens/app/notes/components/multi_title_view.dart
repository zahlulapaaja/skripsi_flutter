import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:flutter/material.dart';

class MultiTitleView extends StatelessWidget {
  final List<String> titleTxt;
  final AnimationController? animationController;
  final Animation<double>? animation;

  const MultiTitleView(
      {Key? key,
      required this.titleTxt,
      this.animationController,
      this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[AppColors.offWhite, Colors.transparent],
            stops: [0.8, 1.5],
          ).createShader(bounds);
        },
        child: SizedBox(
          height: 20,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: titleTxt.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text(
                  titleTxt[index],
                  textAlign: TextAlign.left,
                  style: index == 0
                      ? AppConstants.kTitleActiveTextStyle
                      : AppConstants.kTitleViewTextStyle,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
