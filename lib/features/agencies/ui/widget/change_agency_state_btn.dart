import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/util/checker_helper.dart';
import 'package:qareeb_models/agencies/data/response/agency_response.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_button.dart';
import '../../bloc/create_agency_cubit/create_agency_cubit.dart';

class ChangeAgencyStateBtn extends StatelessWidget {
  const ChangeAgencyStateBtn({super.key, required this.user});

  final Agency user;

  @override
  Widget build(BuildContext context) {
    if (!isAllowed(AppPermissions.UPDATE)) return 0.0.verticalSpace;
    return BlocBuilder<CreateAgencyCubit, CreateAgencyInitial>(
      buildWhen: (p, c) => c.request.id == user.id,
      builder: (context, state) {
        if (state.statuses.isLoading) {
          return MyStyle.loadingWidget();
        }

        if (state.statuses.isDone) user.isActive = !user.isActive;

        return InkWell(
          onTap: () {
            context.read<CreateAgencyCubit>()
              ..state.request.initFromAgency(user)
              ..state.request.isActive = state.request.isActive
              ..createAgency(context);
          },
          child: CircleButton(
            color: user.isActive ? Colors.red : Colors.green,
            icon: user.isActive ? Icons.cancel_outlined : Icons.check_circle_outline,
          ),
        );
      },
    );
  }
}
