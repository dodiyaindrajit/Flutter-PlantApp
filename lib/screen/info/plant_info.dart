import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:circle_list/circle_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:platapp_flutter/constants/colors.dart';
import 'package:platapp_flutter/constants/images.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:simple_shadow/simple_shadow.dart';

class PlantInfo extends StatefulWidget {
  const PlantInfo({Key? key,
    required this.index,
    required this.name,
    required this.price,
    required this.imageName,
    required this.backGroundColor})
      : super(key: key);

  final String index;
  final String name;
  final String price;
  final String imageName;
  final Color backGroundColor;

  @override
  State<PlantInfo> createState() => _PlantInfoState();
}

class _PlantInfoState extends State<PlantInfo> with TickerProviderStateMixin {
  bool expanded = true;
  late AnimationController _drawerController;
  double initial = 0;
  double distance = 0;
  late AnimationController _controller;
  late Animation<Offset> _offset;

  bool selected = false;
  Duration animationDuration = const Duration(milliseconds: 1200);
  StreamController<int> controller = StreamController<int>();
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
    _drawerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    //Drawer Controller
    _drawerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
    );

    //SideMenu Controller
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _offset = Tween<Offset>(begin: Offset.zero, end: const Offset(1.0, 0.0)).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.backGroundColor,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: kBlackColor, //change your color here
        ),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20, child: Image.asset(kLogo)),
            const SizedBox(width: 10),
            Text(
              widget.name,
              style: const TextStyle(
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
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
            padding: const EdgeInsets.all(0),
          ),
          IconButton(
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
        ],
      ),
      backgroundColor: kBackGroundColor,
      body: SingleChildScrollView(
        child: Stack(
          // clipBehavior: Clip.antiAlias,
          children: [
            SizedBox(
              width: double.infinity,
              height: 35.h,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: SvgPicture.asset(
                  "assets/svg/plantInfoBg.svg",
                  color: widget.backGroundColor,
                  // fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Air Purifier",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.sp)),
                      Container(
                        width: 70,
                        height: 25,
                        decoration: const BoxDecoration(
                            color: kWhiteColor,
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.star,
                              color: kDarkGreenColor,
                              size: 15,
                            ),
                            Text("4.5",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.sp,
                                    color: kDarkGreenColor))
                          ],
                        ),
                      )
                    ],
                  ),
                  Text("PlantName", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30.sp)),
                  SizedBox(height: 5.h),
                  AnimatedOpacity(
                    opacity: selected ? 0 : 1,
                    duration: const Duration(milliseconds: 800),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("PRICE",
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp)),
                        Text(widget.price,
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17.sp)),
                        SizedBox(height: 3.h),
                        Text("Size",
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp)),
                        Text("5`` h",
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17.sp)),
                        SizedBox(height: 3.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SimpleShadow(
                                color: kBlackColor,
                                opacity: 0.9,
                                sigma: 4,
                                offset: const Offset(1, 2),
                                child: SvgPicture.asset("assets/svg/img_group60.svg", height: 100)),
                            SimpleShadow(
                                color: kBlackColor,
                                opacity: 0.9,
                                sigma: 4,
                                offset: const Offset(1, 2),
                                child: SvgPicture.asset("assets/svg/img_group61.svg", height: 100)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text("Overview", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp)),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/svg/img_group88.svg", height: 35),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("250 ml",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp,
                                      color: kDarkGreenColor)),
                              Text("WATER",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.sp,
                                      color: Colors.blueGrey)),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset("assets/svg/img_group90.svg", height: 35),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("250 ml",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp,
                                      color: kDarkGreenColor)),
                              Text("WATER",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.sp,
                                      color: Colors.blueGrey)),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset("assets/svg/img_group91.svg", height: 35),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("250 ml",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp,
                                      color: kDarkGreenColor)),
                              Text("WATER",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.sp,
                                      color: Colors.blueGrey)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Text("Plant Bio", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp)),
                  const SizedBox(height: 10),
                  Text(
                      "No green thumb required to keep our artificial watermelon peperomia plant looking lively and lush anywhere you place it.",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 17.sp, color: Colors.blueGrey)),
                  const SizedBox(height: 10),
                  imageSlider(),
                  const SizedBox(height: 10),
                  Text("Similar Plants",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp)),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      height: 30.h,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            // height: 20.w,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 6,
                                itemBuilder: (BuildContext context, int index) {
                                  return plantCard(index);
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
            AnimatedPositioned(
              // height: selected ? 40.h : 55.h,
              height: selected ? 40.h : 47.h,
              right: selected ? 45.w : -10,
              duration: animationDuration,
              child: Hero(
                tag: widget.index,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: SimpleShadow(
                      color: kBlackColor,
                      opacity: 0.6,
                      sigma: 5,
                      offset: const Offset(-5, 5),
                      child: Image.asset(
                        widget.imageName,
                        height: 35.h,
                      )),
                ),
              ),
            ),
            CircleList(
              // innerCircleColor: Colors.redAccent,
              outerCircleColor: kDarkGreenColor,
              innerRadius: 10.h,
              outerRadius: 20.h,
              // innerCircleRotateWithChildren: true,
              showInitialAnimation: true,
              rotateMode: RotateMode.onlyChildrenRotate,
              centerWidget: const Text("Asd"),
              onDragStart: (as) {
                print(as);
              },
              children: List.generate(16, (index) {
                return IconButton(
                  onPressed: () {
                    print("index $index");
                  },
                  icon: const Icon(Icons.home),
                  color: index % 2 == 0 ? Colors.yellow : Colors.orange,
                );
              }),
            ),
            AnimatedPositioned(
                height: 20.h,
                // top: selected ? 50.0 : 150.0,
                top: 65.w,
                right: selected ? 47.w : 0,
                duration: animationDuration,
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = !selected;
                      });
                    },
                    child: SvgPicture.asset("assets/svg/img_side.svg"))),
          ],
        ),
      ),
    );
  }

  Container imageSlider() {
    return Container(
      color: kBackGroundColor,
      padding: const EdgeInsets.only(bottom: 15, top: 15),
      child: Column(
        children: <Widget>[
          SizedBox(
              height: 100,
              width: 100.w,
              child: CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1 / 3,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                ),
                items: [
                  "assets/images/img_image27.png",
                  kCard1,
                  "assets/images/img_image29.png",
                  kCard2,
                  "assets/images/img_image30.png",
                  kCard3,
                  "assets/images/img_image46.png"
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          print("Clicked.....!");
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(i, fit: BoxFit.fill)),
                        ),
                      );
                    },
                  );
                }).toList(),
              ))
        ],
      ),
    );
  }

  Stack plantCard(int index) {
    print("plant_0" + index.toString());
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: SvgPicture.asset(
            "assets/svg/img_rectangle27_1.svg",
            color: plantBackColor[index],
            width: 70.w,
            height: 25.h,
            fit: BoxFit.fitWidth,
          ),
        ),
        Hero(
          tag: "plant_0" + index.toString(),
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
                    onTap: () {
                      pushNewScreen(context,
                          screen: PlantInfo(
                            name: plantName[index],
                            imageName: "assets/images/plant${index + 1}.png",
                            index: "plant_0$index",
                            price: "${index + 1}00",
                            backGroundColor: plantBackColor[index],));
                    },
                    child: Image.asset("assets/images/plant${index + 1}.png", width: 40.w),
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
              Text("Air Purifier",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp)),
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
}

