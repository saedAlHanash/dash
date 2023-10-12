import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_dash/features/governorates/ui/widget/governorate_spinner_widget.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../../core/util/my_style.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../areas/bloc/areas_cubit/areas_cubit.dart';
import '../../data/request/notification_request.dart';

class NotificationsFilterWidget extends StatefulWidget {
  const NotificationsFilterWidget({super.key, this.onApply, this.request});

  final Function(NotificationRequest request)? onApply;

  final NotificationRequest? request;

  @override
  State<NotificationsFilterWidget> createState() => _NotificationsFilterWidgetState();
}

class _NotificationsFilterWidgetState extends State<NotificationsFilterWidget> {
  late NotificationRequest request;

  @override
  void initState() {
    request = widget.request ?? NotificationRequest();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AreasCubit>()),
      ],
      child: Container(
        padding: const EdgeInsets.all(30.0).r,
        margin: const EdgeInsets.all(30.0).r,
        decoration: MyStyle.outlineBorder,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                SpinnerWidget(
                  items: UserType.values.spinnerItems(selected: request.userType),
                  hint: const DrawableText(
                    text: 'نوع المستخدم',
                  ),
                  onChanged: (p0) {
                    request.userType = p0.item;
                    widget.onApply?.call(request);
                  },
                ),
                15.0.horizontalSpace,
                GovernorateSpinnerWidget(
                  onSelect: (ariaId) {
                    request.areaIds = ariaId.second;
                    request.governorateId = ariaId.first;
                    widget.onApply?.call(request);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
