import 'package:calendar_list/controller/calendar_list_controller.dart';
import 'package:calendar_list/utils/calendar_util.dart';
import 'package:calendar_list/widgets/month_page.dart';
import 'package:flutter/material.dart';

class CalendarList extends StatefulWidget {
  final CalendarListController controller;
  final double itemExtent;
  final int cachedMonth;
  final int buildMonth;

  //original listView config
  final EdgeInsetsGeometry padding;
  final ScrollPhysics physics;

  CalendarList({
    Key key,
    @required this.controller,
    this.itemExtent = 20,
    this.cachedMonth = 6,
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
          widget.cachedMonth,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(CalendarUtil.getYearByIndex(widget.controller.minYear,
                    widget.controller.minMonth, index)
                .toString()),
            MonthPage(
              year: 2020,
              month: 8,
              itemExtent: widget.itemExtent,
            ),
          ],
        );
      },
      itemCount: widget.buildMonth,
    );
  }
}
