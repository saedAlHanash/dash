import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/widgets/logo_text.dart';
import '../../../../core/widgets/map_background_widget.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../generated/assets.dart';
import '../../../../router/app_router.dart';
import '../../../profile/bloc/profile_info_cubit/profile_info_cubit.dart';
// import '../../../trip/bloc/driver_status_cubit/driver_status_cubit.dart';
import '../widget/drawer_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //region listeners

    void onDrawerClick() {
      NoteMessage.showBottomSheet(
          context,
          BlocProvider<ProfileInfoCubit>.value(
            value: context.read<ProfileInfoCubit>(),
            child: const DrawerWidget(),
          ));
    }
    //endregion

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 50.0.h,
            child: Transform.scale(
              scale: 1.3,
              child: const LogoText(),
            ),
          ),
          MapBackgroundWidget(height: 530.0.h),
          Positioned(
            width: 412.0.w,
            height: 412.0.h,
            bottom: 200.0.h,
            child: Lottie.asset(
              Assets.lottiesMochup02Location,
            ),
          ),
          Positioned(
            bottom: 40.0.h,
            child: Column(
              children: [
                10.0.verticalSpace,
                MyButton(
                  text: AppStringManager.createSharedTrip,
                  color: AppColorManager.mainColor,
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.createSharedTrip);
                  },
                ),
                10.0.verticalSpace,
                IconButton(
                  onPressed: onDrawerClick,
                  icon: Icon(
                    Icons.menu_outlined,
                    size: 40.spMin,
                    color: AppColorManager.mainColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
