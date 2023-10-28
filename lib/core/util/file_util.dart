import 'dart:convert';
import 'dart:html';
import 'dart:html' as html;

import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;

import '../../main.dart';
import '../api_manager/api_service.dart';
import '../api_manager/server_proxy/server_proxy_service.dart';

saveXls(
    {required List<String> header, required List<List<dynamic>> data, String? fileName}) {
  var excel = Excel.createExcel();

  final sheetObject = excel['Sheet1'];

  sheetObject.isRTL = true;

  sheetObject.setColAutoFit(0);
  for (int i = 0; i < header.length; i++) {
    sheetObject.updateCell(
      CellIndex.indexByColumnRow(rowIndex: 0, columnIndex: i),
      header[i],
      cellStyle: CellStyle(
        leftBorder: Border(borderStyle: BorderStyle.Thin),
        rightBorder: Border(borderStyle: BorderStyle.Thin),
        topBorder: Border(borderStyle: BorderStyle.Thin),
        bottomBorder: Border(borderStyle: BorderStyle.Thin),
        bold: true,
        horizontalAlign: HorizontalAlign.Center,
        verticalAlign: VerticalAlign.Center,
      ),
    );
  }

  for (int i = 1; i < data.length + 1; i++) {
    sheetObject.setColAutoFit(i);
    for (int j = 0; j < data[i - 1].length; j++) {
      final dataItem = data[i - 1][j];
      sheetObject.updateCell(
        CellIndex.indexByColumnRow(rowIndex: i, columnIndex: j),
        (dataItem is bool) ? '' : dataItem,
        cellStyle: CellStyle(
          leftBorder: Border(borderStyle: BorderStyle.Thin),
          rightBorder: Border(borderStyle: BorderStyle.Thin),
          topBorder: Border(borderStyle: BorderStyle.Thin),
          bottomBorder: Border(borderStyle: BorderStyle.Thin),
          backgroundColorHex: (dataItem is bool)
              ? dataItem
                  ? '#8BB93E'
                  : '#C60000'
              : 'none',
          horizontalAlign: HorizontalAlign.Center,
          verticalAlign: VerticalAlign.Center,
        ),
      );
    }
  }

  // data.forEachIndexed((index, element) {
  //   sheetObject.insertRowIterables(element, index + 1);
  // });

  List<int>? fileBytes = excel.save(fileName: '$fileName.xlsx');
  saveFile(fileBytes: fileBytes);
}

saveFile({
  List<int>? fileBytes,
}) {
  if (fileBytes != null) {
    // Create a Blob from the content
    final blob = Blob(fileBytes);
    print(Url.createObjectUrlFromBlob(blob).toString());

    // Create a download link
    AnchorElement()
      ..href = Url.createObjectUrlFromBlob(blob)
      ..download = 'qareeb.xlsx';

    // Append the anchor element to the body
    // document.body?.append(anchor);
  }
}

saveFilePdf({
  List<int>? pdfInBytes,
}) {
  if (pdfInBytes != null) {
//Create blob and link from bytes
    final blob = html.Blob([pdfInBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'pdf.pdf';
    html.document.body?.children.add(anchor);

    anchor.click();
  }
}

saveImageFile({
  List<int>? pngBytes,
  String? name,
}) {
  if (pngBytes != null) {
    final blob = Blob([pngBytes], 'image/jpg');
    final url = Url.createObjectUrlFromBlob(blob);
    AnchorElement(href: url)
      ..setAttribute('download', '$name.jpg')
      ..click();
  }
}

Future<Uint8List?> fetchImage(String imageUrl, {bool withCompress = true}) async {
  if (imageUrl.isEmpty) return null;

  final imageFromCash = hiveBox?.get(imageUrl);

  if (imageFromCash != null) {
    loggerObject.w('from hive ${imageFromCash!.length}');
    final compressedImage = await testComporessList(imageFromCash);
    return withCompress ? compressedImage : imageFromCash;
  }

  try {
    loggerObject.v(imageUrl);
    final response = await getServerProxyRowApi(url: imageUrl);
    final b  =base64Decode(response.body);
    if (response .statusCode == 200) {
      final compressedImage = await testComporessList(b);
      hiveBox?.put(imageUrl, b);
      return withCompress ? compressedImage : b;
    } else {
      return null;
    }
  } on Exception {
    return null;
  }
}

Future<pw.MemoryImage> assetImageToMemoryImage(String imagePath) async {
  final bytes = await getImageBytes(imagePath);

  return pw.MemoryImage(await testComparesListQuality(bytes));
}

Future<Uint8List> getImageBytes(String imagePath) async {
  final imageData = await rootBundle.load(imagePath);
  final bytes = imageData.buffer.asUint8List();
  return bytes;
}

Future<Uint8List> testComporessList(Uint8List list) async {
  var result = await FlutterImageCompress.compressWithList(
    list,
    minHeight: 750 ~/ 5,
    minWidth: 600 ~/ 5,
    quality: 30,
    format: CompressFormat.png,
  );
  return result;
}

//testComparesListQuality
Future<Uint8List> testComparesListQuality(Uint8List list) async {
  var result = await FlutterImageCompress.compressWithList(
    list,
    minWidth: 1920 ~/ 2,
    minHeight: 1080 ~/ 2,
    quality: 50,
    format: CompressFormat.png,
  );
  return result;
}
