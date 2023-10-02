import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
  import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf/pdf.dart';
  import 'package:pdf/widgets.dart' as pw;
import 'package:qareeb_dash/core/util/shared_preferences.dart';
import 'package:qareeb_dash/core/widgets/app_bar_widget.dart';
import 'package:qareeb_dash/generated/assets.dart';
import 'package:qareeb_dash/router/go_route_pages.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/file_util.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../bloc/login_cubit/login_cubit.dart';
import '../../data/request/login_request.dart';

// Future<pw.MemoryImage> assetImageToMemoryImage(String imagePath) async {
//   Uint8List bytes = await getImageBytes(imagePath);
//   return pw.MemoryImage(
//     bytes,
//   );
// }
//
// Future<Uint8List> getImageBytes(String imagePath) async {
//   final imageData = await rootBundle.load(imagePath);
//   final bytes = imageData.buffer.asUint8List();
//   return bytes;
// }
//
// Future<void> convertWidgetToPdf() async {
//   final pdf = pw.Document();
//
//   // final mImage = await assetImageToMemoryImage('icons/card_back.png');
//   final mImageFront = await assetImageToMemoryImage('icons/front_card.jpg');
//   final car = await assetImageToMemoryImage('icons/car_top_view.png');
//   final arabicFont = pw.Font.ttf(await rootBundle.load('fonts/Amiri-Regular.ttf'));
//
//   final d = pw.Row(children: [
//     pw.Container(
//       width: 250,
//       height: 140,
//       decoration: pw.BoxDecoration(
//         border: pw.Border.all(color: PdfColors.black, width: 1.0),
//       ),
//       padding: const pw.EdgeInsets.all(3.0),
//       child: pw.Column(
//         children: [
//           pw.Row(
//             mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//             children: [
//               pw.Image(mImageFront, height: 20.0),
//               pw.Text(
//                 'بطاقة اشتراك بالنقل',
//                 textDirection: pw.TextDirection.rtl,
//                 style: pw.TextStyle(
//                     fontSize: 16.0, fontWeight: pw.FontWeight.bold, font: arabicFont),
//               ),
//               pw.Image(mImageFront, height: 30.0),
//             ],
//           ),
//           pw.SizedBox(height: 5.0),
//           pw.Row(
//             children: [
//               pw.Container(
//                 height: 70.0,
//                 width: 60.0,
//                 decoration: pw.BoxDecoration(
//                   border: pw.Border.all(color: PdfColors.black, width: 1.0),
//                 ),
//               ),
//               pw.Expanded(
//                 child: pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.end,
//                   children: [
//                     pw.Text(
//                       'اسم الطالب: ',
//                       textDirection: pw.TextDirection.rtl,
//                       style: pw.TextStyle(
//                           fontSize: 12.0,
//                           fontWeight: pw.FontWeight.bold,
//                           font: arabicFont),
//                     ),
//                     pw.SizedBox(height: 2.0),
//                     pw.Text(
//                       'الكلية :',
//                       textDirection: pw.TextDirection.rtl,
//                       style: pw.TextStyle(
//                           fontSize: 12.0,
//                           fontWeight: pw.FontWeight.bold,
//                           font: arabicFont),
//                     ),
//                     pw.SizedBox(height: 2.0),
//                     pw.Text(
//                       'العام الدراسي : ',
//                       textDirection: pw.TextDirection.rtl,
//                       style: pw.TextStyle(
//                           fontSize: 12.0,
//                           fontWeight: pw.FontWeight.bold,
//                           font: arabicFont),
//                     ),
//                     pw.SizedBox(height: 2.0),
//                     pw.Text(
//                       'الفصل الدراسي : ',
//                       textDirection: pw.TextDirection.rtl,
//                       style: pw.TextStyle(
//                           fontSize: 12.0,
//                           fontWeight: pw.FontWeight.bold,
//                           font: arabicFont),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//     pw.SizedBox(width: 1.0),
//     pw.Container(
//       width: 250,
//       height: 140,
//       decoration: pw.BoxDecoration(
//         border: pw.Border.all(color: PdfColors.black, width: 1.0),
//       ),
//       padding: const pw.EdgeInsets.all(3.0),
//       child: pw.Center(
//         child: pw.SvgImage(
//             svg: await rootBundle.loadString('icons/logo_with_text.svg'), height: 120.0),
//       ),
//     ),
//   ]);
//
//   pdf.addPage(
//     pw.Page(
//       build: (_) {
//         return d;
//       },
//     ),
//   );
//
//   saveFilePdf(pdfInBytes: await pdf.save());
// }

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var email = '';
  var password = '';

  var isLoading = true;

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (AppSharedPreference.isLogin) {
          context.pushNamed(GoRouteName.homePage);
        } else {
          setState(() => isLoading = false);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return MyStyle.loadingWidget();
    return BlocListener<LoginCubit, LoginInitial>(
      listenWhen: (p, c) => c.statuses == CubitStatuses.done,
      listener: (_, state) => context.pushNamed(GoRouteName.homePage),
      child: Scaffold(
        appBar: const AppBarWidget(),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: MyStyle.pagePadding,
          alignment: Alignment.center,
          child: MyCardWidget(
            elevation: 10.0,
            margin: EdgeInsets.symmetric(horizontal: 0.3.sw),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const DrawableText(
                  text: AppStringManager.login,
                  fontFamily: FontManager.cairoBold,
                  color: AppColorManager.mainColor,
                ),
                10.0.verticalSpace,
                MyTextFormWidget(
                  liable: AppStringManager.enterEmail,
                  textAlign: TextAlign.left,
                  initialValue: email,
                  onChanged: (val) => email = val,
                ),
                MyTextFormWidget(
                  liable: AppStringManager.enterPassword,
                  textAlign: TextAlign.left,
                  obscureText: true,
                  initialValue: password,
                  onChanged: (val) => password = val,
                ),
                10.0.verticalSpace,
                BlocBuilder<LoginCubit, LoginInitial>(
                  builder: (_, state) {
                    if (state.statuses == CubitStatuses.loading) {
                      return MyStyle.loadingWidget();
                    }
                    return MyButton(
                      text: AppStringManager.login,
                      onTap: () {
                        final request = LoginRequest(email: email, password: password);
                        context.read<LoginCubit>().login(context, request: request);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
