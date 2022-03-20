import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBarUI extends StatelessWidget {
  // Kalo mau bikin animasi kayak kemaren, bisa ganti jadi stateful
  const AppBarUI({
    Key? key,
    required this.title,
    this.backButton = false,
    this.backButtonCallback,
  }) : super(key: key);
  final String title;
  final bool backButton;
  final Function()? backButtonCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.grey.withOpacity(0.4),
                offset: const Offset(1.1, 1.1),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 8,
                  bottom: 4,
                ),
                child: Stack(
                  children: [
                    if (backButton)
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.chevronLeft,
                          color: AppColors.offWhite,
                          size: AppConstants.kLargeFontSize,
                        ),
                        onPressed: backButtonCallback,
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: AppConstants.kNavHeaderTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
