import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_super_user/core/extensions/extensions.dart';
import 'package:qareeb_super_user/generated/assets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/service/members_service.dart';
import '../../../../core/service/report_request_service.dart';
import '../../../../core/util/my_style.dart';
import '../../../super_user/bloc/all_super_users_cubit/all_super_users_cubit.dart';
import '../../bloc/send_report_cubit/send_report_cubit.dart';
import '../../data/request/report_request.dart';

class QrPage extends StatelessWidget {
  const QrPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AllSuperUsersCubit, AllSuperUsersInitial>(
        builder: (context, state) {
          if (state.statuses.isLoading) {
            return MyStyle.loadingWidget();
          }
          return Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QRViewExample(),
                ));
              },
              child: const Text('start Scan'),
            ),
          );
        },
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  var waiting = false;

  ///member service
  final usersService = sl<UsersService>();

  ///result Qr Scan
  Barcode? result;

  ///qr controller
  QRViewController? controller;

  final qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendReportCubit, SendReportInitial>(
      listener: (context, state) {
        if (state.statuses.isLoading) {
          waiting = true;
        } else {
          controller?.resumeCamera();
          waiting = false;
        }
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(flex: 4, child: _buildQrView(context)),
            // Expanded(
            //   flex: 1,
            //   child: FittedBox(
            //     fit: BoxFit.contain,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: <Widget>[
            //         if (result != null)
            //           Text(
            //               'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
            //         else
            //           const Text('Scan a code'),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: <Widget>[
            //             Container(
            //               margin: const EdgeInsets.all(8),
            //               child: ElevatedButton(
            //                   onPressed: () async {
            //                     await controller?.toggleFlash();
            //                     setState(() {});
            //                   },
            //                   child: FutureBuilder(
            //                     future: controller?.getFlashStatus(),
            //                     builder: (context, snapshot) {
            //                       return Text('Flash: ${snapshot.data}');
            //                     },
            //                   )),
            //             ),
            //             Container(
            //               margin: const EdgeInsets.all(8),
            //               child: ElevatedButton(
            //                   onPressed: () async {
            //                     await controller?.flipCamera();
            //                     setState(() {});
            //                   },
            //                   child: FutureBuilder(
            //                     future: controller?.getCameraInfo(),
            //                     builder: (context, snapshot) {
            //                       if (snapshot.data != null) {
            //                         return Text(
            //                             'Camera facing ${describeEnum(snapshot.data!)}');
            //                       } else {
            //                         return const Text('loading');
            //                       }
            //                     },
            //                   )),
            //             )
            //           ],
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: <Widget>[
            //             Container(
            //               margin: const EdgeInsets.all(8),
            //               child: ElevatedButton(
            //                 onPressed: () async {
            //                   await controller?.pauseCamera();
            //                 },
            //                 child: const Text('pause', style: TextStyle(fontSize: 20)),
            //               ),
            //             ),
            //             Container(
            //               margin: const EdgeInsets.all(8),
            //               child: ElevatedButton(
            //                 onPressed: () async {
            //                   await controller?.resumeCamera();
            //                 },
            //                 child: const Text('resume', style: TextStyle(fontSize: 20)),
            //               ),
            //             )
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      cameraFacing: CameraFacing.front,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  final audioPlayer = AudioPlayer();

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      loggerObject.wtf(usersService.usersIds);
      if (waiting) return;
      controller.pauseCamera();
      waiting = true;

      sl<RequestsService>().addToRequests(
        ReportRequest(
            busMemberId: int.tryParse(scanData.code ?? '') ?? 0, date: DateTime.now()),
      );

      context.read<SendReportCubit>().sendReport(context);

      if (usersService.usersIds.contains(scanData.code)) {
        playAudio();
      } else {
        playAudio(isWarning: true);
      }
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  Future<void> playAudio({bool isWarning = false}) async {
    audioPlayer.play(AssetSource('sounds/${isWarning ? 'warning_beeping' : 'peen'}.mp3'));
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
