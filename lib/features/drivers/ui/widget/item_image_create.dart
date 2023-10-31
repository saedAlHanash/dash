import 'dart:typed_data';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/round_image_widget.dart';

import '../../../../core/util/pick_image_helper.dart';
import 'package:image_multi_type/image_multi_type.dart';

class ItemImageCreate extends StatelessWidget {
  const ItemImageCreate({
    super.key,
    required this.image,
    required this.text,
    this.fileBytes,
    required this.onLoad,
  });

  final String image;
  final Uint8List? fileBytes;
  final Function(Uint8List bytes) onLoad;

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0).w,
      child: InkWell(
        onTap: () async {
          final image = await PickImageHelper().pickImageBytes();
          if (image == null) return;
          onLoad.call(image);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 180.0.r,
              width: 180.0.r,
              child: Center(
                child: Opacity(
                  opacity: fileBytes == null ? 0.3 : 1,
                  child: RoundImageWidget(
                    url:fileBytes?? image,
                    height: fileBytes == null ? 100.0.r : 180.0.r,
                    width: fileBytes == null ? 100.0.r : 180.0.r,
                  ),
                ),
              ),
            ),
            8.0.verticalSpace,
            DrawableText(text: text),
          ],
        ),
      ),
    );
  }
}
