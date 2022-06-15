import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
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
                        '(Anda punya ${selectedData?.length ?? 0} bukti fisik)',
                        style: const TextStyle(
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 100,
                  crossAxisCount: 3,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 15,
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
                          color: getCardColor(selectedData![index].extension!),
                          child: InkWell(
                            onTap: () {
                              OpenFile.open(selectedData![index].path!);
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
                                      onPressed: () =>
                                          Navigator.pop(context, 'Ya'),
                                      child: const Text('Ya'),
                                    ),
                                  ],
                                ),
                              );

                              if (result == 'Ya') {
                                onDelete(selectedData![index].name);
                              }
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
