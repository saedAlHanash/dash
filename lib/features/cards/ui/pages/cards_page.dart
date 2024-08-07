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

import '../../../../core/util/my_style.dart';
import '../../bloc/cards_cubit/cards_cubit.dart';
import '../../bloc/delete_card_cubit/delete_card_cubit.dart';

const cardList = [
  'ID',
  'صورة',
  'اسم',
  'وصف',
  'أقصى عدد متوفر',
  'السعر',
  '',
];

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(GoRouteName.createCard),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: BlocBuilder<CardsCubit, CardsInitial>(
        builder: (context, state) {
          if (state.statuses.isLoading) {
            return MyStyle.loadingWidget();
          }
          final list = state.result;
          if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد بطاقات');
          return SingleChildScrollView(
            child: SaedTableWidget(
              command: state.command,
              title: cardList,
              data: list
                  .mapIndexed(
                    (index, e) => [
                      e.id.toString(),
                      Center(
                        child: RoundImageWidget(
                          url: e.image,
                          height: 70.0.r,
                          width: 70.0.r,
                        ),
                      ),
                      e.name,
                      e.description,
                      e.price.formatPrice,
                      e.maxActivationCount.toString(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              context.pushNamed(
                                GoRouteName.createCard,
                                extra: e,
                              );
                            },
                            child: const Icon(
                              Icons.edit,
                              color: Colors.amber,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BlocConsumer<DeleteCardCubit,
                                DeleteCardInitial>(
                              listener: (context, state) {
                                context
                                    .read<CardsCubit>()
                                    .getCards(newData: true);
                              },
                              listenWhen: (p, c) => c.statuses.done,
                              buildWhen: (p, c) => c.request == e.id,
                              builder: (context, state) {
                                if (state.statuses.isLoading) {
                                  return MyStyle.loadingWidget();
                                }
                                return InkWell(
                                  onTap: () {
                                    context
                                        .read<DeleteCardCubit>()
                                        .deleteCard( id: e.id);
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
              onChangePage: (command) {},
            ),
          );
        },
      ),
    );
  }
}
