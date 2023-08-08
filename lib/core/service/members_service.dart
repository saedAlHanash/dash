import 'dart:convert';

import '../../features/super_user/data/response/member_response.dart';
import '../util/shared_preferences.dart';

class UsersService {
  List<Member> _users = [];
  final List<String> _usersIds = [];

  List<Member> get users {

    if (_users.isEmpty) {
      _users = getMembers();
    }
    return _users;
  }
  List<String> get usersIds {
    if (_usersIds.isEmpty) {
      getMembers();
    }

    return _usersIds;
  }

  int get getCounts => AppSharedPreference.getJsonListCart().length;

  void addMembers(List<Member> user) {
    AppSharedPreference.updateMembers(_convertToListString(user));
  }

  List<Member> getMembers() {
    _usersIds.clear();
    final list = AppSharedPreference.getJsonListCart();
    final productList = <Member>[];
    for (var e in list) {
     final m = Member.fromJson(jsonDecode(e));
     _usersIds.add(m.id.toString());
      productList.add(m);
    }
    return productList;
  }

  List<String> _convertToListString(List<Member> list) {
    return List<String>.from(list.map((e) => jsonEncode(e))).toList();
  }
}
