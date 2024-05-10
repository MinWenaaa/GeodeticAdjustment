import 'package:flutter/material.dart';
import 'package:geodetic_adjustment/geodetic_adjustment.dart';
import 'package:geodetic_adjustment/constant.dart';
import 'package:geodetic_adjustment/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "大地测量计算工具",
      color: AppColors1.backgroundColor,
      home:Scaffold(
        backgroundColor:AppColors1.backgroundColor,
        body: HomePage()
      )
    );
  }
}


