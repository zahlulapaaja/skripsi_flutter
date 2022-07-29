import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/models/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteSearchBox extends StatelessWidget {
  NoteSearchBox({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (context.read<NotesProvider>().isQueryExist) {
      controller.text = context.read<NotesProvider>().query;
      controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
    }

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 54,
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        border: Border.all(width: 1.5, color: AppColors.lightBlack),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 10,
            color: AppColors.primary.withOpacity(0.25),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: (value) {
                context.read<NotesProvider>().setQuery = value;
              },
              autocorrect: false,
              enableSuggestions: false,
              decoration: AppConstants.kSearchboxDecoration,
              style: AppConstants.kTextFieldTextStyle,
            ),
          ),
          if (context.watch<NotesProvider>().isQueryExist)
            IconButton(
              onPressed: () {
                controller.text = '';
                context.read<NotesProvider>().setQuery = '';
              },
              icon: const Icon(
                Icons.close,
                size: 20,
              ),
            ),
          Image.asset("assets/icons/search.png"),
        ],
      ),
    );
  }
}
