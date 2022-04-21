import 'dart:ui' as ui;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_custom_tab_bar/library.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:platapp_flutter/constants/animations.dart';
import 'package:platapp_flutter/constants/colors.dart';
import 'package:platapp_flutter/constants/images.dart';
import 'package:platapp_flutter/screen/info/plant_info.dart';
import 'package:platapp_flutter/widgets/search_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:simple_shadow/simple_shadow.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool expanded = true;
  late AnimationController _drawerController;
  late final AnimationController _lottiesController;
  final PageController _controller = PageController();
  final CustomTabBarController _tabBarController = CustomTabBarController();

  final int pageCount = 6;
  final List<String> plantName = [
    "Perperomia",
    "WaterMelon",
    "Crotom Petra",
    "Bird's Nest Ferm",
    "Cactus",
    "Aloe Vera"
  ];
  final List<Color> plantBackColor = <Color>[
    const Color(0xFFF9CE5CB),
    const Color(0xFFFFF1C2),
    const Color(0xFF56D1A7),
    const Color(0xFFB2E28D),
    const Color(0xFFDEEC8A),
    const Color(0xFFF5EDA8)
  ];

  @override
  void dispose() {
    _lottiesController.dispose();
    _drawerController.dispose();
    _controller.dispose();
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
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light.copyWith(
            systemNavigationBarColor: kWhiteColor,
          ),
          child: CustomScrollView(
            slivers: <Widget>[appBar(), const SearchBar(), imageSlider(), filterTabBar(), footer()],
          ),
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
        centerTitle: true,
        expandedTitleScale: 2,
        title: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Container(
            // width: 100,
            // color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20, child: Image.asset(kLogo)),
                const SizedBox(width: 10),
                const Text(
                  'PLANTFY',
                  style: TextStyle(
                    color: kBlackColor,
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

  SliverToBoxAdapter imageSlider() {
    return SliverToBoxAdapter(
      child: Container(
        color: kBackGroundColor,
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Column(
          children: <Widget>[
            SizedBox(
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
            ))
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter filterTabBar() {
    double cardHeight = 32.h;
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        color: kBackGroundColor,
        height: (6 * cardHeight) + 35,
        child: Column(
          children: [
            CustomTabBar(
              tabBarController: _tabBarController,
              height: 35,
              itemCount: pageCount,
              builder: (BuildContext context, int index) {
                List _plantCategory = [
                  "Top Pick",
                  "Indoor",
                  "Outdoor",
                  "Seeds",
                  "Office Plant",
                  "Flower"
                ];
                return TabBarItem(
                    index: index,
                    transform: ScaleTransform(
                        maxScale: 1.3,
                        transform: ColorsTransform(
                            normalColor: kBlackColor,
                            highlightColor: kDarkGreenColor,
                            builder: (context, color) {
                              return Container(
                                  padding: const EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  constraints: const BoxConstraints(minWidth: 70),
                                  child: (Text(
                                    _plantCategory[index],
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: color,
                                    ),
                                  )));
                            })));
              },
              indicator: StandardIndicator(
                  width: 30, height: 3, color: kDarkGreenColor, radius: BorderRadius.circular(1.5)),
              pageController: _controller,
            ),
            Expanded(
                child: PageView.builder(
                    controller: _controller,
                    itemCount: pageCount,
                    itemBuilder: (context, pageIndex) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            // height: 20.w,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 6,
                                itemBuilder: (BuildContext context, int index) {
                                  return plantCard(index, pageIndex);
                                }),
                          )
                        ],
                      );
                    }))
          ],
        ),
      ),
    );
  }

  Stack plantCard(int index, int pageIndex) {
    print("plant_"+pageIndex.toString()+index.toString());
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: SvgPicture.asset(
            kCardBackground1,
            color: plantBackColor[index],
            width: 78.w,
            fit: BoxFit.fitWidth,
          ),
        ),
        Hero(
          tag: "plant_"+pageIndex.toString()+index.toString(),
          child: Align(
              alignment: const Alignment(1.1, 0),
              child: SimpleShadow(
                color: kBlackColor,
                opacity: 0.6,
                sigma: 5,
                offset: const Offset(-5, 5),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: (){
                      pushNewScreen(context,
                        screen: PlantInfo(name: plantName[index],imageName: "assets/images/plant${index+1}.png",index: "plant_$pageIndex$index",price: "${index+1}00", backGroundColor: plantBackColor[index],));
                    },
                    child: Image.asset("assets/images/plant${index+1}.png", width: 40.w),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                  ),
                ),
              )),
        ),
        Padding(
          padding: EdgeInsets.only(top: 9.h, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("$pageIndex$index Air Purifier", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp)),
              Text(plantName[index],
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25.sp)),
              SizedBox(
                width: 60.w,
                height: 10.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$400", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp)),
                    SvgPicture.asset("assets/svg/bottomBarItem2.svg"),
                    SvgPicture.asset("assets/svg/shop.svg"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  SliverToBoxAdapter footer() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        color: kBackGroundColor,
        height: 23.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(color: kBlackColor, width: 70, height: 5),
            const SizedBox(height: 10),
            const Text("Plant a Life",
                style: TextStyle(
                    color: Color(0xFF002140), fontSize: 36, fontWeight: ui.FontWeight.bold)),
            const Text("Live amongst Living",
                style: TextStyle(color: Color(0xFF002140), fontSize: 32)),
            const Text("Spread the joy", style: TextStyle(color: Color(0xFF002141), fontSize: 31)),
          ],
        ),
      ),
    );
  }
}
