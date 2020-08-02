import 'package:calendar_list/controller/calendar_list_controller.dart';
import 'package:calendar_list/utils/calendar_util.dart';
import 'package:calendar_list/widgets/month_page.dart';
import 'package:flutter/material.dart';

typedef headerBuilder = Widget Function(
  BuildContext context,
  int year,
  int month,
);

class CalendarList extends StatefulWidget {
  ///日历控制器
  final CalendarListController controller;

  ///构建月份个数
  final int buildMonth;

  //original listView config
  final EdgeInsetsGeometry padding;
  final ScrollPhysics physics;

  CalendarList({
    Key key,
    @required this.controller,
    this.padding = EdgeInsets.zero,
    this.physics = const BouncingScrollPhysics(),
    this.buildMonth = 12 * 20,
  }) : super(key: key);

  @override
  _CalendarListState createState() => _CalendarListState();
}

class _CalendarListState extends State<CalendarList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: widget.physics,
      padding: widget.padding,
      cacheExtent: widget.controller.monthPageConfig.getMonthPageHeight() *
          widget.controller.performanceConfig.buildCacheMonth,
      itemBuilder: (BuildContext context, int index) {
        final year = CalendarUtil.getYearByIndex(
          widget.controller.minYear,
          widget.controller.minMonth,
          index,
        );
        final month = CalendarUtil.getMonthByIndex(
          widget.controller.minMonth,
          index,
        );
        final week = DateTime(year, month, 1).weekday;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('$year\年$month\月'),
            Divider(height: 0.5),
            MonthPage(
              year: year,
              month: month,
              buildDelay: widget.controller.performanceConfig.buildDelay,
              prefixDays: week == 7 ? 0 : week,
              calendarItemBuilder: widget.controller.calendarItemBuilder,
            ),
          ],
        );
      },
      itemCount: widget.buildMonth,
    );
  }
}
