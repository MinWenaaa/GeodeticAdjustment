import 'package:flutter/material.dart';
import 'package:geodetic_adjustment/geodetic_adjustment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
          body: GeodeticPage()
      ),
    );
  }
}

class GeodeticPage extends StatefulWidget {
  const GeodeticPage({super.key});

  @override
  State<GeodeticPage> createState() => _GeodeticPageState();
}

class _GeodeticPageState extends State<GeodeticPage> {
  @override
  Widget build(BuildContext context) {
    double result=BDL2(48,36,44,44797,0);
    return Center(
      child:Text("$result")
    );
  }

}


