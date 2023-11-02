import 'dart:ui';

import 'package:flutter/services.dart' show Uint8List;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/features/members/data/response/member_response.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/strings/app_color_manager.dart';
import '../../../core/util/file_util.dart';

extension PwHelper on double {
  ///[ScreenUtil.setHeight]
  pw.Widget get pwVerticalSpace => pw.SizedBox(height: this);

  ///[ScreenUtil.setWidth]
  pw.Widget get pwHorizontalSpace => pw.SizedBox(width: this);
}

pw.MemoryImage? institutionsLogo;
pw.MemoryImage? stamp;

pw.Font? arabicFont;

pw.SvgImage? logoSvg;

Future<pw.Widget> getCardMember(Member member) async {
  final qrImage = await getQrImage(member.id);

  var memberImageBytes = await fetchImage(member.imageUrl);

  ///style
  final textStyle =
      pw.TextStyle(fontSize: 10.0, fontWeight: pw.FontWeight.bold, font: arabicFont);

  ///top static card
  final topCard = pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [
      if (logoSvg != null) logoSvg!,
      pw.Text(
        'بطاقة اشتراك بالنقل',
        textDirection: pw.TextDirection.rtl,
        style: pw.TextStyle(
          fontSize: 14.0,
          fontWeight: pw.FontWeight.bold,
          font: arabicFont,
        ),
      ),
      if (institutionsLogo != null) pw.Image(institutionsLogo!, height: 35.0),
    ],
  );

  ///border
  final border = pw.BoxDecoration(
    border: pw.Border.all(color: PdfColors.black, width: 0.5),
  );

  ///image border
  final memberImage = pw.Container(
    height: 70.0,
    width: 60.0,
    constraints: const pw.BoxConstraints(
      minHeight: 75.0,
      minWidth: 60.0,
    ),
    decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black, width: 0.5),
        image: memberImageBytes == null
            ? null
            : pw.DecorationImage(
                image: pw.MemoryImage(
                  memberImageBytes,
                ),
              )),
  );

  ///data
  final memberData = pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.end,
    children: [
      pw.Text(
        'اسم الطالب:  ${member.fullName}',
        textDirection: pw.TextDirection.rtl,
        style: textStyle,
      ),
      8.0.pwVerticalSpace,
      pw.Text(
        'الكلية : ${member.facility}',
        textDirection: pw.TextDirection.rtl,
        style: textStyle,
      ),
      8.0.pwVerticalSpace,
      pw.Text(
        'العام الدراسي : ${DateTime.now().year}',
        textDirection: pw.TextDirection.rtl,
        style: textStyle,
      ),
      8.0.pwVerticalSpace,
      pw.Text(
        'الفصل الدراسي : ${member.session}',
        textDirection: pw.TextDirection.rtl,
        style: textStyle,
      ),
    ],
  );

  ///qr image item
  final qrItem = pw.Container(
    width: PdfPageFormat.cm * 9.5,
    height: PdfPageFormat.cm * 5.4,
    decoration: border,
    child: pw.Center(
      child: pw.Image(pw.MemoryImage(qrImage), height: 120),
    ),
  );

  return pw.Row(
    children: [
      qrItem,
      pw.Stack(children: [
        pw.Container(
          width: PdfPageFormat.cm * 9.5,
          height: PdfPageFormat.cm * 5.4,
          decoration: border,
          padding: const pw.EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: pw.Column(
            children: [
              //top
              topCard,
              5.0.pwVerticalSpace,
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // image member
                  pw.Center(
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.only(top: 7),
                      child: memberImage,
                    ),
                  ),
                  //member data
                  pw.Expanded(child: memberData),
                ],
              ),
            ],
          ),
        ),
        if (stamp != null)
          pw.Positioned(
            bottom: 10.0,
            left: 35.0,
            child: pw.Image(stamp!, height: 50, width: 50),
          ),
      ]),
    ],
  );
}

Future<Uint8List> getQrImage(int id) async {
  final painter = QrPainter(
    data: id.toString(),
    version: QrVersions.auto,
    eyeStyle: const QrEyeStyle(
      color: AppColorManager.black,
      eyeShape: QrEyeShape.square,
    ),
    dataModuleStyle: const QrDataModuleStyle(
      color: AppColorManager.black,
      dataModuleShape: QrDataModuleShape.square,
    ),
  );
  final image = await painter.toImage(100);
  final pngBytes = await image.toByteData(format: ImageByteFormat.png);

  return pngBytes!.buffer.asUint8List();
}
