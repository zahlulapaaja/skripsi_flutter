import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:flutter/material.dart';

class BlueContainer extends StatelessWidget {
  const BlueContainer({Key? key, this.title, required this.body})
      : super(key: key);
  final String? title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          title != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                  child: Text(
                    title!,
                    style: AppConstants.kDictTitleTextStyle,
                  ),
                )
              : const SizedBox(),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: AppColors.info,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: body,
          ),
        ],
      ),
    );
  }
}
