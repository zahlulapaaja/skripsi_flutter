import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class BuktiFisikField extends StatelessWidget {
  const BuktiFisikField(
      {Key? key, required this.onPressed, this.fileAbc, this.selectedData})
      : super(key: key);
  final List<DocFile>? selectedData;
  final Function() onPressed;
  final List<PlatformFile>? fileAbc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const FieldLabel(title: 'Bukti Fisik'),
              (selectedData != null)
                  ? GridView.builder(
                      padding: const EdgeInsets.only(top: 10),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: selectedData!.length,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            Expanded(
                              child: Card(
                                child: InkWell(
                                  onTap: () {
                                    openFile(selectedData![index].path);
                                  },
                                  child: Center(
                                      child: Text(
                                          'name: ${selectedData![index].extension}')),
                                ),
                              ),
                            ),
                            Text(
                              '${selectedData![index].namaFile}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        );
                      },
                    )
                  : const Center(child: Text('bukti belum ada')),
            ],
          ),
          ElevatedButton(onPressed: onPressed, child: const Text('Add Item'))
        ],
      ),
    );
  }

  void openFiles(List<PlatformFile> files) {
    // bikin listview atau gridview disini
  }

  void openFile(String path) {
    OpenFile.open(path);
  }
}
