import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> routes(RouteSettings settings) {
    var screenName = settings.name;

    // screenName = _initToScreen(AppSharedPreference.toScreen(), screenName);

    switch (screenName) {

    }

    return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}

class RouteNames {
  static const splashScreen = '/';
  static const loginScreen = '/2';
  static const confirmCodeScreen = '/3';
  static const signUpScreen = '/4';
  static const passwordScreen = '/5';
  static const mainScreen = '/6';
  static const settings = '/7';
  static const cartScreen = '/8';
  static const policyScreen = '/9';
  static const previousTripsPage = '/10';
  static const ratingPage = '/11';
  static const profilePage = '/12';
  static const updateProfilePage = '/13';
  static const addFavoritePlacePage = '/14';
  static const getFavoritePlacePage = '/15';
  static const contactToUsPage = '/16';
  static const authPage = '/17';
  static const tripInfoPage = '/18';

  static const createSharedTrip = '/23';
  static const sharedTrips = '/24';
  static const activeSharedTrip = '/25';
  static const tripPage = '/26';
  static const chargeWallet = '/27';
  static const myWalletPage = '/28';
  static const debts = '/29';
}
