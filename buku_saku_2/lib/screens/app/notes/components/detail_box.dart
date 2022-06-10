import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:flutter/material.dart';

class DetailBox extends StatelessWidget {
  const DetailBox({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 10.0),
      child: Container(
        padding: const EdgeInsets.only(top: 14, right: 10, bottom: 0, left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0),
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, children: children),
      ),
    );
  }
}

class WhiteBoxBody extends StatelessWidget {
  const WhiteBoxBody({
    Key? key,
    required this.title,
    this.body,
    this.widgetBody,
  }) : super(key: key);

  final String title;
  final Widget? widgetBody;
  final String? body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: AppConstants.fontName,
            color: AppColors.grey.withOpacity(0.8),
            fontSize: AppConstants.kSmallFontSize - 0.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 3),
        (body == null)
            ? widgetBody!
            : Text(
                body!,
                style: AppConstants.kDetailCardTextStyle,
              ),
        const SizedBox(height: 16),
      ],
    );
  }
}
