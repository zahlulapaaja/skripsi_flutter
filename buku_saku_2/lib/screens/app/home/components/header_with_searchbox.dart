import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/models/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HeaderWithSearchbox extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;
  TextEditingController controller = TextEditingController();

  HeaderWithSearchbox({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(bottom: 20 * 1.5),
      height: size.height * 0.2,
      child: Stack(
        children: <Widget>[
          Container(
            height: size.height * 0.2 - 27,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(36.0),
                bottomRight: Radius.circular(36.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppColors.grey.withOpacity(0.2),
                  offset: const Offset(1.1, 1.0),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            'Buku Saku Prakom',
                            textAlign: TextAlign.left,
                            style: AppConstants.kHeaderTextStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Center(
                          child: Image.asset(
                            "assets/icons/logo.png",
                            width: 80,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
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
            ),
          ),
        ],
      ),
    );
  }
}
