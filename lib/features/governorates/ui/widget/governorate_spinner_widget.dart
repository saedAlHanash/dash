import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../../areas/bloc/areas_cubit/areas_cubit.dart';
import '../../bloc/governorates_cubit/governorates_cubit.dart';

class GovernorateSpinnerWidget extends StatefulWidget {
  const GovernorateSpinnerWidget({super.key, required this.onSelect});

  final Function(List<int> ariaId) onSelect;

  @override
  State<GovernorateSpinnerWidget> createState() => _GovernorateSpinnerWidgetState();
}

class _GovernorateSpinnerWidgetState extends State<GovernorateSpinnerWidget> {
  var gIds = 0;
  final aIds = <int>[];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<GovernoratesCubit, GovernoratesInitial>(
          builder: (context, state) {
            if (state.statuses.isLoading) {
              return MyStyle.loadingWidget();
            }

            return SpinnerWidget(
              items: state.getSpinnerItems(selectedId: gIds),
              width: 500.0.w,
              sendFirstItem: state.result.isNotEmpty,
              onChanged: (spinnerItem) {
                context.read<AreasCubit>().getArea(context, id: spinnerItem.id);
              },
            );
          },
        ),
        15.0.horizontalSpace,
        BlocBuilder<AreasCubit, AreasInitial>(
          builder: (context, state) {
            if (state.statuses.isLoading) {
              return MyStyle.loadingWidget();
            }
            if (state.result.isEmpty) return 0.0.verticalSpace;

            return MultiSelectDialogField(
              buttonText: const Text('المناطق'),
              searchable: true,
              items: state.getSpinnerItems().mapIndexed(
                (i, e) {
                  return MultiSelectItem<int>(e.id, e.name ?? '-');
                },
              ).toList(),
              initialValue: aIds,
              onConfirm: (values) {
                aIds
                  ..clear()
                  ..addAll(values);

                widget.onSelect.call(aIds);
              },
            );
          },
        ),
      ],
    );
  }
}
