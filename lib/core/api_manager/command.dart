import 'package:qareeb_super_user/core/extensions/extensions.dart';

import '../util/shared_preferences.dart';
import '../widgets/spinner_widget.dart';


class Command {
  Command({
    this.skipCount,
    this.totalCount,
  });

  int? skipCount;
  int maxResultCount = 20;
  int? totalCount;


  int get maxPages => ((totalCount ?? 0) / maxResultCount).myRound;

  int get currentPage => ((skipCount ?? 0) + 1 / maxResultCount).myRound;

  List<SpinnerItem> get getSpinnerItems {
    final list = <SpinnerItem>[];

    for (var i = 1; i <= maxPages; i++) {
      list.add(SpinnerItem(
        id: i,
        name: i.toString(),
        isSelected: i == currentPage,
        enable: i != currentPage,
      ));
    }
    return list;
  }

  void goToPage(int pageIndex) {
    skipCount = (pageIndex - 1) * maxResultCount;
  }

  factory Command.initial() {
    return Command(
      skipCount: 0,
      totalCount: 0,
    );
  }

  bool get isInitial => skipCount == 0;

  factory Command.noPagination() {
    return Command(skipCount: 0)..maxResultCount = 1.0.maxInt;
  }

  Map<String, dynamic> toJson() {
    return {
      'skipCount': skipCount,
      'maxResultCount': maxResultCount,
      'InstitutionId': AppSharedPreference.getInstitutionId,
    };
  }

  factory Command.fromJson(Map<String, dynamic> map) {
    return Command(
      skipCount: map['skipCount'] as int,
    );
  }
}
