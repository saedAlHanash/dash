import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_models/points/data/model/trip_point.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/text_with_list_dote.dart';

class SearchLocationWidget extends StatelessWidget {
  const SearchLocationWidget({Key? key, required this.items, this.onItemClick})
      : super(key: key);

  final List<TripPoint> items;

  final Function(TripPoint item)? onItemClick;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const NotFoundWidget(text: 'لا توجد نقاط مرتبطة بآخر نقطة تم اختيارها');
    }
    return ListView.builder(
      itemBuilder: (context, i) {
        final item = items[i];
        return TextButton(
          onPressed: () => onItemClick?.call(item),
          child: TextWithListDote(
            matchParent: true,
            testWidget: DrawableText(
              text: item.arName,
              color: AppColorManager.gray,
            ),
          ),
        );
      },
      itemCount: items.length,
    );
  }
}
