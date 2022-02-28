import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuKamus extends StatelessWidget {
  const MenuKamus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 150,
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                onPressed: () {},
                style: AppConstants.kDictBtnStyle,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/icons/office-briefcase.svg',
                      width: 50,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Prakom Terampil',
                      textAlign: TextAlign.center,
                      style: AppConstants.kCardTitleTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: SizedBox(
              height: 150,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.info,
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/icons/office-briefcase.svg',
                      width: 50,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Prakom Ahli',
                      textAlign: TextAlign.center,
                      style: AppConstants.kCardTitleTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}