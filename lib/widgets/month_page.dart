import 'package:calendar_list/models/date_model.dart';
import 'package:calendar_list/models/month_page_config.dart';
import 'package:calendar_list/utils/calendar_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MonthPage extends StatefulWidget {
  final int year;
  final int month;
  final double itemExtent;

  MonthPage({Key key, this.year, this.month, this.itemExtent})
      : super(key: key);

  @override
  _MonthPageState createState() => _MonthPageState();
}

class _MonthPageState extends State<MonthPage> {
  List<DateModel> models = [];
  MonthPageConfig monthPageConfig = MonthPageConfig();

  @override
  void initState() {
    super.initState();
    getModels();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width / 7;
    return Container(
      height: monthPageConfig.getMonthPageHeight(),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: monthPageConfig.horizontalPadding,
          mainAxisSpacing: monthPageConfig.verticalPadding,
          childAspectRatio:
              itemWidth / monthPageConfig.getMonthPageHorizontal(),
        ),
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Text(models[index].solar.solarDay.toString()),
          );
        },
        itemCount: models.length,
      ),
    );
  }

  Future getModels() async {
    models = await compute(initCalendarModel, {
      'year': widget.year,
      'month': widget.month,
    });
    if (mounted) setState(() {});
  }

  static Future<List<DateModel>> initCalendarModel(Map map) async {
    return CalendarUtil.getMonthDateModels(map['year'], map['month']);
  }
}
