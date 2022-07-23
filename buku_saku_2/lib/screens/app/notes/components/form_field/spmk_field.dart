import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class SPMKField extends StatelessWidget {
  const SPMKField(
      {Key? key,
      required this.onPressed,
      this.selectedData,
      required this.onDelete})
      : super(key: key);
  final PlatformFile? selectedData;
  final Function() onPressed;
  final Function(PlatformFile) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FieldLabel(title: 'SMPK'),
                  if (selectedData != null)
                    const Text(
                      '(SPMK berhasil diupload)',
                      style: TextStyle(
                        fontFamily: AppConstants.fontName,
                        color: AppColors.grey,
                        fontSize: AppConstants.kSmallFontSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
              ElevatedButton(
                  onPressed: onPressed,
                  style: TextButton.styleFrom(
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
          if (selectedData != null)
            Container(
              height: 110,
              width: 100,
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Card(
                      color: Colors.blue,
                      child: InkWell(
                        onTap: () {
                          OpenFile.open(selectedData!.path!);
                        },
                        onLongPress: () async {
                          var result = await showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Hapus File'),
                              content: const Text(
                                  'Anda yakin ingin menghapus file ini ?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Tidak'),
                                  child: const Text('Tidak'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'Ya'),
                                  child: const Text('Ya'),
                                ),
                              ],
                            ),
                          );

                          if (result == 'Ya') {
                            onDelete(selectedData!);
                          }
                        },
                        child:
                            Center(child: Text('.${selectedData!.extension}')),
                      ),
                    ),
                  ),
                  Text(
                    selectedData!.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Color? getCardColor(String extension) {
    switch (extension) {
      case 'pdf':
        return AppColors.beigeDark;
      case 'docx':
        return AppColors.beigeDark;
      case 'png':
        return AppColors.info;
      case 'jpg':
        return AppColors.info;
      case 'xlsx':
        return AppColors.success;
      case 'csv':
        return AppColors.success;
      default:
        return AppColors.lightGrey;
    }
  }
}
