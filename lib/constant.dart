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

  static const Color primaryColor = Color(0xff74b06d); // 主色调
  static const Color secondaryColor = Color(0xff9ecf9a); // 辅助色
  static const Color backgroundColor = Color(0xffcde5d3); // 背景色
  static const Color accentColor = Color(0xffffffff);
  static const Color textColor = Color(0xff858585); // 文本颜色
}

class AppText {
  AppText._();

  static const TextStyle aStandard = TextStyle(color:AppColors1.accentColor,fontSize: 16);
  static const TextStyle pStandard = TextStyle(color:AppColors1.primaryColor,fontSize: 16);
  static const TextStyle standard = TextStyle(color:AppColors1.textColor,fontSize: 16);
  static const TextStyle small = TextStyle(color:AppColors1.textColor,fontSize: 12);
  static const TextStyle big = TextStyle(color:AppColors1.textColor,fontSize: 16);
  static const TextStyle aBig = TextStyle(color:AppColors1.accentColor,fontSize: 32);
}

class AppButton{
  static final ButtonStyle button1 = TextButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),
    ),
    foregroundColor:AppColors1.accentColor,
    backgroundColor: AppColors1.secondaryColor, // 设置按钮背景颜色
  );
  static final ButtonStyle button2 = TextButton.styleFrom(
      backgroundColor:AppColors1.primaryColor,
      foregroundColor:AppColors1.accentColor,
      textStyle:AppText.pStandard,
      shape:const RoundedRectangleBorder(borderRadius: BorderRadius.zero)
  );
  static final ButtonStyle button3 = TextButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),
    ),
    backgroundColor: AppColors1.primaryColor, // 设置按钮背景颜色
    foregroundColor:AppColors1.accentColor,
  );
}