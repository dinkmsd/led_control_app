import 'package:flutter/material.dart';
import 'package:led_control_app/models/chart_model.dart';
import 'package:led_control_app/utils/mock_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
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
                  interval: 15,
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
          ]),
        ));
  }
}
