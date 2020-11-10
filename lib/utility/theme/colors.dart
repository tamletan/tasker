import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF0B0D11);
const Color secondaryColor = Color(0xFF0B0D11);
const Color accentColor = Color(0xFF1976D2);
const Color canvasColor = Color(0xFF242A38);
const Color onHoldColor = Color(0xFF2C313E);
const Color availableColor = Color(0xFF424856);

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}