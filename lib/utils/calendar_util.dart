import 'package:calendar_list/models/date_model.dart';
import 'package:lunar_calendar_converter/lunar_solar_converter.dart';

class CalendarUtil {
  static List<int> _solarMonthCountList = [
    31,
    30,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31,
  ];

  ///今天
  static bool isToday(Solar solar) {
    DateTime dateTime = DateTime.now();
    return dateTime.year == solar.solarYear &&
        dateTime.month == solar.solarMonth &&
        dateTime.day == solar.solarDay;
  }

  static List<DateModel> getMonthDateModels(int year, int month) {
    List<DateModel> models = [];
    for (int i = 0; i < monthDayCount(year, month); i++) {
      Solar solar = Solar(solarYear: year, solarMonth: month, solarDay: i + 1);
      Lunar lunar = LunarSolarConverter.solarToLunar(solar);
      //在初始化阶段计算lunar,isToay 以提高性能
      models.add(
        DateModel(
          solar,
          lunar,
          CalendarUtil.isToday(solar),
        ),
      );
    }
    return models;
  }

  static isLeapYear(int year) {
    return year % 4 == 0;
  }

  static int monthDayCount(int year, int month) {
    if (isLeapYear(year) && month == 2) {
      return 29;
    } else {
      return _solarMonthCountList[month - 1];
    }
  }

  //通过index获取年份
  static int getYearByIndex(int year, int month, int index) {
    if (index < (12 - month + 1)) {
      return year;
    } else
      return year + (index - (12 - month + 1)) ~/ 12 + 1;
  }

  //通过index获取月份
  static int getMonthByIndex(int month, int index) {
    if (index < (12 - month + 1)) {
      return month + index;
    } else {
      return (index - (12 - month + 1)) % 12 + 1;
    }
  }
}
