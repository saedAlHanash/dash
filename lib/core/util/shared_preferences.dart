import 'dart:convert';

import 'package:qareeb_super_user/core/extensions/extensions.dart';
import 'package:qareeb_super_user/features/super_user/data/response/super_users_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../strings/enum_manager.dart';

class AppSharedPreference {
  static const _token = '1';
  static const _myId = '2';
  static const _phoneNumber = '3';
  static const _toScreen = '4';
  static const _policy = '55151';
  static const _previousTrips = '6';
  static const _profileInfo = '7';
  static const _trip = '8';
  static const _fireToken = '9';
  static const _sendFireToken = '10';
  static const _acceptorIme = '11';
  static const _wallet = '12';
  static const _cart = '13';
  static const _requests = '14';

  static SharedPreferences? _prefs;

  static String get getWalletBalance => (_prefs?.getDouble(_wallet) ?? 0.0).formatPrice;

  static void setWalletBalance(double balance) {
    _prefs?.setDouble(_wallet, balance);
  }

  static init(SharedPreferences preferences) {
    _prefs = preferences;
  }

  static bool isInit() {
    return _prefs != null;
  }

  static cashToken(String token) {
    _prefs?.setString(_token, token);
  }

  static cashPhoneNumber(String phone) {
    _prefs?.setString(_phoneNumber, phone);
  }

  static cashMyId(int id) {
    _prefs?.setInt(_myId, id);
  }

  static String getToken() {
    return _prefs?.getString(_token) ?? '';
  }

  static bool get isLogin => _prefs?.getString(_token)?.isNotEmpty ?? false;

  static String getPhoneNumber() {
    return _prefs?.getString(_phoneNumber) ?? '';
  }

  static int get getMyId {
    return _prefs?.getInt(_myId) ?? 0;
  }

  static cashStateScreen(StateScreen appState) {
    _prefs?.setInt(_toScreen, appState.index);
  }

  static String getIme() {
    return _prefs?.getString(_acceptorIme) ?? '';
  }

  static cashIme(String ime) {
    _prefs?.setString(_acceptorIme, ime);
  }

  static removeCashIme() {
    _prefs?.remove(_acceptorIme);
  }

  static StateScreen getStateScreen() {
    final index = _prefs?.getInt(_toScreen) ?? 0;
    return StateScreen.values[index];
  }

  static cashAcceptPolicy() => _prefs?.setString(_policy, 'true');

  static bool get isAcceptPolicy {
    var s = _prefs?.getString(_policy)?.isNotEmpty ?? false;

    return s;
  }

  static void cashSendFcmToken() {
    _prefs?.setBool(_sendFireToken, true);
  }

  static bool isFcmSent() {
    return _prefs?.getBool(_sendFireToken) ?? false;
  }

  static void clear() {
    _prefs?.clear();
  }

  static void logout() {
    _prefs?.clear();
    cashAcceptPolicy();
  }

  static Future<void> reload() async => await _prefs?.reload();

  static void removeCashedTrip() {
    _prefs?.remove(_trip);
    AppSharedPreference.removeCashIme();
  }

  static void cashFireToken(String token) {
    _prefs?.setString(_fireToken, token);
  }

  static String getFireToken() {
    return _prefs?.getString(_fireToken) ?? '';
  }

  static cashInstitutionId(int id) {
    _prefs?.setString('_institutionId', id.toString());
  }

  static int get getInstitutionId {
    return int.parse(_prefs?.getString('_institutionId') ?? '0');
  }

  static void cashUser(SuperUserModel? first) {
    if (first == null) return;
    cashBusId(first.busId);
    cashInstitutionId(first.institutionId);
    _prefs?.setString(_profileInfo, jsonEncode(first));
  }

  static SuperUserModel get getUser {
    var json = _prefs?.getString(_profileInfo) ?? '{}';
    return SuperUserModel.fromJson(jsonDecode(json));
  }

  static void cashBusId(int busId) {
    _prefs?.setInt('bussId', busId);
  }

  static int get getBusId {
    return _prefs?.getInt('bussId') ?? 0;
  }

  static void updateMembers(List<String> jsonCart) {
    _prefs?.setStringList(_cart, jsonCart);
  }

  static List<String> getJsonListCart() => _prefs?.getStringList(_cart) ?? <String>[];

  static void updateRequests(List<String> jsonCart) {
    _prefs?.setStringList(_requests, jsonCart);
  }

  static List<String> getJsonListRequest() => _prefs?.getStringList(_requests) ?? <String>[];
}
