import 'package:calendar_list/controller/calendar_list_controller.dart';
import 'package:calendar_list/models/date_model.dart';
import 'package:calendar_list/widgets/calendar_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalendarTestView(),
    );
  }
}

class CalendarTestView extends StatefulWidget {
  CalendarTestView({Key key}) : super(key: key);

  @override
  _CalendarTestViewState createState() => _CalendarTestViewState();
}

class _CalendarTestViewState extends State<CalendarTestView> {
  CalendarListController _controller;
  @override
  void initState() {
    super.initState();
    _controller = CalendarListController()
      ..minYear = 2020
      ..minMonth = 8
      ..calendarItemBuilder = (DateModel model) {
        return Text(model.solar.solarDay.toString());
      };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CalendarList(
        controller: _controller,
      ),
    );
  }
}
