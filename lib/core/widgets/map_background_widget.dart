import 'package:flutter/material.dart';
import 'package:qareeb_super_user/generated/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapBackgroundWidget extends StatelessWidget {
  const MapBackgroundWidget({Key? key, this.height, this.color})
      : super(key: key);

  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0.0,
      width: 1.0.sw,
      height: height ?? 1.sh,
      child: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage(Assets.iconsMapBackgroundAlpha),
          ),
          color: color ?? Colors.blue.withOpacity(0.08),
        ),
      ),
    );
  }
}
