import 'package:buku_saku_2/configs/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20 * 2,
        right: 20 * 2,
        bottom: 20,
      ),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 35,
            color: AppColors.primary.withOpacity(0.38),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Image.asset('assets/icons/user-icon.png'),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset('assets/icons/user-icon.png'),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset(
              'assets/icons/user-icon.png',
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
