import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:buku_saku_2/screens/app/models/notes_provider.dart';
import 'package:buku_saku_2/screens/app/components/card_builder.dart';
import 'package:provider/provider.dart';

class PinnedCardListView extends StatelessWidget {
  const PinnedCardListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.watch<NotesProvider>().notes,
        builder: (context, AsyncSnapshot<List<Note>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              physics: const ScrollPhysics(), // to enable GridView's scrolling
              shrinkWrap: true, // You won't see infinite size error
              itemBuilder: (context, index) {
                return Card(
                  color: AppColors.beige,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ClipPath(
                    clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                            left: BorderSide(
                                color: AppColors.beigeDark, width: 7)),
                        color: Colors.transparent,
                      ),
                      padding: const EdgeInsets.all(20.0),
                      alignment: Alignment.topLeft,
                      child: CardBuilder(
                        notes: snapshot.data![index],
                        pinned: true,
                        date: '22 Nov 2021',
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('ERROR'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

// shaderCallback: (Rect bounds) {
// return LinearGradient(
// begin: Alignment.centerLeft,
// end: Alignment.centerRight,
// colors: <Color>[AppColors.offWhite, Colors.transparent],
// stops: [0.8, 1.0],
// ).createShader(bounds);
