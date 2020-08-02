import 'package:calendar_list/models/date_model.dart';
import 'package:calendar_list/models/month_page_config.dart';
import 'package:calendar_list/models/performance_config.dart';
import 'package:calendar_list/widgets/month_page.dart';
import 'package:flutter/material.dart';

class CalendarListController {
  int minYear = 2020;
  int minMonth = 1;

  CalendarItemBuilder calendarItemBuilder = (DateModel model) {
    return Text(model.solar.solarDay.toString());
  };

  ///月视图配置
  MonthPageConfig monthPageConfig = MonthPageConfig();

  ///性能配置
  PerformanceConfig performanceConfig = PerformanceConfig();
}
