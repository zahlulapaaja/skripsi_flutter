import 'package:buku_saku_2/configs/colors.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/constants.dart';

class SettingMenuButton extends StatelessWidget {
  const SettingMenuButton({
    Key? key,
    required this.icon,
    this.color,
    required this.title,
    this.subtitle,
    required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;
  final IconData icon;
  final Color? color;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: SizedBox(
        height: 80,
        child: Row(
          children: [
            Container(
              width: 60,
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                icon,
                color: color ?? AppColors.black,
                size: 30,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppConstants.kCardTitleTextStyle,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '$subtitle',
                    textAlign: TextAlign.left,
                    style: AppConstants.kCardBodyTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
