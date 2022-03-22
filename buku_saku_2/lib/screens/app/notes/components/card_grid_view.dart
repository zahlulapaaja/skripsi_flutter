import 'package:buku_saku_2/screens/app/notes/components/card_builder.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:buku_saku_2/screens/app/models/notes_provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class CardGridView extends StatelessWidget {
  const CardGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.watch<NotesProvider>().notes,
      builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('error fetching data'));
        } else if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text('Notes Still Empty'));
          }
          return MasonryGridView.count(
            padding: const EdgeInsets.only(top: 10),
            crossAxisCount: 2,
            itemCount: snapshot.data!.length,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
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
                          left:
                              BorderSide(color: AppColors.beigeDark, width: 7)),
                      color: Colors.transparent,
                    ),
                    padding: const EdgeInsets.all(20.0),
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onLongPress: () async {
                        var result = await showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Hapus Catatan'),
                            content: const Text('Hapus ga ni ??'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );

                        if (result == 'OK') {
                          context
                              .read<NotesProvider>()
                              .deleteNote(snapshot.data![index].id!);
                        }
                      },
                      child: CardBuilder(
                        notes: snapshot.data![index],
                        date: '22 Nov 2021',
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
