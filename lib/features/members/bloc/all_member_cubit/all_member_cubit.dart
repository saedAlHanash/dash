import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/features/members/utile/member_card_utile.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/file_util.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../data/request/member_filter_request.dart';
import '../../data/response/member_response.dart';
import 'dart:async';
import 'dart:isolate';
import 'dart:html';

import 'dart:html';
import 'dart:async';
import 'dart:async';

part 'all_member_state.dart';

class AllMembersCubit extends Cubit<AllMembersInitial> {
  AllMembersCubit() : super(AllMembersInitial.initial());

  Future<void> getMembers(BuildContext context, {Command? command}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, command: command));
    final pair = await _getMembersApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      state.command.totalCount = pair.first!.totalCount;
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first?.items));
    }
  }

  Future<Pair<MembersResult?, String?>> _getMembersApi() async {
    final response = await APIService().getApi(
      url: GetUrl.members,
      query: state.command.toJson(),
    );

    if (response.statusCode == 200) {
      return Pair(MembersResponse.fromJson(response.jsonBody).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  void update() {
    emit(state.copyWith());
  }

  Future<Pair<List<String>, List<List<dynamic>>>?> getMembersAsync(
      BuildContext context) async {
    var oldSkipCount = state.command.skipCount;
    state.command
      ..maxResultCount = 1.maxInt
      ..skipCount = 0;

    final pair = await _getMembersApi();
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

  Future<void> getMembersAsyncPdf(BuildContext context,
      {bool all = true, Pair<int, int>? range}) async {
    var oldSkipCount = state.command.skipCount;

    state.command
      ..maxResultCount = 1.0.maxInt
      ..skipCount = 0;
    if (range != null) {
      state.command.memberFilterRequest ??= MemberFilterRequest();
      state.command.memberFilterRequest?.fromId = range.first;
      state.command.memberFilterRequest?.toId = range.second;
    }

    final pair = await _getMembersApi();
    state.command.memberFilterRequest?.fromId = null;
    state.command.memberFilterRequest?.toId = null;
    state.command
      ..maxResultCount = 40
      ..skipCount = oldSkipCount;

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      return;
    } else {
      if (all) {
        await createCard(pair.first!.items);
      } else {
        if (context.mounted) {
          final list = await _showMultiSelect(context, pair.first!.items);
          await createCard(list);
        }
      }
    }
  }

  Pair<List<String>, List<List<dynamic>>> _getXlsData(List<Member> data) {
    return Pair(
        [
          '\tID\t',
          '\tاسم الطالب\t',
          '\tعنوان الطالب\t',
          '\tاسم المستخدم\t',
          '\tكلمة السر\t',
          '\tرقم الهاتف\t',
          '\tالكلية\t',
          '\tالرقم الوطني\t',
          '\tالرقم الجامعي\t',
          '\tحالة الاشتراك\t',
          '\tتاريخ انتهاء اشترك\t',
        ],
        data
            .mapIndexed(
              (index, element) => [
                element.id,
                element.fullName,
                element.address,
                element.userName,
                element.password,
                element.phoneNo,
                element.facility,
                element.idNumber,
                element.collegeIdNumber,
                element.subscriptions.lastOrNull?.isNotExpired,
                element.subscriptions.lastOrNull?.expirationDate?.formatDate ?? 'لا يوجد',
              ],
            )
            .toList());
  }
}

Future<bool> createCard(List<Member> items) async {
  // final cutList = groupingList(50, items);

  // for(var e  in items){
  if (items.length == 1) {
    return await createSingleCard(items.first);
  }
  final list = await getCardMemberListDispatcher(items);

  if (list.isEmpty) return false;
  final pdf = pw.Document();
  var gList = groupingList(5, list);
  for (var e in gList) {
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            children: e.map((e) => e).toList(),
          );
        },
        pageFormat: const PdfPageFormat(
          21.0 * PdfPageFormat.cm,
          29.7 * PdfPageFormat.cm,
          marginAll: 1.0 * PdfPageFormat.cm,
        ),
      ),
    );
  }

  final svgBytes = await pdf.save();

  saveFilePdf(pdfInBytes: svgBytes);
  // }

  return true;
}

Future<bool> createSingleCard(Member items) async {
  final list = <pw.Widget>[await getCardMember(items)];

  if (list.isEmpty) return false;
  final pdf = pw.Document();
  var gList = groupingList(5, list);
  for (var e in gList) {
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            children: e.map((e) => e).toList(),
          );
        },
        pageFormat: const PdfPageFormat(
          21.0 * PdfPageFormat.cm,
          29.7 * PdfPageFormat.cm,
          marginAll: 1.0 * PdfPageFormat.cm,
        ),
      ),
    );
  }

  final svgBytes = await pdf.save();

  saveFilePdf(pdfInBytes: svgBytes);

  return true;
}

Future<List<Member>> _showMultiSelect(BuildContext context, List<Member> items) async {
  List<Member> finalList = [];
  final selected = <int>[];
  await showDialog(
    context: context,
    builder: (ctx) {
      return MultiSelectDialog(
        items: items.mapIndexed(
          (i, e) {
            return MultiSelectItem<int>(e.id, e.fullName);
          },
        ).toList(),
        initialValue: selected,
        searchable: true,
        onConfirm: (values) {
          selected
            ..clear()
            ..addAll(values);
        },
      );
    },
  );
  for (var e in items) {
    if (selected.contains(e.id)) {
      finalList.add(e);
    }
  }
  return finalList;
}

Future<List<pw.Widget>> processBatch(List<Member> batch) async {
  final cards = <pw.Widget>[];

  for (var item in batch) {
    final card = await getCardMember(item);
    cards.add(card);
  }

  return cards;
}

Future<List<pw.Widget>> getCardMemberListDispatcher(List<Member> items) async {
  var batchSize = items.length ~/ 2;
  final batches = <List<Member>>[];

  // Divide the items into batches
  for (var i = 0; i < items.length; i += batchSize) {
    final batch =
        items.sublist(i, i + batchSize < items.length ? i + batchSize : items.length);
    batches.add(batch);
  }

  final results = <Future<List<pw.Widget>>>[];

  // Process each batch in parallel
  for (var batch in batches) {
    final result = processBatch(batch);
    results.add(result);
  }

  final allCards = await Future.wait(results);
  final flattenedCards = allCards.expand((cards) => cards).toList();

  loggerObject.wtf(flattenedCards.length);
  return flattenedCards;
}
