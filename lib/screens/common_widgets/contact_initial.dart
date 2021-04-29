import 'dart:math';

import 'package:atsign_atmosphere_pro/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:atsign_atmosphere_pro/services/size_config.dart';

class ContactInitial extends StatelessWidget {
  final double size;
  final String initials;

  const ContactInitial({Key key, this.size = 40, this.initials})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Random r = Random();
    return Container(
      height: size.toHeight,
      width: size.toHeight,

      decoration: BoxDecoration(
        color:
            Color.fromARGB(255, r.nextInt(255), r.nextInt(255), r.nextInt(255)),
        borderRadius: BorderRadius.circular(size.toHeight * 2),
      ),
      // border: Border.all(width: 0.5, color: ColorConstants.fontSecondary)),
      child: Center(
        child: Text(
          initials.toUpperCase(),
          style: CustomTextStyles.whiteBold(size: (size ~/ 3)),
        ),
      ),
    );
  }
}
