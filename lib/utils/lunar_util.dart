import 'package:lunar_calendar_converter/lunar_solar_converter.dart';

class LunarUtil {
  static List<String> _lunarMonthList = [
    '正',
    '二',
    '三',
    '四',
    '五',
    '六',
    '七',
    '八',
    '九',
    '十',
    '冬',
    '腊',
  ];

  static List<String> _lunarDayList = [
    '初一',
    '初二',
    '初三',
    '初四',
    '初五',
    '初六',
    '初七',
    '初八',
    '初九',
    '初十',
    '十一',
    '十二',
    '十三',
    '十四',
    '十五',
    '十六',
    '十七',
    '十八',
    '十九',
    '二十',
    '廿一',
    '廿二',
    '廿三',
    '廿四',
    '廿五',
    '廿六',
    '廿七',
    '廿八',
    '廿九',
    '三十',
  ];

  static lunarDayString(Lunar lunar) {
    if (lunar.lunarMonth < 1 || lunar.lunarMonth > 12) {
      return "异常";
    }
    if (lunar.lunarDay < 1 || lunar.lunarDay > 30) {
      return "异常";
    }
    //初一用月份显示
    String leap = lunar.isLeap ? '闰' : '';
    String month = _lunarMonthList[lunar.lunarMonth - 1];
    if (lunar.lunarDay == 1) {
      return '$leap$month月';
    } else {
      return _lunarDayList[lunar.lunarDay - 1];
    }
  }
}
