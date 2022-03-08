import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:flutter_svg/svg.dart';

class CardBuilder extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  // final String tag;

  //sementara
  final int? index;
  final bool? pinned;

  const CardBuilder(
      {Key? key,
      this.index,
      required this.title,
      required this.description,
      required this.date,
      // required this.tag,
      this.pinned = false})
      : super(key: key);

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
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppConstants.kCardTitleTextStyle,
            ),
            const SizedBox(height: 7),
            Text(
              description,
              maxLines: index == 1 ? 10 : 5,
              overflow: TextOverflow.ellipsis,
              style: AppConstants.kCardBodyTextStyle,
            ),
            const SizedBox(height: 7),
            Text(
              date,
              textAlign: TextAlign.left,
              style: AppConstants.kCardDateTextStyle,
            ),
          ],
        ),
        Positioned(
          top: -20,
          right: -25,
          child: FloatingActionButton(
            heroTag: null,
            onPressed: () {
              // ignore: avoid_print
              print("tombol ditekan");
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: SvgPicture.asset("assets/icons/three-dots.svg"),
          ),
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
