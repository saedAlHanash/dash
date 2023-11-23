import 'dart:convert';

import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/features/auth/data/response/login_response.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/trip_process/data/response/trip_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference {
  static const _token = '1';
  static const _myId = '2';
  static const _agencyId = '2851621';
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
  static const _testMode = '117';

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

  static cashAgencyId(int id) {
    _prefs?.setInt(_agencyId, id);
  }

  static int get getAgencyId => _prefs?.getInt(_agencyId) ?? 0;

  static cashUser(UserModel user) async {
    final string = jsonEncode(user);
    await _prefs?.setString(_user, string);
  }

  static cashRole(String id) {
    _prefs?.setString(_role, id);
  }

  static String get getRole {
    _prefs?.getString(_role) ?? 'saed';
    _prefs?.getString(_role) ?? 'saed';
    final s = _prefs?.getString(_role) ?? 'saed';
    return s;
  }

  static UserModel get getUser {
    final string = _prefs?.getString(_user) ?? '{}';

    return UserModel.fromJson(jsonDecode(string));
  }

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

  static void cashPreviousTrips(List<Trip> result) {
    var json = jsonEncode(result);
    _prefs?.setString(_previousTrips, json);
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

  static void logout() {
    _prefs?.remove(_token);
    _prefs?.remove(_myId);
    _prefs?.remove(_phoneNumber);
    _prefs?.remove(_toScreen);
    _prefs?.remove(_policy);
    _prefs?.remove(_previousTrips);
    _prefs?.remove(_profileInfo);
    _prefs?.remove(_trip);
    _prefs?.remove(_fireToken);
    _prefs?.remove(_ime);
    _prefs?.remove(_driverAvailable);
    _prefs?.remove(_wallet);
    _prefs?.remove(_myPermission);
    _prefs?.remove(_user);
    _prefs?.remove(_email);
    // _prefs?.remove(_role);
    // _prefs?.remove(_testMode);
    APIService.reInitial();
  }

  static void cashTrip(Trip? trip) {
    if (trip == null) return;
    _prefs?.setString(_trip, jsonEncode(trip));
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

  static void cashFireToken(String token) {
    _prefs?.setString(_fireToken, token);
  }

  static void cashIme(String ime) => _prefs?.setString(_ime, ime);

  static String getFireToken() {
    return _prefs?.getString(_fireToken) ?? '';
  }

  static String get ime => _prefs?.getString(_ime) ?? '';

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
}

bool get isAgency => AppSharedPreference.getAgencyId != 0;

bool get isQareebAdmin => AppSharedPreference.getUser.roleName.toLowerCase() == 'admin';
