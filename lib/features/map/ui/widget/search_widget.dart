import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/features/map/ui/widget/search_location_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../main.dart';
import '../../bloc/search_location/search_location_cubit.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key, required this.onTap});

  final Function(SearchLocationItem location) onTap;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  ///Timer to delay request search
  Timer? _debounce;

  ///Search items list (fav and search from DB and search from osm)
  final list = <SearchLocationItem>[];

  ///search in DB and render list widget
  void search(String val) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 700), () async {
      if (val.isEmpty) setState(() => list.clear());

      if (!val.canSendToSearch) return;

      if (mounted) {
        context.read<SearchLocationCubit>().searchLocation(request: val);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchLocationCubit, SearchLocationInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        var list = state.result
            .map((e) =>
                SearchLocationItem(name: e.displayName, point: LatLng(e.lat, e.lon)))
            .toList();

        setState(() => this.list.addAll(list));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0).r,
        child: SizedBox(
          height: 0.8.sh,
          child: Column(
            children: [
              MyEditTextWidget(
                radios: 15.0.r,
                backgroundColor: AppColorManager.f1,
                hint: AppStringManager.endLocation,
                onChanged: search,
              ),
              Expanded(
                child: SearchLocationWidget(items: list, onItemClick: widget.onTap),
              ),
              BlocBuilder<SearchLocationCubit, SearchLocationInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
                    return MyStyle.loadingWidget();
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
