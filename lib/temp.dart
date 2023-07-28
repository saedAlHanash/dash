// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
// class Note {
//
//   static Future initialize() async {
//     var androidInitialize =
//         const AndroidInitializationSettings('mipmap/ic_launcher');
//     var iOSInitialize = const IOSInitializationSettings();
//     var initializationsSettings =
//         InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
//     await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
//   }
//
//   static Future showBigTextNotification({
//     var id = 0,
//     required String title,
//     required String body,
//     var payload,
//   }) async {
//     // var vibrationPattern = Int64List(2);
//     // vibrationPattern[0] = 1000;
//     // vibrationPattern[1] = 1000;
//
//     const androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'Qareeb',
//       'Qareeb',
//       'qareeb taxi app',
//       playSound: true,
//
//       // enableVibration: true,
//       sound: RawResourceAndroidNotificationSound('sound'),
//       // vibrationPattern: vibrationPattern,
//       importance: Importance.low,
//       priority: Priority.low,
//     );
//
//     var not = const NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: IOSNotificationDetails(),
//     );
//
//     await flutterLocalNotificationsPlugin.show(
//         (DateTime.now().millisecondsSinceEpoch ~/ 1000), title, body, not);
//   }
// }
//
// /*
// import 'dart:async';
// import 'dart:convert';
// import 'dart:math' as math;
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map_animated_marker/flutter_map_animated_marker.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:rxdart/subjects.dart';
//
// import '../../../../generated/assets.dart';
//
// void main() {
//   runApp(MyApp2());
// }
//
// class MyApp2 extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: MapScreen(),
//     );
//   }
// }
//
// class MapScreen extends StatefulWidget {
//   const MapScreen({Key? key}) : super(key: key);
//
//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   static double lat = 33.6651;
//   static double lng = 36.2154;
//   var point = LatLng(lat, lng);
//
//   final stream = Stream.periodic(Duration(seconds: 5), (count) => count ).take(10);
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     stream.listen(
//       (event) {
//         point = LatLng(lat + event, lng + event);
//         setState(() {
//         });
//       },
//     );
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FlutterMap(
//       options: MapOptions(
//         center: LatLng(51.509364, -0.128928),
//         interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
//         zoom: 9.2,
//       ),
//       children: [
//         TileLayer(
//           urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//         ),
//         AnimatedMarkerLayer(
//           options: AnimatedMarkerLayerOptions(
//             duration: const Duration(
//               milliseconds: 3000,
//             ),
//             marker: Marker(
//               width: 30,
//               height: 30,
//               point: point,
//               builder: (context) => Center(
//                 child: Transform.rotate(
//                   angle: 90,
//                   child: Image.asset(
//                     Assets.iconsCarTopView,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
// */
//
// // import 'dart:async';
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// //
// // import 'package:qareeb_super_user/features/booking/bloc/booking_ui_control_cubit/booking_ui_control_cubit.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:flutter_svg/svg.dart';
// // import 'package:logger/logger.dart';
// // import 'package:lottie/lottie.dart';
// //
// // import '../../../../core/app/bloc/loading_cubit.dart';
// // import '../../../../core/strings/app_color_manager.dart';
// // import '../../../../core/strings/enum_manager.dart';
// // import '../../../../core/widgets/my_card_widget.dart';
// // import '../../../../core/widgets/spinner_widget.dart';
// // import '../../../../generated/assets.dart';
// // import '../../../booking/bloc/booking_control_cubit/trip_mediator_cubit.dart';
// // import '../../../booking/bloc/road_info_cubit/road_info_cubit.dart';
// // import '../../../trip_process/bloc/driver_location/driver_location_cubit.dart';
// // import '../../bloc/change_map_type_cubit/change_map_type_cubit.dart';
// // import '../../bloc/set_point_cubit/map_control_cubit.dart';
// //
// // class MapWidget extends StatefulWidget {
// //   const MapWidget({
// //     Key? key,
// //     this.onChange,
// //     this.isPicker,
// //     this.onMapReady,
// //   }) : super(key: key);
// //
// //   final Function(GeoPoint)? onChange;
// //   final Function? onMapReady;
// //   final bool? isPicker;
// //
// //   GlobalKey<MapWidgetState> getKey() {
// //     return GlobalKey<MapWidgetState>();
// //   }
// //
// //   @override
// //   State<MapWidget> createState() => MapWidgetState();
// // }
// //
// // class MapWidgetState extends State<MapWidget> with OSMMixinObserver {
// //   late MapController controller;
// //
// //   var startPoint = GeoPoint(latitude: 0, longitude: 0);
// //   var endPoint = GeoPoint(latitude: 0, longitude: 0);
// //
// //   /// get center map from picker mode
// //   Future<GeoPoint> getCenterMap() => controller.centerMap;
// //
// //   void changeMapListener(BuildContext context, ChangeMapTypeInitial state) {
// //     late String tileSource;
// //     switch (state.type) {
// //       case MapType.normal:
// //         tileSource = 'https://maps.almobtakiroon.com/osm/tile/';
// //         break;
// //
// //       case MapType.word:
// //         tileSource = 'https://maps.almobtakiroon.com/world2/tiles/';
// //         break;
// //
// //       case MapType.mix:
// //         tileSource = 'https://maps.almobtakiroon.com/overlay/';
// //         break;
// //     }
// //
// //     controller.changeTileLayer(
// //       tileLayer: CustomTile(
// //         sourceName: state.type.name,
// //         tileExtension: ".png",
// //         maxZoomLevel: 19,
// //         urlsServers: [
// //           TileURLs(url: tileSource),
// //         ],
// //         tileSize: 256,
// //       ),
// //     );
// //   }
// //
// //   controlMarkersListener(_, ControlMarkersInitial state) async {
// //     if (state.moveCamera) controller.goToLocation(state.point);
// //
// //     if (state.state != 'dl') return;
// //
// //     if (state.oldPoint.latitude == 0) {
// //       await controller.addMarker(
// //         state.point,
// //         angle: state.bearing,
// //         markerIcon: MarkerIcon(
// //           iconWidget: Image.asset(
// //             Assets.iconsCarTopView,
// //             height: 200.0.spMin,
// //             width: 200.0.spMin,
// //           ),
// //         ),
// //       );
// //     } else {
// //       controller.changeLocationMarker(
// //         oldLocation: state.oldPoint,
// //         newLocation: state.point,
// //       );
// //     }
// //   }
// //
// //   controlPageListener(_, BookingControlInitial state) {
// //     switch (state.bookingPage) {
// //       case BookingPages.selectLocation:
// //         controller.clearAllRoads();
// //         controller.removeMarker(startPoint);
// //         controller.removeMarker(endPoint);
// //         controller.advancedPositionPicker();
// //
// //         break;
// //       case BookingPages.trip:
// //         controller.cancelAdvancedPositionPicker();
// //         tripListener();
// //         break;
// //       case BookingPages.booking:
// //         break;
// //     }
// //   }
// //
// //   void tripListener() async {
// //     var tripMediator = context.read<BookingCubit>().state;
// //     //جلب النقاط البداية والنهاية للرحلة
// //     startPoint = tripMediator.getGeoPoint(tripMediator.startLocation);
// //     endPoint = tripMediator.getGeoPoint(tripMediator.endLocation);
// //
// //     //خط التحميل
// //     context.read<LoadingCubit>().startLoading();
// //
// //     //أصافة العلامة الأولى
// //     await controller.addMarker(
// //       startPoint,
// //       markerIcon: MarkerIcon(
// //         iconWidget: ImageMultiType(url:
// //           Assets.iconsMarkerStart,
// //           height: 70.0,
// //           width: 70.0,
// //         ),
// //       ),
// //     );
// //
// //     //أصافة العلامة الثانية
// //     await controller.addMarker(
// //       endPoint,
// //       markerIcon: MarkerIcon(
// //         iconWidget: ImageMultiType(url:
// //           Assets.iconsMarkerEnd,
// //           height: 70.0,
// //           width: 70.0,
// //         ),
// //       ),
// //     );
// //
// //     //رسم الطريق وجلب المعلومات منه
// //     final rodeInfo = await controller.drawRoad(
// //       startPoint,
// //       endPoint,
// //       roadType: RoadType.car,
// //       roadOption: RoadOption(
// //         roadColor: AppColorManager.mainColorDark,
// //         roadWidth: 15.0.spMin.toInt(),
// //       ),
// //     );
// //
// //     if (mounted) {
// //       //إنهاء التحميل
// //       context.read<LoadingCubit>().endLoading();
// //       //إرسال المعلومات الخاصة بالطريق للرحلة
// //       context.read<RoadInfoCubit>().setRoadInfo(rodeInfo);
// //     }
// //   }
// //
// //   driverLocationListener(_, DriverLocationInitial state) {
// //     if (state.result.lng == 0) return;
// //
// //     final p = GeoPoint(latitude: state.result.lat, longitude: state.result.lng);
// //
// //     context.read<ControlMarkersCubit>().setDriverLocation(
// //           point: p,
// //           moveCamera: false,
// //         );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MultiBlocListener(
// //       listeners: [
// //         BlocListener<ChangeMapTypeCubit, ChangeMapTypeInitial>(
// //           listener: changeMapListener,
// //         ),
// //         BlocListener<ControlMarkersCubit, ControlMarkersInitial>(
// //           listener: controlMarkersListener,
// //         ),
// //         BlocListener<BookingUiControlCubit, BookingControlInitial>(
// //           listener: controlPageListener,
// //         ),
// //         BlocListener<DriverLocationCubit, DriverLocationInitial>(
// //           listener: driverLocationListener,
// //         ),
// //       ],
// //       child: Stack(
// //         alignment: Alignment.center,
// //         children: [
// //           OSMFlutter(
// //             controller: controller,
// //             initZoom: 14,
// //             maxZoomLevel: 18,
// //             stepZoom: 1.0,
// //
// //             isPicker: widget.isPicker ?? false,
// //             markerOption: MarkerOption(
// //               advancedPickerMarker: MarkerIcon(
// //                 iconWidget: ImageMultiType(url:
// //                   Assets.iconsPickerMarker,
// //                   width: 120.spMin,
// //                 ),
// //               ),
// //             ),
// //           ),
// //           const MapTypeSpinner(),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   @override
// //   Future<void> mapIsReady(bool isReady) async {
// //     if (widget.onMapReady != null) widget.onMapReady!();
// //
// //     if (mounted) {
// //       final point = context.read<ControlMarkersCubit>().state.point;
// //       if (point.latitude == 0 || point.longitude == 0) return;
// //       controller.goToLocation(point);
// //     }
// //   }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     controller = MapController(initMapWithUserPosition: true);
// //     controller.addObserver(this);
// //   }
// //
// //   @override
// //   void dispose() {
// //     controller.dispose();
// //     super.dispose();
// //   }
// // }
// //
// // //---------------------------------------
// //
// // final mapTypeList = [
// //   SpinnerItem(name: 'خريطة عادية', id: MapType.normal.index),
// //   SpinnerItem(name: 'قمر صناعي', id: MapType.word.index),
// //   SpinnerItem(name: 'مختلطة', id: MapType.mix.index),
// // ];
// //
// // class MapTypeSpinner extends StatelessWidget {
// //   const MapTypeSpinner({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Positioned(
// //       top: 30.0.h,
// //       right: 10.0.w,
// //       child: SpinnerWidget(
// //         items: mapTypeList,
// //         width: 50.0.w,
// //         dropdownWidth: 200.0.w,
// //         customButton: MyCardWidget(
// //           elevation: 10.0,
// //           padding: const EdgeInsets.all(10.0).r,
// //           cardColor: AppColorManager.lightGray,
// //           child: const Icon(Icons.layers_rounded,
// //               color: AppColorManager.mainColor),
// //         ),
// //         onChanged: (p0) {
// //           context
// //               .read<ChangeMapTypeCubit>()
// //               .changeMapType(MapType.values[p0.id!]);
// //         },
// //       ),
// //     );
// //   }
// // }
// //
// // List<GeoPoint> getPointsBetween(GeoPoint p1, GeoPoint p2, int numPoints) {
// //   var points = <GeoPoint>[];
// //   for (var i = 0; i < numPoints; i++) {
// //     var t = i / (numPoints - 1);
// //     var lat = (1 - t) * p1.latitude + t * p2.latitude;
// //     var lng = (1 - t) * p1.longitude + t * p2.longitude;
// //     points.add(GeoPoint(latitude: lat, longitude: lng));
// //   }
// //   return points;
// // }
