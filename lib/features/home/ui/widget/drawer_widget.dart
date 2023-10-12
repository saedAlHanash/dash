import "package:universal_html/html.dart";

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';
import 'package:qareeb_dash/features/profile/data/response/profile_info_response.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/images/circle_image_widget.dart';
import '../../../../core/widgets/images/image_multi_type.dart';
import '../../../../generated/assets.dart';
import '../../../../router/app_router.dart';
import '../../../profile/bloc/profile_info_cubit/profile_info_cubit.dart';
class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final spaceIcons = 7.horizontalSpace;
  final spaceItem = 9.horizontalSpace;
  final iconSize = 25.0.spMin;

  var result = AppSharedPreference.getProfileInfo();

  @override
  void initState() {
    if (result == null) {
      context.read<ProfileInfoCubit>().getProfileInfo(context);
      result = ProfileInfoResult.fromJson({});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //region listener

    void onItemClick(String itemName) {
      window.history.back();
      switch (itemName) {
        case AppStringManager.normalTrips:
          Navigator.pushNamed(context, RouteNames.previousTripsPage);
          break;

        case AppStringManager.profile:
          Navigator.pushNamed(context, RouteNames.profilePage);
          break;
        case AppStringManager.sharedTrips:
          Navigator.pushNamed(context, RouteNames.sharedTrips);
          break;
        case AppStringManager.savePlaces:
          Navigator.pushNamed(context, RouteNames.getFavoritePlacePage);
          break;
        case AppStringManager.contactToUs:
          Navigator.pushNamed(context, RouteNames.contactToUsPage);
          break;

        case AppStringManager.wallet:
          Navigator.pushNamed(context, RouteNames.myWalletPage);
          break;
      }
    }

    void onIconClick(String iconName) {
      switch (iconName) {
        case Assets.iconsInstagram:
          // TODO
          break;
        case Assets.iconsLinkedin:
          // TODO
          break;
        case Assets.iconsTwitter:
          // TODO
          break;
        case Assets.iconsFacebook:
          // TODO
          break;
      }
    }

    //endregion

    Widget iconMedia(String icon) {
      return IconButton(
        onPressed: () => onIconClick(icon),
        iconSize: iconSize,
        icon:  ImageMultiType(url:icon),
      );
    }

    Widget itemString(String name, String icon) {
      return TextButton(
        onPressed: () => onItemClick(name),
        child: Row(
          children: [
             ImageMultiType(url:icon, height: iconSize, width: iconSize),
            spaceIcons,
            DrawableText(
              text: name,
              color: AppColorManager.whit,
              size: 20.0.sp,
              fontFamily: FontManager.cairo,
            ),
          ],
        ),
      );
    }

    return BlocListener<ProfileInfoCubit, ProfileInfoInitial>(
      listenWhen: (p, c) => c.statuses == CubitStatuses.done,
      listener: (context, state) => setState(() => result = state.result),
      child: Container(
        width: 1.0.sw,
        padding: EdgeInsets.all(20.0.spMin),
        margin: EdgeInsets.only(bottom: 20.0.h),
        decoration: MyStyle.drawerShape,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  CircleImageWidget(url: result?.avatar),
                  5.0.verticalSpace,
                  DrawableText.title(
                    text: result?.fullName ?? '',
                    color: AppColorManager.whit,
                  ),
                  DrawableText.title(
                    text: result?.phoneNumber ?? '',
                    color: AppColorManager.whit,
                  ),
                  5.0.verticalSpace,
                ],
              ),
              SizedBox(
                width: 1.0.sw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    itemString(
                      AppStringManager.profile,
                      Assets.iconsPerson,
                    ),
                    spaceItem,
                    itemString(
                      AppStringManager.wallet,
                      Assets.iconsWallet,
                    ),
                    spaceItem,
                    itemString(
                      AppStringManager.normalTrips,
                      Assets.iconsHistory,
                    ),
                    spaceItem,
                    itemString(
                      AppStringManager.sharedTrips,
                      Assets.iconsHistory,
                    ),
                    spaceItem,
                    itemString(
                      AppStringManager.contactToUs,
                      Assets.iconsQuastion,
                    ),
                    spaceItem,
                  ],
                ),
              ),
              30.0.verticalSpace,
              DrawableText(
                text: AppStringManager.followUs,
                color: AppColorManager.whit,
                size: 18.0.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  iconMedia(Assets.iconsInstagram),
                  iconMedia(Assets.iconsLinkedin),
                  iconMedia(Assets.iconsTwitter),
                  iconMedia(Assets.iconsFacebook),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
