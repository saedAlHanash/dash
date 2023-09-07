import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/text_with_list_dote.dart';

class SearchLocationWidget extends StatelessWidget {
  const SearchLocationWidget({Key? key, required this.items, this.onItemClick})
      : super(key: key);

  final List<SearchLocationItem> items;

  final Function(SearchLocationItem item)? onItemClick;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, i) {
        final item = items[i];
        return TextButton(
          onPressed: () => onItemClick?.call(item),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0).h,
            child: TextWithListDote(
              matchParent: true,
              testWidget: DrawableText(
                text: item.name,
                color: AppColorManager.black,
              ),
            ),
          ),
        );
      },
      itemCount: items.length,
    );
  }
}

class SearchLocationItem {
  final String name;
  final LatLng point;
  final bool fromFav;

  SearchLocationItem({
    required this.name,
    required this.point,
    this.fromFav = false,
  });
}
