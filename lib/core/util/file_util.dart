import 'dart:html';

import 'package:collection/collection.dart';
import 'package:excel/excel.dart';

saveXls({required List<String> header, required List<List<dynamic>> data}) {
  var excel = Excel.createExcel();

  final sheetObject = excel['Sheet1'];
  sheetObject.isRTL = true;
  sheetObject.insertRowIterables(header, 0);

  data.forEachIndexed((index, element) {
    sheetObject.insertRowIterables(element, index + 1);
  });

  List<int>? fileBytes = excel.save();
  saveFile(fileBytes: fileBytes);
}

saveFile({
  List<int>? fileBytes,
}) {
  if (fileBytes != null) {
    // Create a Blob from the content
    final blob = Blob(fileBytes);

    // Create a download link
    AnchorElement()
      ..href = Url.createObjectUrlFromBlob(blob)
      ..download = 'qareeb.xlsx';

    // Append the anchor element to the body
    // document.body?.append(anchor);
  }
}
