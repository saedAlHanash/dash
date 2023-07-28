import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';

import '../strings/app_color_manager.dart';

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({Key? key, this.onChanged, required this.text})
      : super(key: key);

  final Function(bool)? onChanged;
  final String text;

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  var switchState = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: switchState,
          activeTrackColor: AppColorManager.mainColorLight.withOpacity(0.4),
          inactiveTrackColor: AppColorManager.gray,
          onChanged: (value) {
            if (widget.onChanged != null) widget.onChanged!(value);
            setState(() => switchState = value);
          },
        ),
        DrawableText(
          text: widget.text,
          fontFamily: FontManager.cairoSemiBold,
          color: switchState ? AppColorManager.mainColor : AppColorManager.gray,
        )
      ],
    );
  }
}
