import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:flutter_svg/svg.dart';

class CardBuilder extends StatelessWidget {
  // nanti yg Note wajib sifatnya
  final Note notes;
  final String? date;
  final Function? onLongPressed;
  // final String tag;

  //sementara
  final int? index;
  final bool? pinned;

  // TODO : Tambah atribut yang lengkap disini
  // Dan bikin kondisi, kalo lagi dalam kondisi edit, ada tambahan input kayak status, dsb

  const CardBuilder({
    Key? key,
    required this.notes,
    this.index,
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
              notes.judul,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppConstants.kCardTitleTextStyle,
            ),
            const SizedBox(height: 7),
            Text(
              notes.uraian,
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
