import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:platapp_flutter/constants/animations.dart';
import 'package:platapp_flutter/constants/colors.dart';
import 'package:platapp_flutter/constants/images.dart';
import 'package:platapp_flutter/main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      pushNewScreen(
        context,
        screen: MyApp(),
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
    });
    return Scaffold(
      body: Container(
        color: kBackGroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(kSplash,),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30, child: Image.asset(kLogo)),
                  const SizedBox(width: 10),
                  const Text(
                    'PLANTFY',
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 30,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(0.2, 0.2),
                          blurRadius: 10.0,
                          color: kWhiteColor,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
