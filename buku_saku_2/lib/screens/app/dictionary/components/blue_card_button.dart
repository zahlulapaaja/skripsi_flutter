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
        child: Container(
          constraints: const BoxConstraints(minHeight: 80),
          child: Row(
            children: [
              Container(
                constraints: const BoxConstraints(minWidth: 75),
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  code,
                  textAlign: TextAlign.center,
                  style: AppConstants.kLargeTitleTextStyle,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        title,
                        style: AppConstants.kCardTitleTextStyle,
                      ),
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
