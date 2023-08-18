import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/checker_helper.dart';

import '../../features/admins/ui/widget/admin_data_grid.dart';
import '../../features/auth/bloc/change_user_state_cubit/change_user_state_cubit.dart';

import '../../features/drivers/data/response/drivers_response.dart';
import '../util/my_style.dart';
import 'my_button.dart';

class ChangeUserStateBtn extends StatelessWidget {
  const ChangeUserStateBtn({super.key, required this.user});

  final DriverModel user;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ChangeUserStateCubit, ChangeUserStateInitial>(
      buildWhen: (p, c) => c.id == user.id,
      builder: (context, state) {
        if (state.statuses.loading) {
          return MyStyle.loadingWidget();
        }

        if (state.statuses.done) user.isActive = !user.isActive;

        return InkWell(
          onTap: () {
            context
                .read<ChangeUserStateCubit>()
                .changeUserState(context, id: user.id, userState: !user.isActive);
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
