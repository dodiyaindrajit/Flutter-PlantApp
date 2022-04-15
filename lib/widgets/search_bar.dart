import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:platapp_flutter/constants/colors.dart';
import 'package:platapp_flutter/main.dart';
import 'package:platapp_flutter/screen/profile.dart';
import 'package:platapp_flutter/widgets/camara.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:math' as math;

import '../main.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> with WidgetsBindingObserver {
  // CameraController? controller;
  // bool _isCameraInitialized = false;
  //
  // final resolutionPresets = ResolutionPreset.values;
  // ResolutionPreset currentResolutionPreset = ResolutionPreset.high;
  //
  // double _minAvailableZoom = 1.0;
  // double _maxAvailableZoom = 1.0;
  // double _currentZoomLevel = 1.0;
  // double _minAvailableExposureOffset = 0.0;
  // double _maxAvailableExposureOffset = 0.0;
  // double _currentExposureOffset = 0.0;
  //
  //
  // @override
  // void initState() {
  //   // Hide the status bar
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  //   onNewCameraSelected();
  //   WidgetsBinding.instance!.addPostFrameCallback((_) {
  //     show(context);
  //   });
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }
  //
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   final CameraController? cameraController = controller;
  //
  //   // App state changed before we got the chance to initialize.
  //   if (cameraController == null || !cameraController.value.isInitialized) {
  //     return;
  //   }
  //
  //   if (state == AppLifecycleState.inactive) {
  //     // Free up memory when camera not active
  //     cameraController.dispose();
  //   } else if (state == AppLifecycleState.resumed) {
  //     // Reinitialize the camera with same properties
  //     onNewCameraSelected();
  //   }
  // }
  //
  // void onNewCameraSelected() async {
  //   final previousCameraController = controller;
  //   // Instantiating the camera controller
  //   final CameraController cameraController = CameraController(
  //     MyApp.cameras[0],
  //     ResolutionPreset.high,
  //     imageFormatGroup: ImageFormatGroup.jpeg,
  //   );
  //
  //
  //
  //
  //   // Dispose the previous controller
  //   await previousCameraController?.dispose();
  //
  //   // Replace with the new controller
  //   if (mounted) {
  //     setState(() {
  //       controller = cameraController;
  //     });
  //   }
  //
  //   // Update UI if controller updated
  //   cameraController.addListener(() {
  //     if (mounted) setState(() {});
  //   });
  //
  //   // Initialize controller
  //   try {
  //     await cameraController.initialize();
  //   } on CameraException catch (e) {
  //     print('Error initializing camera: $e');
  //   }
  //
  //   // Update the Boolean
  //   if (mounted) {
  //     setState(() {
  //       _isCameraInitialized = controller!.value.isInitialized;
  //     });
  //   }
  //
  //   cameraController
  //       .getMaxZoomLevel()
  //       .then((value) => _maxAvailableZoom = value);
  //
  //   cameraController
  //       .getMinZoomLevel()
  //       .then((value) => _minAvailableZoom = value);
  //   cameraController
  //       .getMinExposureOffset()
  //       .then((value) => _minAvailableExposureOffset = value);
  //
  //   cameraController
  //       .getMaxExposureOffset()
  //       .then((value) => _maxAvailableExposureOffset = value);
  // }

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
              color: kSkyBlueColor,
              height: 75,
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

  // void show(BuildContext context) {
  //   showModalBottomSheet<void>(
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (BuildContext context) {
  //       return Padding(
  //         padding: const EdgeInsets.all(20.0),
  //         child: Container(
  //           height: 99.h,
  //           color: Colors.transparent,
  //           child: Center(
  //             child: AspectRatio(
  //               aspectRatio: 1 / controller!.value.aspectRatio,
  //               child: Column(
  //                 children: [
  //                   Stack(
  //                     children: [
  //                       controller!.buildPreview(),
  //                       DropdownButton<ResolutionPreset>(
  //                         dropdownColor: Colors.black87,
  //                         underline: Container(),
  //                         value: currentResolutionPreset,
  //                         items: [
  //                           for (ResolutionPreset preset
  //                           in resolutionPresets)
  //                             DropdownMenuItem(
  //                               child: Text(
  //                                 preset
  //                                     .toString()
  //                                     .split('.')[1]
  //                                     .toUpperCase(),
  //                                 style:
  //                                 TextStyle(color: Colors.white),
  //                               ),
  //                               value: preset,
  //                             )
  //                         ],
  //                         onChanged: (value) {
  //                           setState(() {
  //                             currentResolutionPreset = value!;
  //                             _isCameraInitialized = false;
  //                           });
  //                           onNewCameraSelected();
  //                         },
  //                         hint: Text("Select item"),
  //                       ),
  //                     ],
  //
  //                   ),
  //                   Align(
  //                     alignment: Alignment.topCenter,
  //                     child: Row(
  //                       children: [
  //                         Expanded(
  //                           child: Slider(
  //                             value: _currentZoomLevel,
  //                             min: _minAvailableZoom,
  //                             max: _maxAvailableZoom,
  //                             activeColor: Colors.white,
  //                             inactiveColor: Colors.white30,
  //                             onChanged: (value) async {
  //                               setState(() {
  //                                 _currentZoomLevel = value;
  //                               });
  //                               await controller!.setZoomLevel(value);
  //                             },
  //                           ),
  //                         ),
  //                         Container(
  //                           decoration: BoxDecoration(
  //                             color: Colors.black87,
  //                             borderRadius: BorderRadius.circular(10.0),
  //                           ),
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Text(
  //                               _currentZoomLevel.toStringAsFixed(1) +
  //                                   'x',
  //                               style: TextStyle(color: Colors.white),
  //                             ),
  //                           ),
  //                         ),
  //
  //                       ],
  //                     ),
  //                   ),
  //                   Align(
  //                     alignment: Alignment.centerRight,
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(20.0),
  //                       child: Container(
  //                         decoration: BoxDecoration(
  //                           color: Colors.white,
  //                           borderRadius: BorderRadius.circular(10.0),
  //                         ),
  //                         child: Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             _currentExposureOffset.toStringAsFixed(1) + 'x',
  //                             style: TextStyle(color: Colors.black),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child: RotatedBox(
  //                       quarterTurns: 3,
  //                       child: Container(
  //                         height: 30,
  //                         child: Slider(
  //                           value: _currentExposureOffset,
  //                           min: _minAvailableExposureOffset,
  //                           max: _maxAvailableExposureOffset,
  //                           activeColor: Colors.white,
  //                           inactiveColor: Colors.white30,
  //                           onChanged: (value) async {
  //                             setState(() {
  //                               _currentExposureOffset = value;
  //                             });
  //                             await controller!.setExposureOffset(value);
  //                           },
  //                         ),
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}