class ColorConstant {
  static Color bluegray900 = fromHex('#002140');

  static Color gray90024 = fromHex('#24213800');

  static Color whiteA70099 = fromHex('#99ffffff');

  static Color teal600 = fromHex('#0d996b');

  static Color bluegray90090 = fromHex('#90002140');

  static Color bluegray90099 = fromHex('#99002140');

  static Color gray9001a = fromHex('#1a213800');

  static Color whiteA700 = fromHex('#ffffff');

  static Color teal100 = fromHex('#9ce6cc');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

class ImageConstant {
  static String imgImage30 = 'assets/images/img_image30.png';

  static String imgGroup47 = 'assets/images/img_group47.svg';

  static String imgRectangle272 = 'assets/images/img_rectangle27_2.svg';

  static String imgVector = 'assets/images/img_vector.svg';

  static String imgImage22 = 'assets/images/img_image22.png';

  static String imgGroup60 = 'assets/images/img_group60.svg';

  static String imgMaskgroup2 = 'assets/images/img_maskgroup_2.svg';

  static String imgGroup66 = 'assets/images/img_group66.svg';

  static String imgRectangle27 = 'assets/images/img_rectangle27.svg';

  static String imgSage = 'assets/images/img_sage.png';

  static String imgMenu = 'assets/images/img_menu.svg';

  static String imgUnion = 'assets/images/img_union.svg';

  static String imgRectangle63 = 'assets/images/img_rectangle63.svg';

  static String imgVector1 = 'assets/images/img_vector1.svg';

  static String imgGroup90 = 'assets/images/img_group90.svg';

  static String imgGroup68 = 'assets/images/img_group68.svg';

  static String imgMaskgroup1 = 'assets/images/img_maskgroup_1.svg';

  static String imgGroup61 = 'assets/images/img_group61.svg';

  static String imgRectangle46 = 'assets/images/img_rectangle46.svg';

  static String imgImage29 = 'assets/images/img_image29.png';

  static String imgGroup91 = 'assets/images/img_group91.svg';

  static String imgGroup88 = 'assets/images/img_group88.svg';

  static String imgImage46 = 'assets/images/img_image46.png';

  static String imgRectangle42 = 'assets/images/img_rectangle42.png';

  static String imgImage27 = 'assets/images/img_image27.png';

  static String imgRectangle28 = 'assets/images/img_rectangle28.svg';

  static String imgMaskgroup = 'assets/images/img_maskgroup.svg';

  static String imgSide = 'assets/images/img_side.svg';

  static String imgVector11 = 'assets/images/img_vector1_1.svg';

  static String imgSubtract = 'assets/images/img_subtract.svg';

  static String imgGroup46 = 'assets/images/img_group46.svg';

  static String imgRectangle271 = 'assets/images/img_rectangle27_1.svg';

  static String imgPeperomiaobtus = 'assets/images/img_peperomiaobtus.png';

  static String imgStar1 = 'assets/images/img_star1.svg';

  static String imgGroup83 = 'assets/images/img_group83.svg';

  static String imgRectangle59 = 'assets/images/img_rectangle59.svg';

  static String imgGroup611 = 'assets/images/img_group61_1.svg';

  static String imageNotFound = 'assets/images/image_not_found.png';
}
