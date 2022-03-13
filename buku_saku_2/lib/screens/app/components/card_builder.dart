import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:buku_saku_2/screens/app/models/database.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardBuilder extends StatelessWidget {
  // nanti yg Note wajib sifatnya
  final Note? notes;
  final String? date;
  final Function? onLongPressed;
  // final String tag;

  //sementara
  final int? index;
  final bool? pinned;

  CardBuilder({
    Key? key,
    this.index,
    this.notes,
    this.date,
    // required this.tag,
    this.pinned = false,
    this.onLongPressed,
  }) : super(key: key);

  getNoteIcon() {
    if (pinned == true) {
      return SvgPicture.asset("assets/icons/pinned.svg");
    } else if (index == 2) {
      return SvgPicture.asset("assets/icons/important.svg");
    } else if (index == 0) {
      return SvgPicture.asset("assets/icons/checked.svg");
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              notes!.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppConstants.kCardTitleTextStyle,
            ),
            const SizedBox(height: 7),
            Text(
              notes!.body,
              maxLines: index == 1 ? 10 : 5,
              overflow: TextOverflow.ellipsis,
              style: AppConstants.kCardBodyTextStyle,
            ),
            const SizedBox(height: 7),
            Text(
              date!,
              textAlign: TextAlign.left,
              style: AppConstants.kCardDateTextStyle,
            ),
          ],
        ),
        Positioned(
          height: 20,
          width: 20,
          right: 0,
          bottom: 0,
          child: getNoteIcon(),
        ),
      ],
    );
  }
}
