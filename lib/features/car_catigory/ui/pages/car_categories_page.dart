import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/round_image_widget.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_dash/router/go_route_pages.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../bloc/all_car_categories_cubit/all_car_categories_cubit.dart';
import '../../bloc/delete_car_cat_cubit/delete_car_cat_cubit.dart';

final _carCatList = [
  'صورة',
  'نوع التصنيف',
  'اسم التصنيف',
  'كيلو\n عادي',
  'كيلو\n تشاركي',
  'متغير السعر',
  'حصة السائق\n عادي',
  'حصة السائق\n تشاركي',
  'الولاء عادي\n زيت \nذهب \n إطارات\n بنزين ',
  'الولاء تشاركي\n زيت \nذهب \n إطارات\n بنزين ',
  'عمليات',
];

class CarCategoriesPage extends StatelessWidget {
  const CarCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAllowed(AppPermissions.CREATION)
          ? FloatingActionButton(
              onPressed: () => context.pushNamed(GoRouteName.createCarCategory),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: BlocBuilder<AllCarCategoriesCubit, AllCarCategoriesInitial>(
        builder: (context, state) {
          if (state.statuses.isLoading) {
            return MyStyle.loadingWidget();
          }
          final list = state.result;
          if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد تصنيفات');
          return SingleChildScrollView(
            child: SaedTableWidget(
              onChangePage: (command) {
                context
                    .read<AllCarCategoriesCubit>()
                    .getCarCategories(context, command: command);
              },
              command: state.command,
              title: _carCatList,
              data: list
                  .mapIndexed(
                    (index, e) => [
                      Center(
                        child: RoundImageWidget(
                          url: e.imageUrl,
                          height: 70.0.r,
                          width: 70.0.r,
                        ),
                      ),
                      e.carCategoryType.arabicName,
                      e.name,
                      e.dayKmOverCost.formatPrice,
                      e.sharedKmOverCost.formatPrice,
                      '${e.priceVariant.formatPrice}%',
                      '${e.driverRatio} %',
                      '${e.sharedDriverRatio} %',
                      // '${e.companyLoyaltyRatio} %',
                      '${e.normalOilRatio}%\n ${e.normalGoldRatio}%\n ${e.normalTiresRatio}%\n ${e.normalGasRatio}%',
                      '${e.sharedOilRatio}%\n ${e.sharedGoldRatio}%\n ${e.sharedTiresRatio}%\n ${e.sharedGasRatio}%',
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: !isAllowed(AppPermissions.UPDATE)
                                ? null
                                : () {
                                    context.pushNamed(GoRouteName.createCarCategory,
                                        extra: e);
                                  },
                            child: const Icon(
                              Icons.edit,
                              color: Colors.amber,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BlocConsumer<DeleteCarCatCubit, DeleteCarCatInitial>(
                              listener: (context, state) {
                                context
                                    .read<AllCarCategoriesCubit>()
                                    .getCarCategories(context);
                              },
                              listenWhen: (p, c) => c.statuses.done,
                              buildWhen: (p, c) => c.id == e.id,
                              builder: (context, state) {
                                if (state.statuses.isLoading) {
                                  return MyStyle.loadingWidget();
                                }
                                return InkWell(
                                  onTap: () {
                                    context
                                        .read<DeleteCarCatCubit>()
                                        .deleteCarCat(context, id: e.id);
                                  },
                                  child: const Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
