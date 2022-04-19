import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:platapp_flutter/constants/colors.dart';
import 'package:platapp_flutter/screen/home/home.dart';
import 'package:platapp_flutter/screen/splash.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {

  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }

  runApp(
      MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: kBackGroundColor,
              secondary: kBlackColor,
            ),
            fontFamily: 'Philosopher'
          ),
          routes: {
            "/": (context) => const SplashScreen(),
            "/home" : (context) => HomePage(),
          },
      )
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  static List<CameraDescription> cameras = [];

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  PersistentTabController _controller =  PersistentTabController(initialIndex: 0);

  List<int> text = [1,2,3,4];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> _buildScreens() {
      return [
        const HomePage(),
        const HomePage(),
        const HomePage(),
        const HomePage()
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
      for ( var i in text) PersistentBottomNavBarItem(
          icon: SvgPicture.asset("assets/svg/bottomBarItem$i.svg",height: 55,color:kDarkGreenColor),
          activeColorPrimary: kDarkGreenColor,
          inactiveColorPrimary: kBlackColor,
          inactiveIcon: SvgPicture.asset("assets/svg/bottomBarItem$i.svg",height: 55,color:kBlackColor),
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      bottomScreenMargin: 0,
      navBarHeight: 50,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 500),
      ),
      navBarStyle: NavBarStyle.style3,
      onItemSelected: (index){},
      backgroundColor: kBackGroundColor,
    );
  }
}
