import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generated/assets.dart';
import '../strings/app_string_manager.dart';
import 'package:image_multi_type/image_multi_type.dart';

class MyTableWidget extends StatelessWidget {
  const MyTableWidget({
    Key? key,
    required this.children,
    required this.title,
  }) : super(key: key);

  final Map<String, dynamic> children;
  final String title;

  @override
  Widget build(BuildContext context) {
    final divider = SizedBox(
      height: 20.0,
      child: VerticalDivider(thickness: 1.0.w),
    );
    const dividerH = Divider(height: 0.0);

    List<Widget> items = [];

    children.forEach((key, value) {
      final row = Row(
        children: [
          10.0.horizontalSpace,
          SizedBox(
            width: 100.0.w,
            child: DrawableText(
              text: key,
              color: AppColorManager.black,
              textAlign: TextAlign.center,
            ),
          ),
          divider,
          Expanded(
            child: value is String
                ? DrawableText(
                    text: value,
                    matchParent: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
                    textAlign: TextAlign.center,
                    fontFamily: FontManager.cairoBold.name,
                    color: AppColorManager.black,
                  )
                : (value is Widget)
                    ? value
                    : DrawableText(
                        text: '-',
                        matchParent: true,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
                        textAlign: TextAlign.center,
                        fontFamily: FontManager.cairoBold.name,
                        color: AppColorManager.black,
                      ),
          )
        ],
      );
      items.add(row);
      items.add(dividerH);
    });

    items.removeAt(items.length - 1);

    return MyCardWidget(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Ink(
            color: AppColorManager.mainColor,
            padding: const EdgeInsets.symmetric(vertical: 3.0).h,
            child: DrawableText(
              matchParent: true,
              textAlign: TextAlign.center,
              text: title,
              color: AppColorManager.whit,
            ),
          ),
          Column(children: items),
        ],
      ),
    );
  }
}

Future<void> _makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}
