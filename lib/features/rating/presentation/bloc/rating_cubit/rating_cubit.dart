import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/features/rating/domain/entities/request/rating_request.dart';

import 'package:qareeb_models/global.dart'; import '../../../../../core/strings/enum_manager.dart';
import '../../../../../core/util/note_message.dart';
import '../../../domain/entities/response/rating_response.dart';
import '../../../domain/use_cases/rating_use_case.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingInitial> {
  RatingCubit({required this.useCase}) : super(RatingInitial.initial());

  final RatingUseCase useCase;

  void ratingDriver(BuildContext context,
      {required RatingRequest request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final data = await useCase(request: request);

    data.fold(
      (l) {
        if (context.mounted) {
          NoteMessage.showErrorSnackBar(message: l, context: context);
        }
        emit(state.copyWith(statuses: CubitStatuses.error, error: l));
      },
      (r) => emit(state.copyWith(statuses: CubitStatuses.done, result: r)),
    );
  }
}
