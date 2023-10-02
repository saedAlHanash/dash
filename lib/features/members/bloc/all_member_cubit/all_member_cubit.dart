import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../../../auth/ui/pages/login_page.dart';
import '../../data/response/member_response.dart';

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

  Future<bool> getMembersAsyncPdf(BuildContext context) async {
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
      return false;
    } else {
      final list = <pw.Widget>[];
      for (var e in pair.first!.items) {
        list.add(await getCardMember(e));
      }
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