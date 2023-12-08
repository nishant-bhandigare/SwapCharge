import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Gauge extends StatefulWidget {
  Gauge({super.key, required this.percentage});

  double percentage;

  @override
  State<Gauge> createState() {
    return _GaugeState();
  }
}

class _GaugeState extends State<Gauge> {
  @override
  Widget build(BuildContext context) {
    double batteryPercentage = widget.percentage;
    double size = 145;
    return SizedBox(
      height: size,
      width: size,
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            showLabels: false,
            showTicks: false,
            startAngle: 270,
            endAngle: 270,
            radiusFactor: 0.8,
            axisLineStyle: const AxisLineStyle(
              thickness: 1,
              // color: Color.fromARGB(255, 0, 169, 181),
              color: Color.fromRGBO(0, 161, 255, 1.0),
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                value: batteryPercentage,
                width: 0.15,
                enableAnimation: true,
                animationDuration: 500,
                color: Colors.white,
                pointerOffset: 0.1,
                cornerStyle: CornerStyle.bothCurve,
                animationType: AnimationType.linear,
                sizeUnit: GaugeSizeUnit.factor,
              )
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  positionFactor: 0.5,
                  widget: Text('${batteryPercentage.toStringAsFixed(0)}%',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)))
            ],
          )
        ],
      ),
    );
  }
}
