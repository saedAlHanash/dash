import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../generated/assets.dart';

class LogoText extends StatelessWidget {
  const LogoText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ImageMultiType(url:
      Assets.iconsTextLogo,
      width: 140.0.w,
      height: 30.0.h,
    );
  }
}
