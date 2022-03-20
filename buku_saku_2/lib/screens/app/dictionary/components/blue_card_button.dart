import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/constants.dart';

class BlueCardButton extends StatelessWidget {
  const BlueCardButton({
    Key? key,
    required this.code,
    required this.title,
    this.subtitle,
    required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;
  final String code;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextButton(
        onPressed: onPressed,
        style: AppConstants.kDictBtnStyle,
        child: SizedBox(
          height: 80,
          child: Row(
            children: [
              Container(
                width: 75,
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  code,
                  textAlign: TextAlign.center,
                  style: AppConstants.kLargeTitleTextStyle,
                ),
              ),
              // SizedBox(width: 50, child: Text('data')),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppConstants.kCardTitleTextStyle,
                    ),
                    Text(
                      '($subtitle)',
                      textAlign: TextAlign.left,
                      style: AppConstants.kCardBodyTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
