import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_super_user/core/strings/app_color_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Saed extends StatefulWidget {
  const Saed({super.key, required this.max, required this.onChange});

  final num max;
  final Function(int count) onChange;

  @override
  State<Saed> createState() => _SaedState();
}

class _SaedState extends State<Saed> {
  int _counter = 1;

  void _incrementCounter() {
    if (_counter + 1 > widget.max) {
      return;
    }
    setState(() => _counter++);
    widget.onChange.call(_counter);
  }

  void _decrementCounter() {
    if (_counter - 1 <= 0) {
      return;
    }
    setState(() => _counter--);
    widget.onChange.call(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13.0.r),
        border:
            Border.all(color: AppColorManager.gray.withOpacity(0.7), width: 1.0.spMin),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10.0).r,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          5.0.verticalSpace,
          Center(
            child: DrawableText(
              text: '$_counter',
              color: Colors.black,
              size: 28.0.sp,
            ),
          ),
          5.0.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: _decrementCounter,
                child: Container(
                  alignment: Alignment.center,
                  width: 40.spMin,
                  height: 40.spMin,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: DrawableText(
                    text: '-',
                    size: 40.0.sp,
                    fontFamily: FontManager.cairoBold,
                    color: Colors.black,
                  ),
                ),
              ),
              40.0.horizontalSpace,
              InkWell(
                onTap: _incrementCounter,
                child: Container(
                  alignment: Alignment.center,
                  width: 40.spMin,
                  height: 40.spMin,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: DrawableText(
                    text: '+',
                    size: 40.0.sp,
                    fontFamily: FontManager.cairoBold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          5.0.verticalSpace,
        ],
      ),
    );
  }
}
