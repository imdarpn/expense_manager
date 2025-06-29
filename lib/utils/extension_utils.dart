import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'animation_util/domino_reveal.dart';

extension FormatAmount on double? {
  /// Format with $ sign and 2 decimal point
  ///
  /// - [ print(15.3.formatAmount()); ] output: $15.30
  ///
  /// - [ print(15.formatAmount()); ] output: $15.00
  String formatAmount() {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(name: '');

    if (this == null) {
      return numberFormat.format(0);
    }
    return numberFormat.format(this);
  }
}

extension FormatNumber on int {
  /// Format int with comma separated value
  /// - [ print(1503.formatNumber()); ] output: 1,530
  /// - [ print(15032003.formatNumber()); ] output: 15,032,003
  String formatNumber() {
    return NumberFormat().format(this);
  }
}

/// add
extension DominoAnimation on Widget {
  Widget addDominoEffect({bool isLeftToRight = false, bool isEnabled = true}) {
    return DominoReveal(
      isLeftToRight: isLeftToRight,
      allowAnimation: isEnabled,
      child: this,
    );
  }
}

extension DateExtension on DateTime {
  DateTime copyTime(TimeOfDay from) {
    return DateTime(year, month, day, from.hour, from.minute);
  }

  bool isSameDate(DateTime other) {
    return isSameMonth(other) &&
        day == other.day;
  }

  bool isSameMonth(DateTime other) {
    return year == other.year &&
        month == other.month;
  }

  String formatDate() {
    return DateFormat("dd-MM-yyyy").format(this);
  }

  String formatTime() {
    return DateFormat("hh:mm a").format(this);
  }
}
