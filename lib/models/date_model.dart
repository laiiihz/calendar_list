import 'package:calendar_list/utils/calendar_util.dart';
import 'package:calendar_list/utils/lunar_util.dart';
import 'package:lunar_calendar_converter/lunar_solar_converter.dart';

class DateModel {
  Solar solar;
  Lunar lunar;
  bool isToday;
  DateModel(this.solar, this.lunar, this.isToday);

  String getLunarString() {
    return LunarUtil.lunarDayString(lunar);
  }
}
