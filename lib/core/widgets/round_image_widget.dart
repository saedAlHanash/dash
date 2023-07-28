import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/assets.dart';

class RoundImageWidget extends StatelessWidget {
  const RoundImageWidget({
    Key? key,
    required this.url,
    this.height,
    this.width,
  }) : super(key: key);

  final String url;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(12.0.r),
        child: CachedNetworkImage(
          imageUrl: url,
          filterQuality: FilterQuality.low,
          fit: BoxFit.cover,
          placeholder: (context, url) {
            return Image.asset(
              Assets.iconsTextLogo,
              color: Colors.white.withOpacity(0.6),
            );
          },
          errorWidget: (context, url, error) {
            return Image.asset(
              Assets.iconsLogoWithText,
              color: Colors.white.withOpacity(0.6),
            );
          },
        ),
      ),
    );
  }
}
