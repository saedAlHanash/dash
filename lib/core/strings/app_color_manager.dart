import 'dart:ui';

import 'package:flutter/material.dart';

class AppColorManager {
  static const mainColor = Color(0xFF4CA243);
  static const mainColorDark = Color(0xFF008543);
  static const mainColorLight = Color(0xFF8BB93E);
  static const black = Color(0xFF000000);
  static const ampere = Color(0xFFFFC107);
  static const gray = Color(0xFF848484);
  static const lightGray = Color(0xFFF5F5F5);
  static const offWhit = Color(0xFFF1F1F1);
  static const whit = Color(0xFFFFFFFF);
  static const red = Color(0xFFC60000);
  static const f1 = Color(0xFFF9F9F9);
  static const cardColor = Color(0xFFEFEFEF);

  static Color getPolyLineColor(int i) {
    if (i >= polyLineColors.length) {
      return black;
    }
    return polyLineColors[i];
  }

  static const polyLineColors = [
    Color(0xFF67FF00),
    Color(0xFF002AFF),
    Color(0xFF660072),
    red,
    Color(0xFFBB9600),
    Color(0xFF01914A),
    Color(0xFFBB5D00),
    Color(0xFF02ADAD),
    Color(0xFF008543),
    Color(0xFF03DADA),
    Color(0xFF03CE6A),
    Color(0xFF00FF81),
    Color(0xFFBB9600),
    Color(0xFF098000),
    Color(0xFFBB9600),
    Color(0xFF0BB000),
    Color(0xFF0BCE00),
    Color(0xFF10FF00),
    Color(0xFF008383),
    Color(0xFF03DADA),
    Color(0xFF03DADA),
    Color(0xFF03DADA),
    Color(0xFF03DADA),
    Color(0xFF03DADA),
    Color(0xFF03DADA),
    Color(0xFF03DADA),
    Color(0xFF03DADA),
    Color(0xFF03DADA),
    Color(0xFF03DADA),
    Color(0xFF03DADA),
    Color(0xFF03DADA),
    Color(0xFF03DADA),
  ];
}

Color getPolyLineColor(int i) {
  if (i > AppColorManager.polyLineColors.length - 1) {
    return AppColorManager.black;
  }
  return AppColorManager.polyLineColors[i];
}

/*
    <color name="purple_200">#8BB93E</color>
    <color name="purple_500">#4CA243</color>
    <color name="purple_700">#008543</color>
    <color name="teal_200">#FFC107</color>
    <color name="teal_700">#A17A05</color>
    <color name="black">#000000</color>
    <color name="white">#FFFFFFFF</color>
    <color name="TRANSPARENT">#00000000</color>
    <color name="back_fill_F6">#F6F6F6</color>
    <color name="back_fill_F1">#F1F1F1</color>
    <color name="back_fill_F5">#F5F5F5</color>
    <color name="ampere">#FFC107</color>
    <color name="dark_ampere">#A17A05</color>
    <color name="light_ampere">#45FFD24C</color>
    <color name="ampere_bg">#EDB100</color>
    <color name="red">#F10303</color>
    <color name="light_gray">#F5F5F5</color>
    <color name="light_gray_alpha">#CCF1F1F1</color>
    <color name="light_bg">#E8E3E3</color>
    <color name="transparency_gray">#CCF1F1F1</color>
    <color name="orange">#EDB100</color>
    <color name="blur">#F1F1F1</color>
    <color name="gray">#FF8F8F8F</color>
    <color name="off_white">#F1F1F1</color>
    <color name="dark_green">#008543</color>
    <color name="green">#4CA243</color>
    <color name="light_green">#8BB93E</color>
    <color name="light_green_2">#D9FF9A</color>

 */
