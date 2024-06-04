import 'dart:convert';

import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_models/auth/data/response/login_response.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/trip_process/data/response/trip_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'checker_helper.dart';

class AppSharedPreference {
  static const _token = '-1';
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
  static const _role = '16';
  static const _distanceDriverRange = '17';
  static const _identifier = '18';
  static const _agencyId = '19';

  static SharedPreferences? _prefs;

  static String get myPermissions => _prefs?.getString(_myPermission) ?? '';

  static cashPermissions(String permissions) async {
    await _prefs?.setString(_myPermission, permissions);
  }

  static String get getWalletBalance => (_prefs?.getDouble(_wallet) ?? 0.0).formatPrice;

  static Future<void> setWalletBalance(double balance) async {
   await _prefs?.setDouble(_wallet, balance);
  }

  static bool get isLogin => getToken().isNotEmpty;

  static init(SharedPreferences preferences) {
    _prefs = preferences;
  }

  static bool isInit() {
    return _prefs != null;
  }

  static cashToken(String token) async {
    await _prefs?.setString(_token, token);
    APIService.reInitial();
  }

  static cashPhoneNumber(String phone) async {
   await _prefs?.setString(_phoneNumber, phone);
  }

  static cashMyId(int id) async {
    await _prefs?.setInt(_myId, id);
  }

  static  distanceDriverRange(int? range)  async {
    if (range == null) return;
   await _prefs?.setInt(_distanceDriverRange, range);
  }

  static int get getDistanceDriverRange => _prefs?.getInt(_distanceDriverRange) ?? 1000;

  static int get getMyId => _prefs?.getInt(_myId) ?? 0;

  static cashAgencyId(int id) async {
    await _prefs?.setInt(_agencyId, id);
  }

  static int get getAgencyId => _prefs?.getInt(_agencyId) ?? 0;

  static cashIdentifier(String id) async {
   await _prefs?.setString(_identifier, id);
  }

  static String get getIdentifier => _prefs?.getString(_identifier) ?? '';

  static cashUser(LoginResult user) async {
    final string = jsonEncode(user);
    await _prefs?.setString(_user, string);
  }

  static cashRole(String id) async {
   await _prefs?.setString(_role, id);
  }

  static String get getRole {
    _prefs?.getString(_role) ?? 'saed';
    _prefs?.getString(_role) ?? 'saed';
    final s = _prefs?.getString(_role) ?? 'saed';
    return s;
  }

  static LoginResult get getUser {
    final string = _prefs?.getString(_user) ?? '{}';

    return LoginResult.fromJson(jsonDecode(string));
  }

  static String getToken() {
    return _prefs?.getString(_token) ?? '';
  }

  static String getPhoneNumber() {
    return _prefs?.getString(_phoneNumber) ?? '';
  }

  static cashStateScreen(StateScreen appState) async {
   await _prefs?.setInt(_toScreen, appState.index);
  }

  static StateScreen getStateScreen() {
    final index = _prefs?.getInt(_toScreen) ?? 0;
    return StateScreen.values[index];
  }

  static cashAcceptPolicy(bool isAccept) async {
    if (isAccept == false) cashStateScreen(StateScreen.policy);

   await _prefs?.setBool(_policy, isAccept);
  }

  static bool isAcceptPolicy() {
    return _prefs?.getBool(_policy) ?? false;
  }

  static Future<void> cashPreviousTrips(List<Trip> result) async {
    var json = jsonEncode(result);
   await _prefs?.setString(_previousTrips, json);
  }

  static List<Trip> getPreviousTrips() {
    var json = _prefs?.getString(_previousTrips);
    if (json == null || json.isEmpty) return [];
    dynamic f = jsonDecode(json);
    var result = List<Trip>.from(f.map((x) => Trip.fromJson(x)));
    return result;
  }

  static void clear() {
    _prefs?.clear();
  }

  static Future<void> logout() async {
   await _prefs?.remove(_token);
   await _prefs?.remove(_myId);
   await _prefs?.remove(_phoneNumber);
   await _prefs?.remove(_toScreen);
   await _prefs?.remove(_policy);
   await _prefs?.remove(_previousTrips);
   await _prefs?.remove(_profileInfo);
   await _prefs?.remove(_trip);
   await _prefs?.remove(_fireToken);
   await _prefs?.remove(_ime);
   await _prefs?.remove(_driverAvailable);
   await _prefs?.remove(_wallet);
   await _prefs?.remove(_myPermission);
   await _prefs?.remove(_user);
   await _prefs?.remove(_email);
    // _prefs?.remove(_role);
    // _prefs?.remove(_testMode);
    APIService.reInitial();
  }

  static Future<void> cashTrip(Trip? trip) async {
    if (trip == null) return;
   await _prefs?.setString(_trip, jsonEncode(trip));
  }

  static Future<void> reload() async => await _prefs?.reload();

  static Trip getCashedTrip() {
    var json = _prefs?.getString(_trip);
    if (json == null || json.isEmpty) return Trip.fromJson({});

    return Trip.fromJson(jsonDecode(json));
  }

  static void removeCashedTrip() {
    _prefs?.remove(_trip);
  }

  static Future<void> cashFireToken(String token) async {
   await _prefs?.setString(_fireToken, token);
  }

  static Future<void> cashIme(String ime) async =>await _prefs?.setString(_ime, ime);

  static String getFireToken() {
    return _prefs?.getString(_fireToken) ?? '';
  }

  static String get ime => _prefs?.getString(_ime) ?? '';

  static Future<void> cashDriverAvailable(bool isAvailable) async {
   await _prefs?.setBool(_driverAvailable, isAvailable);
  }

  static bool isShared() {
    AppSharedPreference.reload();
    return _prefs?.getBool('sh') ?? false;
  }

  static cashShared(bool sh) async {
   await _prefs?.setBool('sh', sh);
  }

  static Future<void> cashEmail(String email) async {
    await _prefs?.setString(_email, email);
  }

  static String get getEmail => _prefs?.getString(_email) ?? '';
}

bool get isTrans =>
    AppSharedPreference.myPermissions.contains(AppPermissions.trans) && !isQareebAdmin;

bool get isAgency => AppSharedPreference.getAgencyId != 0;

bool get isQareebAdmin => AppSharedPreference.getUser.roleName.toLowerCase() == 'admin';
