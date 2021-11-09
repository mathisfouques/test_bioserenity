import 'dart:ui';

double truncateToOneDecimal(double withDecimals) {
  return (withDecimals * 10).ceil() / 10;
}

const Color dark = Color(0xFF282828);
