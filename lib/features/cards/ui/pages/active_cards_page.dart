import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../router/go_route_pages.dart';
import '../../bloc/active_cards_cubit/active_cards_cubit.dart';

final activeCardsTableHeader = [
  "id",
  "اسم البطاقة",
  "اسم الزبون",
  "رقم هاتف الزبون",
  "تاريخ التسجيل",
  "عنوان الزبون",
];

class ActiveCardsPage extends StatefulWidget {
  const ActiveCardsPage({Key? key}) : super(key: key);

  @override
  State<ActiveCardsPage> createState() => _ActiveCardsPageState();
}

class _ActiveCardsPageState extends State<ActiveCardsPage> {
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<ActiveCardsCubit, ActiveCardsInitial>(
              builder: (_, state) {
                if (state.statuses.isLoading) {
                  return MyStyle.loadingWidget();
                }
                final list = state.result;
                if (state.result.isEmpty) {
                  return const NotFoundWidget(text: 'لا يوجد حجوزات');
                }

                return SaedTableWidget(
                  onChangePage: (command) {},
                  command: state.filterRequest,
                  title: activeCardsTableHeader,
                  data: list
                      .mapIndexed(
                        (index, e) => [
                          e.cardId.toString(),
                          e.card.name,
                          InkWell(
                            onTap: () {
                              context.pushNamed(
                                GoRouteName.clientInfo,
                                queryParams: {'id': e.id.toString()},
                              );
                            },
                            child: DrawableText(
                              selectable: true,
                              size: 17.0.sp,
                              matchParent: true,
                              textAlign: TextAlign.center,
                              text: e.user.name,
                              color: Colors.black,
                              fontFamily: FontManager.cairoBold.name,
                            ),
                          ),
                          e.user.phoneNumber,
                          e.date?.formatDateTime,
                          InkWell(
                            onTap: () {},
                            child: const CircleButton(
                              color: Colors.grey,
                              icon: Icons.info_outline_rounded,
                            ),
                          ),
                        ],
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
