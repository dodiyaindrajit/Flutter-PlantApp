import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:platapp_flutter/constants/colors.dart';
import 'package:platapp_flutter/screen/home/camara.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Theme(
          data: ThemeData(
            primaryColor: Colors.red,
            inputDecorationTheme: const InputDecorationTheme(
              contentPadding: EdgeInsets.symmetric(vertical: 10),),
          ),
          child: Container(
              color: kBackGroundColor,
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal:15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 75.w,
                    child: TextField(
                      cursorColor: kBlackColor,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        labelText: 'Search',
                        labelStyle: const TextStyle(color: kBlackColor),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: kBlackColor,
                        ),
                        suffixIcon: Transform.rotate(
                          angle: 180 * math.pi / 80,
                          child: IconButton(
                            icon: const Icon(
                              Icons.api_rounded,
                              color: kBlackColor,
                            ),
                            iconSize: 30,
                            onPressed: (){
                              pushNewScreen(
                                context,
                                screen: CameraScreen(),
                                withNavBar: true, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation: PageTransitionAnimation.cupertino,
                              );
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ));
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      border: Border.all(),
                    ),
                    child: IconButton(
                        icon: const Icon(Icons.filter_vintage_outlined),
                        onPressed: () { }),
                  ),
                ],
              )
          ),
        )
    );
  }
}