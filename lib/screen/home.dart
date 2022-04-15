import 'dart:ui' as ui;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:platapp_flutter/constants/animations.dart';
import 'package:platapp_flutter/constants/colors.dart';
import 'package:platapp_flutter/constants/images.dart';
import 'package:platapp_flutter/widgets/search_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool expanded = true;
  late AnimationController _drawerController;
  late final AnimationController _lottiesController;

  @override
  void dispose() {
    _lottiesController.dispose();
    _drawerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _drawerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
    );

    _lottiesController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            appBar(),
            SearchBar(),
            SliverToBoxAdapter(
              child: Container(
                color: kSkyBlueColor,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[cardSlider],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Container(
                    color: index.isOdd ? Colors.white : Colors.black12,
                    height: 100.0,
                    child: Center(
                      child: Text('$index', textScaleFactor: 5),
                    ),
                  );
                },
                childCount: 20,
              ),
            ),
          ],
        ),
      );
    });
  }

  SliverAppBar appBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 20.h,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        title: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20, child: Image.asset(kLogo)),
                const SizedBox(width: 10),
                const Text(
                  'PLANTFY',
                  style: TextStyle(
                    color: Colors.black,
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
            ),
          ),
        ),
        background: Image.asset(kAppbarBg, fit: BoxFit.fitWidth),
        collapseMode: CollapseMode.parallax,
      ),
      leading: IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_home,
            progress: _drawerController,
            semanticLabel: 'Show menu',
            color: kBlackColor,
          ),
          onPressed: () {
            setState(() {
              expanded ? _drawerController.forward() : _drawerController.reverse();
              expanded = !expanded;
            });
          }),
      actions: [
        GestureDetector(
          onTap: () {
            _lottiesController.reset();
            _lottiesController.forward();
          },
          child: Lottie.asset(
            kNotificationBell,
            controller: _lottiesController,
            onLoaded: (composition) {
              // Configure the AnimationController with the duration of the
              // Lottie file and start the animation.
              _lottiesController
                ..duration = composition.duration
                ..forward();
            },
          ),
        ),
      ],
    );
  }

  Widget cardSlider = SizedBox(
    // height: 180,
      child: CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 1,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
        ),
        items: [kCard1, kCard2, kCard3].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: 100.w,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  // decoration: BoxDecoration(color: Colors.amber),
                  child: GestureDetector(
                      child: Image.asset(i, fit: BoxFit.fill),
                      onTap: () {
                        print("Clicked.....!");
                      }));
            },
          );
        }).toList(),
      ));
}
