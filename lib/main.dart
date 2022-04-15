import 'package:flutter/material.dart';
import 'package:platapp_flutter/constants/colors.dart';
import 'package:platapp_flutter/screen/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: kSkyBlueColor,
          secondary: kBlackColor,
        ),
        fontFamily: 'Philosopher',
      ),
      routes: {
        "/": (context) => const HomePage(),
      },
    );
  }
}
