import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_models/global.dart';

import '../api_manager/command.dart';
import 'package:qareeb_models/global.dart'; import '../strings/enum_manager.dart';
import '../util/my_style.dart';
import 'my_button.dart';

class LoadMoreWidget extends StatelessWidget {
  const LoadMoreWidget({
    Key? key,
    required this.child,
    required this.length,
    required this.totalCount,
    this.statuses = CubitStatuses.init,
    required this.onNewCommand,
    required this.command,
  }) : super(key: key);

  final Widget child;
  final int length;
  final int totalCount;
  final CubitStatuses statuses;
  final Command command;
  final Function(Command command) onNewCommand;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        child,
        10.0.verticalSpace,
        if (length < totalCount)
          Builder(builder: (context) {
            if (statuses == CubitStatuses.loading) {
              return MyStyle.loadingWidget();
            }
            return MyButton(
              width: 177.0.w,
              text: 'تحميل المزيد',
              onTap: () {
                command.skipCount = (command.skipCount ?? 0) + 10;
                onNewCommand(command);
              },
            );
          }),
        20.0.verticalSpace,
      ],
    );
  }
}
