import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  List<TemperatureData> generateRandomData(int count) {
    final random = Random();
    final List<TemperatureData> data = [];

    for (int i = 0; i < count; i++) {
      final DateTime time = DateTime(2023, 10, 2, i, 0);
      final double temperature = 20 + random.nextDouble() * 10;
      data.add(TemperatureData(time, temperature));
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    final List<TemperatureData> data = generateRandomData(50 + Random().nextInt(51));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width / 2.3,
                decoration: BoxDecoration(
                  // color: Colors.cyan,
                  color: Color.fromRGBO(203, 197, 255, 1.0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row( // Wrap with a Row
                  children: [
                    Expanded( // Place Expanded widget here
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "assets/icons/bolt.png",
                            width: 30,
                          ),
                          const Text(
                            "Discharging  ",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width / 2.3,
                decoration: BoxDecoration(
                  // color: Colors.cyan,
                  color: Color.fromRGBO(203, 197, 255, 1.0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row( // Wrap with a Row
                  children: [
                    Expanded( // Place Expanded widget here
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "assets/icons/health.png",
                            width: 30,
                          ),
                          const Text(
                            "Optimal  ",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildEnergyConsumptionChart(context),
          const SizedBox(height: 15),
          _buildTemperatureChart(data, context),
        ],
      ),
    );
  }

  Widget _buildEnergyConsumptionChart(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        // color: Colors.cyan,
        color: Color.fromRGBO(124, 198, 252, 1.0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(text: "Energy Consumption"),
        series: <AreaSeries<EnergyData, String>>[
          AreaSeries<EnergyData, String>(
            dataSource: <EnergyData>[
              EnergyData('Mon', 10),
              EnergyData('Tue', 18),
              EnergyData('Wed', 34),
              EnergyData('Thur', 32),
              EnergyData('Fri', 40),
              EnergyData('Sat', 32),
              EnergyData('Sun', 40),
            ],
            xValueMapper: (EnergyData energy, _) => energy.time,
            yValueMapper: (EnergyData energy, _) => energy.units,
          )
        ],
      ),
    );
  }

  Widget _buildTemperatureChart(List<TemperatureData> data, BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        // color: Colors.cyan,
        color: Color.fromRGBO(124, 198, 252, 1.0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(),
        primaryYAxis: NumericAxis(
          title: AxisTitle(text: 'Temperature (°C)'),
        ),
        series: <ChartSeries<TemperatureData, DateTime>>[
          LineSeries<TemperatureData, DateTime>(
            dataSource: data,
            xValueMapper: (TemperatureData temperature, _) => temperature.time,
            yValueMapper: (TemperatureData temperature, _) => temperature.temperature,
            name: 'Temperature',
          ),
        ],
      ),
    );
  }
}

class EnergyData {
  EnergyData(this.time, this.units);
  final String time;
  final double units;
}

class TemperatureData {
  final DateTime time;
  final double temperature;

  TemperatureData(this.time, this.temperature);
}
