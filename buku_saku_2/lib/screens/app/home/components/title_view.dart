import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/models/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TitleView extends StatelessWidget {
  final String titleTxt;
  final bool detailBtn;
  final Function()? onTap;

  const TitleView({
    Key? key,
    this.titleTxt = "",
    this.detailBtn = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.watch<NotesProvider>().isQueryExist == false) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                titleTxt,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontFamily: AppConstants.fontName,
                  color: AppColors.grey,
                  fontSize: AppConstants.kNormalFontSize,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Opacity(
              opacity: detailBtn ? 1 : 0,
              child: InkWell(
                highlightColor: Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                onTap: onTap ?? () {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: const Text(
                    'Details',
                    textAlign: TextAlign.center,
                    style: AppConstants.kSmallWhiteTextStyle,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
