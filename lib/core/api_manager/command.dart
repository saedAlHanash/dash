import 'package:qareeb_dash/core/extensions/extensions.dart';

class Command {
  Command({
    this.skipCount,
    this.maxResultCount,
  });

  int? skipCount;
  int? maxResultCount;

  factory Command.initial() {
    return Command(maxResultCount: 4, skipCount: 0);
  }

  bool get isInitial => skipCount == 0;

  factory Command.noPagination() {
    return Command(maxResultCount: 1.maxInt, skipCount: 0);
  }

  Map<String, dynamic> toJson() {
    return {
      'skipCount': skipCount,
      'maxResultCount': maxResultCount,
    };
  }

  factory Command.fromJson(Map<String, dynamic> map) {
    return Command(
      skipCount: map['skipCount'] as int,
      maxResultCount: map['maxResultCount'] as int,
    );
  }
}
