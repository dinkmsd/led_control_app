import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<_SalesData> data = [
    _SalesData('17:00', 0),
    _SalesData('18:00', 30),
    _SalesData('19:00', 80),
    _SalesData('20:00', 80),
    _SalesData('21:00', 80),
    _SalesData('22:00', 50),
    _SalesData('23:00', 30),
  ];

  final List<ChartData> dimmingData = [
    ChartData('16:00', 0),
    ChartData('17:00', 1),
    ChartData('18:00', 2),
    ChartData('19:00', 4),
    ChartData('20:00', 5),
    ChartData('21:00', 5),
    ChartData('22:00', 4),
    ChartData('23:00', 3),
    ChartData('00:00', 1),
    ChartData('01:00', 1),
    ChartData('02:00', 1),
    ChartData('03:00', 1),
    ChartData('04:00', 1),
    ChartData('05:00', 1),
    ChartData('06:00', 0),
    ChartData('07:00', 0),
  ];

  final List<ChartData> powerData = [
    ChartData('10:00 Su', 0),
    ChartData('11:00 Su', 0),
    ChartData('12:00 Su', 0),
    ChartData('13:00 Su', 0),
    ChartData('14:00 Su', 0),
    ChartData('15:00 Su', 0),
    ChartData('16:00 Su', 0),
    ChartData('17:00 Su', 17),
    ChartData('18:00 Su', 42),
    ChartData('19:00 Su', 100),
    ChartData('20:00 Su', 124),
    ChartData('21:00 Su', 122),
    ChartData('22:00 Su', 99),
    ChartData('23:00 Su', 70),
    ChartData('00:00 Mo', 17),
    ChartData('01:00 Mo', 18),
    ChartData('02:00 Mo', 17),
    ChartData('03:00 Mo', 16),
    ChartData('04:00 Mo', 18),
    ChartData('05:00 Mo', 17),
    ChartData('06:00 Mo', 0),
    ChartData('07:00 Mo', 0),
    ChartData('08:00 Mo', 0),
    ChartData('09:00 Mo', 0),
    ChartData('10:00 Mo', 0),
    ChartData('11:00 Mo', 0),
    ChartData('12:00 Mo', 0),
    ChartData('13:00 Mo', 0),
    ChartData('14:00 Mo', 0),
    ChartData('15:00 Mo', 0),
    ChartData('16:00 Mo', 0),
    ChartData('17:00 Mo', 17),
    ChartData('18:00 Mo', 42),
    ChartData('19:00 Mo', 100),
    ChartData('20:00 Mo', 124),
    ChartData('21:00 Mo', 122),
    ChartData('22:00 Mo', 99),
    ChartData('23:00 Mo', 70),
    ChartData('00:00 Tu', 17),
    ChartData('01:00 Tu', 18),
    ChartData('02:00 Tu', 17),
    ChartData('03:00 Tu', 16),
    ChartData('04:00 Tu', 18),
    ChartData('05:00 Tu', 17),
    ChartData('06:00 Tu', 0),
    ChartData('07:00 Tu', 0),
    ChartData('08:00 Tu', 0),
    ChartData('09:00 Tu', 0),
    ChartData('10:00 Tu', 0),
    ChartData('11:00 Tu', 0),
    ChartData('12:00 Tu', 0),
    ChartData('13:00 Tu', 0),
    ChartData('14:00 Tu', 0),
    ChartData('15:00 Tu', 0),
    ChartData('16:00 Tu', 0),
    ChartData('17:00 Tu', 17),
    ChartData('18:00 Tu', 42),
    ChartData('19:00 Tu', 100),
    ChartData('20:00 Tu', 124),
    ChartData('21:00 Tu', 122),
    ChartData('22:00 Tu', 99),
    ChartData('23:00 Tu', 70),
    ChartData('00:00 We', 17),
    ChartData('01:00 We', 18),
    ChartData('02:00 We', 17),
    ChartData('03:00 We', 16),
    ChartData('04:00 We', 18),
    ChartData('05:00 We', 17),
    ChartData('06:00 We', 0),
    ChartData('07:00 We', 0),
    ChartData('08:00 We', 0),
    ChartData('09:00 We', 0),
    ChartData('10:00 We', 0),
    ChartData('11:00 We', 0),
    ChartData('12:00 We', 0),
    ChartData('13:00 We', 0),
    ChartData('14:00 We', 0),
    ChartData('15:00 We', 0),
    ChartData('16:00 We', 0),
    ChartData('17:00 We', 17),
    ChartData('18:00 We', 42),
    ChartData('19:00 We', 100),
    ChartData('20:00 We', 124),
    ChartData('21:00 We', 122),
    ChartData('22:00 We', 99),
    ChartData('23:00 We', 70),
    ChartData('00:00 Th', 17),
    ChartData('01:00 Th', 18),
    ChartData('02:00 Th', 17),
    ChartData('03:00 Th', 16),
    ChartData('04:00 Th', 18),
    ChartData('05:00 Th', 17),
    ChartData('06:00 Th', 0),
    ChartData('07:00 Th', 0),
    ChartData('08:00 Th', 0),
    ChartData('09:00 Th', 0),
    ChartData('10:00 Th', 0),
    ChartData('11:00 Th', 0),
    ChartData('12:00 Th', 0),
    ChartData('13:00 Th', 0),
    ChartData('14:00 Th', 0),
    ChartData('15:00 Th', 0),
    ChartData('16:00 Th', 0),
    ChartData('17:00 Th', 17),
    ChartData('18:00 Th', 42),
    ChartData('19:00 Th', 100),
    ChartData('20:00 Th', 124),
    ChartData('21:00 Th', 122),
    ChartData('22:00 Th', 99),
    ChartData('23:00 Th', 70),
    ChartData('00:00 Fr', 17),
    ChartData('01:00 Fr', 18),
    ChartData('02:00 Fr', 17),
    ChartData('03:00 Fr', 16),
    ChartData('04:00 Fr', 18),
    ChartData('05:00 Fr', 17),
    ChartData('06:00 Fr', 0),
    ChartData('07:00 Fr', 0),
    ChartData('08:00 Fr', 0),
    ChartData('09:00 Fr', 0),
    ChartData('10:00 Fr', 0),
    ChartData('11:00 Fr', 0),
    ChartData('12:00 Fr', 0),
    ChartData('13:00 Fr', 0),
    ChartData('14:00 Fr', 0),
    ChartData('15:00 Fr', 0),
    ChartData('16:00 Fr', 0),
    ChartData('17:00 Fr', 17),
    ChartData('18:00 Fr', 42),
    ChartData('19:00 Fr', 100),
    ChartData('20:00 Fr', 124),
    ChartData('21:00 Fr', 122),
    ChartData('22:00 Fr', 99),
    ChartData('23:00 Fr', 70),
    ChartData('00:00 Sa', 17),
    ChartData('01:00 Sa', 18),
    ChartData('02:00 Sa', 17),
    ChartData('03:00 Sa', 16),
    ChartData('04:00 Sa', 18),
    ChartData('05:00 Sa', 17),
    ChartData('06:00 Sa', 0),
    ChartData('07:00 Sa', 0),
    ChartData('08:00 Sa', 0),
    ChartData('09:00 Sa', 0),
  ];

  final List<ChartData> lumiData = [
    ChartData('16:00', 0),
    ChartData('17:00', 815),
    ChartData('18:00', 7210),
    ChartData('19:00', 14200),
    ChartData('20:00', 16450),
    ChartData('21:00', 16430),
    ChartData('22:00', 14210),
    ChartData('23:00', 11300),
    ChartData('00:00', 815),
    ChartData('01:00', 820),
    ChartData('02:00', 817),
    ChartData('03:00', 819),
    ChartData('04:00', 816),
    ChartData('05:00', 817),
    ChartData('06:00', 0),
    ChartData('07:00', 0),
  ];

  List<TempData> tempData = [TempData(10, "12h")];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Analysis'),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SfCartesianChart(
                title: ChartTitle(text: "Dimming"),
                primaryXAxis: CategoryAxis(
                  interval: 3,
                ),
                series: <CartesianSeries>[
                  StepLineSeries<ChartData, String>(
                      dataSource: dimmingData,
                      xValueMapper: (ChartData data, _) => data.time,
                      yValueMapper: (ChartData data, _) => data.value)
                ]),
            SfCartesianChart(
                title: ChartTitle(text: "Power consumption (kWh)"),
                primaryXAxis: CategoryAxis(
                  interval: 15,
                ),
                series: <CartesianSeries>[
                  FastLineSeries<ChartData, String>(
                      dataSource: powerData,
                      xValueMapper: (ChartData data, _) => data.time,
                      yValueMapper: (ChartData data, _) => data.value)
                ]),
            SfCartesianChart(
                title: ChartTitle(text: "Brightness (lm)"),
                primaryXAxis: CategoryAxis(
                  interval: 3,
                ),
                series: <CartesianSeries>[
                  FastLineSeries<ChartData, String>(
                      dataSource: lumiData,
                      xValueMapper: (ChartData data, _) => data.time,
                      yValueMapper: (ChartData data, _) => data.value)
                ])
          ]),
        ));
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class TempData {
  TempData(this.value, this.time);
  final String time;
  final double value;
}

class DimmingData {
  DimmingData(this.value, this.time);
  final String time;
  final double value;
}

class ChartData {
  ChartData(this.time, this.value);
  final String time;
  final double value;
}
