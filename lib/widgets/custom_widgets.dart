import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

Widget myText({text, style, textAlign}) {
  return Text(
    text,
    style: style,
    textAlign: textAlign,
    overflow: TextOverflow.ellipsis,
  );
}

Widget elevatedButton({text, required VoidCallback onpress}) {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AppColors.blue),
    ),
    onPressed: onpress,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget socialAppsIcons({text, Function? onPressed}) {
  return InkWell(
    onTap: () => onPressed!(),
    child: Container(
      margin: EdgeInsets.all(10),
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(text),
        ),
      ),
    ),
  );
}
