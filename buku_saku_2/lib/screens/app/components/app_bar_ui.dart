import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:flutter/material.dart';

class AppBarUI extends StatelessWidget {
  const AppBarUI({
    Key? key,
    required this.title,
    this.leftIconButton,
    this.rightIconButton,
  }) : super(key: key);
  final String title;
  final IconButton? leftIconButton;
  final IconButton? rightIconButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(5.0),
              bottomRight: Radius.circular(5.0),
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
                  children: <Widget>[
                    (leftIconButton != null)
                        ? leftIconButton!
                        : const SizedBox(),
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
                    Positioned(
                      right: 0,
                      child: (rightIconButton != null)
                          ? rightIconButton!
                          : const SizedBox(),
                    )
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
