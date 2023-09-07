import 'dart:html';

import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:excel/excel.dart';

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

  List<int>? fileBytes = excel.save(fileName: '$fileName.xlsx' ?? 'Qareep Report.xlsx');
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
