import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class BuktiFisikField extends StatelessWidget {
  const BuktiFisikField(
      {Key? key,
      required this.onPressed,
      this.selectedData,
      required this.onDelete})
      : super(key: key);
  final List<PlatformFile>? selectedData;
  final Function() onPressed;
  final Function(String) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FieldLabel(title: 'Bukti Fisik'),
                      Text(
                          '(Anda punya ${selectedData?.length ?? 0} bukti fisik)'),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: onPressed,
                      style: TextButton.styleFrom(
                        // custom warnanya, sesuai jenis file
                        backgroundColor: AppColors.primaryLight,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      child: const Text('Upload'))
                ],
              ),
              GridView.builder(
                padding: const EdgeInsets.only(top: 10),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: selectedData?.length ?? 0,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: Card(
                          child: InkWell(
                            onTap: () {
                              openFile(selectedData![index].path!);
                            },
                            onLongPress: () {
                              // pasang alert konfirmasi
                              print('hapus');
                              onDelete(selectedData![index].name);
                            },
                            child: Center(
                                child:
                                    Text('.${selectedData![index].extension}')),
                          ),
                        ),
                      ),
                      Text(
                        selectedData![index].name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
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
