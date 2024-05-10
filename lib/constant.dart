import 'package:flutter/material.dart';

enum PageState{
  blank,
  bassel,
  guass,
  guassConersion
}

enum Tools{
  noun,
  geodeticDatum,
  projection
}

class AppColors1 {
  AppColors1._();

  static const Color primaryColor = Color(0xff64b05d); // 主色调
  static const Color secondaryColor = Color(0xffaecf7a); // 辅助色
  static const Color backgroundColor = Color(0xffcde5c8); // 背景色
  static const Color accentColor = Color(0xffffffff);
  static const Color textColor = Color(0xff858585); // 文本颜色
}

class AppText {
  AppText._();

  static const TextStyle aStandard = TextStyle(color:AppColors1.backgroundColor,fontSize: 16);
  static const TextStyle pStandard = TextStyle(color:AppColors1.primaryColor,fontSize: 16);
  static const TextStyle standard = TextStyle(color:AppColors1.textColor,fontSize: 16);
  static const TextStyle small = TextStyle(color:AppColors1.textColor,fontSize: 12);
  static const TextStyle big = TextStyle(color:AppColors1.textColor,fontSize: 16);
}

class AppButton{
  static final ButtonStyle button1 = ElevatedButton.styleFrom(
      backgroundColor:AppColors1.primaryColor,
      foregroundColor:AppColors1.backgroundColor,
      textStyle:AppText.aStandard,
      shape:const RoundedRectangleBorder(borderRadius: BorderRadius.zero)
  );
  static final ButtonStyle button2 = ElevatedButton.styleFrom(
      backgroundColor:AppColors1.backgroundColor,
      foregroundColor:AppColors1.primaryColor,
      textStyle:AppText.pStandard,
      shape:const RoundedRectangleBorder(borderRadius: BorderRadius.zero)
  );
}