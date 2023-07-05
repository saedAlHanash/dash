// import 'dart:async';
// import 'dart:io';
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:qareeb_dash/core/api_manager/api_service.dart';
// import 'package:qareeb_dash/core/api_manager/api_url.dart';
// import 'package:qareeb_dash/core/util/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../core/util/note_message.dart';
//
// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//
//   /// OPTIONAL, using custom notification channel id
//   const channel = AndroidNotificationChannel(
//     'qareeb_location', // id
//     'qareeb get location', // title
//     description: 'get location in background from driver device', // description
//     importance: Importance.low, // importance must be at low or higher level
//   );
//
//   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   if (Platform.isIOS || Platform.isAndroid) {
//     await flutterLocalNotificationsPlugin.initialize(
//       const InitializationSettings(
//         iOS: DarwinInitializationSettings(),
//         android: AndroidInitializationSettings('mipmap/ic_launcher'),
//       ),
//     );
//   }
//
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
//
//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       // this will be executed when app is in foreground or background in separated isolate
//       onStart: onStart,
//
//       // auto start service
//       autoStart: false,
//       autoStartOnBoot: false,
//       isForegroundMode: true,
//
//       notificationChannelId: 'my_foreground',
//       initialNotificationTitle: 'السائق في وضع العمل',
//       initialNotificationContent: 'يتم مشاركة موقعك الحالي',
//       foregroundServiceNotificationId: 888,
//     ),
//     iosConfiguration: IosConfiguration(
//       // auto start service
//       autoStart: true,
//
//       // this will be executed when app is in foreground in separated isolate
//       onForeground: onStart,
//
//       // you have to enable background fetch capability on xcode project
//       onBackground: onIosBackground,
//     ),
//   );
//
//   service.startService();
// }
//
// @pragma('vm:entry-point')
// Future<bool> onIosBackground(ServiceInstance service) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   DartPluginRegistrant.ensureInitialized();
//
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   await preferences.reload();
//   final log = preferences.getStringList('log') ?? <String>[];
//   log.add(DateTime.now().toIso8601String());
//   await preferences.setStringList('log', log);
//
//   return true;
// }
//
// @pragma('vm:entry-point')
// void onStart(ServiceInstance service) async {
//   DartPluginRegistrant.ensureInitialized();
//
//   await SharedPreferences.getInstance().then((value) {
//     AppSharedPreference.init(value);
//   });
//   AppSharedPreference.reload();
//
//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });
//
//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//     });
//   }
//
//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });
//
//   getLocationListener();
//
//   if (!await AppSharedPreference.isDriverAvailable && !AppSharedPreference.isShared()) {
//     service.stopSelf();
//   }
// }
//
// Future<bool> getLocationPermissions({BuildContext? context}) async {
//   LocationPermission permission;
//
//   checkGpsEnable(context: context);
//
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       // Permissions are denied, next time you could try
//       // requesting permissions again (this is also where
//       // Android's shouldShowRequestPermissionRationale
//       // returned true. According to Android guidelines
//       // your App should show an explanatory UI now.
//       if (context != null && context.mounted) {
//         NoteMessage.showErrorSnackBar(
//             message: 'تم رفض صلاحيات خدمة الموقع يرجى قبول الصلاحية للمتابعة',
//             context: context);
//       }
//       return false;
//     }
//   }
//
//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately.
//     if (context != null && context.mounted) {
//       NoteMessage.showErrorSnackBar(
//           message: 'Location permissions are permanently denied, '
//               'we cannot request permissions.',
//           context: context);
//     }
//     return false;
//   }
//   return true;
// }
//
// Future<bool> checkGpsEnable({BuildContext? context}) async {
//   if (!await Geolocator.isLocationServiceEnabled()) {
//     await Geolocator.openLocationSettings();
//     if (context != null && context.mounted) {
//       NoteMessage.showErrorSnackBar(
//           message: 'خدمة الموقع متوقفة يرجى تفعيلها للمتابعة', context: context);
//     }
//     return false;
//   }
//   return true;
// }
//
// StreamSubscription<Position>? stream;
// bool isSharedTrip = false;
//
// Future<void> getLocationListener() async {
//
//   var canSend = true;
//
//   stream = Geolocator.getPositionStream().listen((Position position) {
//     if (canSend) {
//       loggerObject.wtf(position.toString());
//       canSend = false;
//       Future.delayed(const Duration(seconds: 5), () => canSend = true);
//       APIService().puttApi(
//         url: PutUrl.changeUserLocation,
//         body: {
//           "id": AppSharedPreference.getMyId,
//           "latitude": position.latitude,
//           "longitude": position.longitude
//         },
//       ).then((value) {
//         if (value.statusCode == 401) {
//           APIService.reInitial();
//         }
//       });
//     }
//   });
// }
//
// Future<void> startSendLocation() async {
//   if (!await FlutterBackgroundService().isRunning()) {
//     await FlutterBackgroundService().startService();
//   }
//   FlutterBackgroundService().invoke("setAsForeground");
// }
//
// Future<void> stopSendLocation() async {
//   final service = FlutterBackgroundService();
//   var isRunning = await service.isRunning();
//   if (stream != null) {
//     stream!.cancel();
//   }
//   if (isRunning) {
//     service.invoke("stopService");
//   }
// }
