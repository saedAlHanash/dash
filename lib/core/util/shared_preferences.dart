import 'dart:convert';
import 'dart:typed_data';

import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/profile/data/response/profile_info_response.dart';
import '../strings/enum_manager.dart';

class AppSharedPreference {
  static const _token = '1';
  static const _myId = '2';
  static const _phoneNumber = '3';
  static const _toScreen = '4';
  static const _policy = '5';
  static const _previousTrips = '6';
  static const _profileInfo = '7';
  static const _trip = '8';
  static const _fireToken = '9';
  static const _ime = '10';
  static const _driverAvailable = '11';
  static const _wallet = '12';
  static const _myPermission = '13';
  static const _user = '14';
  static const _email = '15';
  static const _institutionId = 'iid';

  static SharedPreferences? _prefs;

  static String get myPermissions => _prefs?.getString(_myPermission) ?? '';

  static cashPermissions(String permissions) {
    _prefs?.setString(_myPermission, permissions);
  }

  static String get getWalletBalance => (_prefs?.getDouble(_wallet) ?? 0.0).formatPrice;

  static void setWalletBalance(double balance) {
    _prefs?.setDouble(_wallet, balance);
  }

  static bool get isLogin => getToken().isNotEmpty;

  static init(SharedPreferences preferences) {
    _prefs = preferences;
  }

  static bool isInit() {
    return _prefs != null;
  }

  static cashToken(String token) {
    _prefs?.setString(_token, token);
    APIService.reInitial();
  }

  static cashPhoneNumber(String phone) {
    _prefs?.setString(_phoneNumber, phone);
  }

  static cashMyId(int id) {
    _prefs?.setInt(_myId, id);
  }

  static int get getMyId => _prefs?.getInt(_myId) ?? 0;

  static cashInstitutionId(int id) {
    _prefs?.setString('_institutionId', id.toString());
  }

  static int get getInstitutionId {
    return int.parse(_prefs?.getString('_institutionId') ?? '0');
  }

  //
  // static cashUser(LoginResult user) {
  //   final string = jsonEncode(user);
  //   _prefs?.setString(_user, string);
  // }
  //
  // static LoginResult get getUser {
  //   final string = _prefs?.getString(_user) ?? '{}';
  //
  //   return LoginResult.fromJson(jsonDecode(string));
  // }

  static String getToken() {
    return _prefs?.getString(_token) ?? '';
  }

  static String getPhoneNumber() {
    return _prefs?.getString(_phoneNumber) ?? '';
  }

  static cashStateScreen(StateScreen appState) {
    _prefs?.setInt(_toScreen, appState.index);
  }

  static StateScreen getStateScreen() {
    final index = _prefs?.getInt(_toScreen) ?? 0;
    return StateScreen.values[index];
  }

  static cashAcceptPolicy(bool isAccept) {
    if (isAccept == false) cashStateScreen(StateScreen.policy);

    _prefs?.setBool(_policy, isAccept);
  }

  static bool isAcceptPolicy() {
    return _prefs?.getBool(_policy) ?? false;
  }

  static void logout() {
    _prefs?.clear();
    APIService.reInitial();
  }

  static void cashProfileInfo(ProfileInfoResult result) {
    final json = jsonEncode(result);
    _prefs?.setString(_profileInfo, json);
  }

  static ProfileInfoResult? getProfileInfo() {
    var json = _prefs?.getString(_profileInfo);
    if (json == null || json.isEmpty) return null;

    var result = ProfileInfoResult.fromJson(jsonDecode(json));
    return result;
  }

  static Future<void> reload() async => await _prefs?.reload();

  static void removeCashedTrip() {
    _prefs?.remove(_trip);
  }

  static void cashFireToken(String token) {
    _prefs?.setString(_fireToken, token);
  }

  static String getFireToken() {
    return _prefs?.getString(_fireToken) ?? '';
  }

  static void cashDriverAvailable(bool isAvailable) {
    _prefs?.setBool(_driverAvailable, isAvailable);
  }

  static bool isShared() {
    AppSharedPreference.reload();
    return _prefs?.getBool('sh') ?? false;
  }

  static cashShared(bool sh) async {
    _prefs?.setBool('sh', sh);
  }

  static void cashEmail(String email) {
    _prefs?.setString(_email, email);
  }

  static String get getEmail => _prefs?.getString(_email) ?? '';

  static List<String> getIme() {
    return _prefs?.getStringList(_ime) ?? [];
  }

  static cashIme(List<String> ime) {
    _prefs?.setStringList(_ime, ime);
  }

  static cashImage(String url, Uint8List? data) {
    if (data == null) return;

    final fileName = url.split('/').lastOrNull ?? url;

    _prefs?.setStringList(fileName, data.map((byte) => byte.toString()).toList());
  }

  static Uint8List? getImage(String url) {
    final fileName = url.split('/').lastOrNull ?? url;
    final cachedData = _prefs?.getStringList(fileName);

    if (cachedData != null && cachedData.isNotEmpty) {
      final restoredData =
          Uint8List.fromList(cachedData.map((str) => int.parse(str)).toList());
      return restoredData;
    }
    return null;
  }
}
