// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// class CardS extends StatelessWidget {
//   const CardS({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final s= pw.Container(
//       decoration:pw. BoxDecoration(
//         border: pw.Border.all(color: PdfColors.black, width: 1.0),
//       ),
//       padding: pw.EdgeInsets.all(10.0),
//       child: pw.Column(
//         children: [
//          pw. Row(
//             mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//             children: [
//               ImageMultiType(
//                 url: Icons.ac_unit,
//                 color: Colors.blue,
//                 height: 100.0,
//               ),
//               pw.Text(
//                 'بطاقة اشتراك بالنقل',
//                 style: pw.TextStyle(
//                   fontSize: 18.0,
//                   fontWeight: pw.FontWeight.bold,
//                 ),
//               ),
//               ImageMultiType(
//                 url: Icons.ac_unit,
//                 color: Colors.blue,
//                 height: 70.0,
//               ),
//
//             ],
//           ),
//          pw.SizedBox(height: 5.0),
//          pw. Row(
//             children: [
//              pw. Expanded(
//
//                 child: pw.Column(
//
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//
//                   children: [
//                     pw.Text(
//                       'اسم الطالب: ',
//                       style: pw.TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: pw.FontWeight.bold,
//                       ),
//                     ),
//                     pw.SizedBox(height: 20.0),
//                     pw.Text(
//                       'الكلية :',
//                       style: pw.TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: pw.FontWeight.bold,
//                       ),
//                     ),
//                     pw.SizedBox(height: 20.0),
//                     pw.Text(
//                       'العام الدراسي : ',
//                       style: pw.TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: pw.FontWeight.bold,
//                       ),
//                     ),
//                     pw.SizedBox(height: 20.0),
//                     pw.Text(
//                       'الفصل الدراسي : ',
//                       style: pw.TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: pw.FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               pw.Container(
//                 height: 120.0,
//                 width: 100.0,
//                 decoration: pw.BoxDecoration(
//                   border: pw.Border.all(color: PdfColors.black, width: 1.0),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: 0.0.verticalSpace,
//     );
//   }
// }