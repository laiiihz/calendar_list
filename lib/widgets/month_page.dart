import 'dart:async';
import 'dart:isolate';

import 'package:calendar_list/models/date_model.dart';
import 'package:calendar_list/models/month_page_config.dart';
import 'package:calendar_list/utils/calendar_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef CalendarItemBuilder = Widget Function(DateModel model);

class MonthPage extends StatefulWidget {
  final int year;
  final int month;
  final Duration buildDelay;
  final int prefixDays;
  final CalendarItemBuilder calendarItemBuilder;

  MonthPage({
    Key key,
    @required this.year,
    @required this.month,
    @required this.buildDelay,
    this.prefixDays = 0,
    @required this.calendarItemBuilder,
  })  : assert(calendarItemBuilder != null, "必须添加calendarItemBuilder"),
        super(key: key);

  @override
  _MonthPageState createState() => _MonthPageState();
}

class _MonthPageState extends State<MonthPage> {
  List<DateModel> models = [];
  MonthPageConfig monthPageConfig = MonthPageConfig();
  Isolate _isolate;
  Timer _timer;
  bool _buildDone = false;

  @override
  void initState() {
    super.initState();
    //延迟创建isolate
    //列表快速滑动会导致ioslate创建频繁，导致UI卡顿
    _timer = Timer(widget.buildDelay, () => getModelsIsolate());
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
  }

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width / 7;
    return Container(
      height: monthPageConfig.getMonthPageHeight(),
      child: AnimatedOpacity(
        opacity: _buildDone ? 1 : 0,
        duration: Duration(milliseconds: 300),
        child: GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            crossAxisSpacing: monthPageConfig.horizontalPadding,
            mainAxisSpacing: monthPageConfig.verticalPadding,
            childAspectRatio:
                itemWidth / monthPageConfig.getMonthPageHorizontal(),
          ),
          itemBuilder: (BuildContext context, int index) {
            if (index < widget.prefixDays) {
              return SizedBox();
            } else {
              final DateModel dateModel = models[index - widget.prefixDays];
              return widget.calendarItemBuilder(dateModel);
            }
          },
          itemCount: models.length + widget.prefixDays,
        ),
      ),
    );
  }

  Future getModelsIsolate() async {
    ReceivePort receivePort = ReceivePort();

    _isolate = await Isolate.spawn(initCalendarModelsIsolate, {
      'port': receivePort.sendPort,
      'year': widget.year,
      'month': widget.month,
    });

    receivePort.listen((message) {
      // return message;
      models = message;
      _buildDone = true;
      if (mounted) setState(() {});
    });
  }
}

initCalendarModelsIsolate(Map map) {
  List<DateModel> models =
      CalendarUtil.getMonthDateModels(map['year'], map['month']);
  (map['port'] as SendPort).send(models);
}
