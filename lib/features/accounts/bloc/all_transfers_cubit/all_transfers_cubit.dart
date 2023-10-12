import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/features/accounts/data/response/transfers_response.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'all_transfers_state.dart';

class AllTransfersCubit extends Cubit<AllTransfersInitial> {
  AllTransfersCubit() : super(AllTransfersInitial.initial());

  Future<void> getAllTransfers(BuildContext context, {Command? command}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, command: command));
    final pair = await _getAllTransfersApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      state.command.totalCount = pair.first!.totalCount;
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first!.items));
    }
  }

  Future<Pair<TransfersResult?, String?>> _getAllTransfersApi() async {
    final response = await APIService().getApi(
      url: GetUrl.getAllTransfers,
      query: state.command.toJson(),
    );

    if (response.statusCode == 200) {
      return Pair(TransfersResponse.fromJson(response.json).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  Future<Pair<List<String>, List<List<dynamic>>>?> getDataAsync(
      BuildContext context) async {
    var oldSkipCount = state.command.skipCount;
    state.command
      ..maxResultCount = 1.maxInt
      ..skipCount = 0;

    final pair = await _getAllTransfersApi();
    state.command
      ..maxResultCount = 20
      ..skipCount = oldSkipCount;
    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
    } else {
      return _getXlsData(pair.first!.items);
    }
    return null;
  }

  Pair<List<String>, List<List<dynamic>>> _getXlsData(List<Transfer> data) {
    return Pair(
        [
          '\tمعرف العملية\t',
          '\tنوع العملية\t',
          '\tالمرسل\t',
          '\tالمستقبل\t',
          '\tالمبلغ\t',
          '\tالحالة\t',
          '\tتاريخ العملية\t',
        ],
        data
            .mapIndexed(
              (index, e) => [
                e.id,
                e.type?.arabicName,
                e.sourceName,
                e.destinationName,
                e.amount.formatPrice,
                e.status == TransferStatus.closed ? true : false,
                e.transferDate?.toIso8601String(),
              ],
            )
            .toList());
  }
}
