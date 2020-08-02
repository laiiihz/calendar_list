import 'package:flutter/cupertino.dart';

class MonthPageConfig {
  double itemExtened = 40;
  double verticalPadding = 5;
  double horizontalPadding = 5;
  static int MAX_MONTH_WEEK = 6;
  double getMonthPageHeight() {
    return (itemExtened + verticalPadding * 2) * 6;
  }

  double getMonthPageHorizontal() {
    return itemExtened + verticalPadding * 2;
  }
}
