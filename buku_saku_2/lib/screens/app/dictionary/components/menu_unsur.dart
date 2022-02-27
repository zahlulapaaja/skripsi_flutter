import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/components/card_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuUnsur extends StatelessWidget {
  const MenuUnsur({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 14.0),
      itemCount: 7,
      physics: const ScrollPhysics(), // to enable GridView's scrolling
      shrinkWrap: true, // You won't see infinite size error
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TextButton(
            onPressed: () {},
            style: AppConstants.kDictBtnStyle,
            child: Container(
              height: 80,
              child: Row(
                children: [
                  Container(
                    width: 75,
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'I.A.${index + 1}',
                      textAlign: TextAlign.left,
                      style: AppConstants.kLargeTitleTextStyle,
                    ),
                  ),
                  // SizedBox(width: 50, child: Text('data')),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          index == 1
                              ? ''
                              : 'tata kelola dan tata laksana teknologi informasi',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppConstants.kCardTitleTextStyle,
                        ),
                        Text(
                          '(12 Sub Unsur)',
                          textAlign: TextAlign.left,
                          style: AppConstants.kCardBodyTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
