import 'package:flutter/material.dart';
import 'package:qareeb_dash/features/wallet/ui/widget/charging_list_widget.dart';
import 'package:qareeb_dash/features/wallet/ui/widget/payed_list_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../data/response/wallet_response.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key, required this.wallet});

  final WalletResult wallet;

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23.0).w,
      child: Column(
        children: [
          20.0.verticalSpace,
          Container(
            height: 42.h,
            decoration: BoxDecoration(
              boxShadow: MyStyle.lightShadow,
              color: AppColorManager.whit,
              borderRadius: BorderRadius.circular(8.0.r),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0.r),
                color: AppColorManager.mainColor,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: AppColorManager.mainColor,
              tabs: const [
                Tab(text: 'شحنات الزبائن'),
                Tab(text: 'مدفوعات الشركة'),
              ],
            ),
          ),
          10.0.verticalSpace,
          // tab bar view here
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ChargingListWidget(wallet: widget.wallet),
                PayedListWidget(wallet: widget.wallet),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
